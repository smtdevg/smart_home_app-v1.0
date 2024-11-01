import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomePageViewModel model;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: model.selectedIndex,
      selectedItemColor: Colors.black,
      elevation: 0,
      onTap: model.onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: '',
          icon: Icon(FontAwesomeIcons.house),
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(FontAwesomeIcons.bell),
          backgroundColor: Colors.lightBlue,
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(FontAwesomeIcons.noteSticky),
          backgroundColor: Colors.lightBlue,
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(FontAwesomeIcons.gear),
          backgroundColor: Colors.lightBlue,
        ),
      ],
    );
  }
}
