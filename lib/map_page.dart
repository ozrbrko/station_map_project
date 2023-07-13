import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:station_map_project/frame_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'get_marker_data.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  BitmapDescriptor? customIcon;

  List<MapMarker> markers = [];

  InfoItem? _selectedStartStation; // Seçili başlangıç istasyonu
  InfoItem? _selectedEndStation; // Seçili bitiş istasyonu

  @override
  void initState() {
    super.initState();
    _createCustomIcon();
    markers = getMarkerData().cast<MapMarker>();
  }

  void _createCustomIcon() async {
    Uint8List? compressedImage = await FlutterImageCompress.compressAssetImage(
      'assets/logo_guris.png',
      minHeight: 64,
      minWidth: 64,
      // quality: 75,
    );

    setState(() {
      customIcon = BitmapDescriptor.fromBytes(compressedImage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(41.0082, 28.9784), // Başlangıç konumu
              zoom: 4.0,
            ),
            markers: markers.map((marker) {
              int infoCount = marker.infoList.length;
              String markerId = marker.id;
              String markerTitle = infoCount > 1 ? '$infoCount' : '';

              return Marker(
                markerId: MarkerId(markerId),
                position: marker.position,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: infoCount,
                        itemBuilder: (BuildContext context, int index) {
                          InfoItem infoItem = marker.infoList[index];

                          return ListTile(
                            title: Text(infoItem.title),
                            onTap: () {
                              _startDirectionsDirect(
                                  infoItem.latitude, infoItem.longitude);
                            },
                          );
                        },
                      );
                    },
                  );
                },
                icon: customIcon != null
                    ? customIcon!
                    : BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  title: markerTitle,
                ),
              );
            }).toSet(),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            padding: EdgeInsets.only(top: 40.0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
            child: InkWell(
              onTap: () {
                _showSearchDialog();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.white70),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 20,
                  ),
                  Text("İstasyon Ara"),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 120.0),
            child: ElevatedButton(
              onPressed: () {
                _showDirectionsDialog(null);
              },
              child: Text("İstasyon arası yol tarifi"),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Arama'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<InfoItem>(
                value: null,
                hint: Text('İstasyon Ara'),
                items: markers
                    .expand((marker) => marker.infoList)
                    .map((infoItem) => DropdownMenuItem<InfoItem>(
                          value: infoItem,
                          child: Text(infoItem.title),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStartStation = value;
                    if (value != null) {
                      _goToLocation(value.latitude, value.longitude);
                    }
                  });
                },
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: FrameSize.screenWidth,
              child: ElevatedButton(
                child: Text('İstasyonu Görüntüle'),
                onPressed: () {
                  if (_selectedStartStation != null) {
                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: Text('Lütfen geçerli bir istasyon seçin.'),
                          actions: [
                            TextButton(
                              child: Text('Tamam'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDirectionsDialog(InfoItem? selectedInfoItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yol Tarifi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<InfoItem>(
                value: selectedInfoItem,
                hint: Text('Başlangıç İstasyonu'),
                items: markers
                    .expand((marker) => marker.infoList)
                    .map((infoItem) => DropdownMenuItem<InfoItem>(
                          value: infoItem,
                          child: Text(infoItem.title),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStartStation = value;
                  });
                },
              ),
              DropdownButtonFormField<InfoItem>(
                value: null,
                hint: Text('Bitiş İstasyonu'),
                items: markers
                    .expand((marker) => marker.infoList)
                    .map((infoItem) => DropdownMenuItem<InfoItem>(
                          value: infoItem,
                          child: Text(infoItem.title),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedEndStation = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: FrameSize.screenWidth,
              child: ElevatedButton(
                child: Text('Yol Tarifi Başlat'),
                onPressed: () {
                  if (_selectedStartStation != null &&
                      _selectedEndStation != null) {
                    _startDirections(
                      _selectedStartStation!.latitude,
                      _selectedStartStation!.longitude,
                      _selectedEndStation!.latitude,
                      _selectedEndStation!.longitude,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: Text('Lütfen geçerli istasyonları seçin.'),
                          actions: [
                            TextButton(
                              child: Text('Tamam'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _goToLocation(double latitude, double longitude) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(latitude, longitude),
        16.0,
      ),
    );
  }

  void _startDirections(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) async {
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$endLatitude,$endLongitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Yol tarifi başlatılamıyor: $url';
    }
  }

  void _startDirectionsDirect(double latitude, double longitude) async {
    String url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Yol tarifi başlatılamıyor: $url';
    }
  }
}
