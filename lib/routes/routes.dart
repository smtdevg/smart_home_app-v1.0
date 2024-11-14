import 'package:app_smart_home/view/ac_view/ac.dart';
import 'package:app_smart_home/view/home_view/home.dart';
import 'package:app_smart_home/view/notif_view/notif.dart';
import 'package:app_smart_home/view/setting_view/setting.dart';
import 'package:app_smart_home/view/menu_view/menu.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => const HomePage(),
  SettingPage.routeName: (context) => const SettingPage(),
  ACPage.routeName: (context) => const ACPage(),
  NotificationPage.routeName: (context) => const NotificationPage(),
  MenuPage.routeName: (context) => const MenuPage()
};
