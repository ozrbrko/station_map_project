import 'package:flutter/material.dart';
import 'package:pandabar/pandabar.dart';
import 'package:station_map_project/map_page.dart';


class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  String page = 'Station';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(

        backgroundColor: Colors.white,
        buttonData: [
          PandaBarButtonData(
            id: 'Home',
            icon: Icons.home,
            title: 'Ana Sayfa',
          ),
          PandaBarButtonData(
              id: 'Assistant',
              icon: Icons.comment,
              title: 'Asistan'
          ),
          PandaBarButtonData(
              id: 'Station',
              icon: Icons.location_pin,
              title: 'İstasyonlar'
          ),
          PandaBarButtonData(
              id: 'Menu',
              icon: Icons.menu,
              title: 'Menü'
          ),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {

        },
      ),
      body: Builder(
        builder: (context) {

          switch (page) {
            case 'Home':
              return MapPage();
            case 'Assistant':
              return MapPage();
            case 'Station':
              return MapPage();
            case 'Menu':
              return MapPage();
            default:
              return MapPage();

          }

        },
      ),
    );
  }
}