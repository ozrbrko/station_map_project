import 'package:google_maps_flutter/google_maps_flutter.dart';


List<MapMarker> getMarkerData() {
  return [
    MapMarker(
      id: 'station1',
      position: LatLng(41.0128, 28.9767),
      infoList: [
        InfoItem(
          title: 'İstasyon 1',
          latitude: 41.0128,
          longitude: 28.9767,
        ),
        InfoItem(
          title: 'İstasyon 2',
          latitude: 41.0126,
          longitude: 28.9769,
        ),
        InfoItem(
          title: 'İstasyon 3',
          latitude: 41.0129,
          longitude: 28.9765,
        ),
      ],
    ),
    MapMarker(
      id: 'station2',
      position: LatLng(41.0189, 28.9724),
      infoList: [
        InfoItem(
          title: 'İstasyon 4',
          latitude: 41.0189,
          longitude: 28.9724,
        ),
        InfoItem(
          title: 'İstasyon 5',
          latitude: 41.0190,
          longitude: 28.9722,
        ),
      ],
    ),
    MapMarker(
      id: 'station3',
      position: LatLng(41.015, 28.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 6',
          latitude: 41.015,
          longitude: 28.979,
        ),
      ],
    ),
    MapMarker(
      id: 'station4',
      position: LatLng(41.014, 28.981),
      infoList: [
        InfoItem(
          title: 'İstasyon 7',
          latitude: 41.014,
          longitude: 28.981,
        ),
      ],
    ),
    MapMarker(
      id: 'station5',
      position: LatLng(41.011, 28.975),
      infoList: [
        InfoItem(
          title: 'İstasyon 8',
          latitude: 41.011,
          longitude: 28.975,
        ),
      ],
    ),
    MapMarker(
      id: 'station6',
      position: LatLng(41.016, 28.977),
      infoList: [
        InfoItem(
          title: 'İstasyon 9',
          latitude: 41.016,
          longitude: 28.977,
        ),
      ],
    ),

    MapMarker(
      id: 'station8',
      position: LatLng(39.019, 24.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 11',
          latitude: 39.019,
          longitude: 24.979,
        ),
      ],
    ),
    MapMarker(
      id: 'station9',
      position: LatLng(39.239997, 32.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 12',
          latitude: 39.239997,
          longitude: 32.979,
        ),
      ],
    ),

    MapMarker(
      id: 'station10',
      position: LatLng(39.235997, 32.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 13',
          latitude: 39.235997,
          longitude: 32.979,
        ),
      ],
    ),
    MapMarker(
      id: 'station11',
      position: LatLng(39.835997, 32.531042),
      infoList: [
        InfoItem(
          title: 'İstasyon 14',
          latitude: 39.835997,
          longitude: 32.531042,
        ),

        InfoItem(
          title: 'İstasyon 25',
          latitude: 39.835998,
          longitude: 32.531042,
        ),

        InfoItem(
          title: 'İstasyon 26',
          latitude: 39.835999,
          longitude: 32.531042,
        ),

        InfoItem(
          title: 'İstasyon 27',
          latitude: 39.835992,
          longitude: 32.531042,
        ),


      ],
    ),
    MapMarker(
      id: 'station12',
      position: LatLng(39.019, 32.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 15',
          latitude: 39.019,
          longitude: 32.979,
        ),
      ],
    ),
    MapMarker(
      id: 'station13',
      position: LatLng(39.319, 35.929),
      infoList: [
        InfoItem(
          title: 'İstasyon 16',
          latitude: 39.319,
          longitude: 35.929,
        ),
      ],
    ),
    MapMarker(
      id: 'station14',
      position: LatLng(37.019, 25.979),
      infoList: [
        InfoItem(
          title: 'İstasyon 17',
          latitude: 37.019,
          longitude: 25.979,
        ),
      ],
    ),
  ];
}

class MapMarker {
  final String id;
  final LatLng position;
  final List<InfoItem> infoList;

  MapMarker({
    required this.id,
    required this.position,
    required this.infoList,
  });
}

class InfoItem {
  final String title;
  final double latitude;
  final double longitude;

  InfoItem({
    required this.title,
    required this.latitude,
    required this.longitude,
  });
}