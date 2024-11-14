import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class MenuPage extends StatelessWidget {
  static String routeName = '/menu_page';
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getProportionateScreenHeight(50),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('Menu'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.of(context).pushNamed('/setting_page');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () {
              Navigator.of(context).pushNamed('/notification_page');
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text("Devices"),
            onTap: () {
              Navigator.of(context).pushNamed('/device_page');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            onTap: () {
              Navigator.of(context).pushNamed('/about_us_page');
            },
          ),
        ],
      ),
    );
  }
}