import 'package:app_smart_home/models/sk_model.dart';
import 'package:app_smart_home/provider/base_model.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:app_smart_home/view/home_view/home.dart';
import 'package:app_smart_home/view/notif_view/notif.dart';
import 'package:app_smart_home/view/setting_view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class HomePageViewModel extends BaseModel {
  int selectedIndex = 0;
  int randomNumber = 1;
  final PageController pageController = PageController();
  bool isSocket1On = false;
  bool isSocket2On = false;
  bool isACON = false;
  bool isSwitch1On = false;
  bool isSwitch2On = false;
  bool isSwitch1Fav = false;
  bool isSwitch2Fav = false;
  bool isSocket1Fav = false;
  bool isSocket2Fav = false;
  bool isACFav = false;

  void generateRandomNumber() {
    randomNumber = Random().nextInt(8);
    notifyListeners();
  }

  void switch1Fav() {
    isSwitch1Fav = !isSwitch1Fav;
    notifyListeners();
  }

  void switch2Fav() {
    isSwitch2Fav = !isSwitch2Fav;
    notifyListeners();
  }

  void acFav() {
    isACFav = !isACFav;
    notifyListeners();
  }

  void socket1Fav() {
    isSocket1Fav = !isSocket1Fav;
    notifyListeners();
  }
  void socket2Fav() {
    isSocket2Fav = !isSocket2Fav;
    notifyListeners();
  }


  void acSwitch() {
    isACON = !isACON;
    notifyListeners();
  }

  void sk1Switch() {
    isSocket1On = !isSocket1On;
    notifyListeners();
  }
  void sk2Switch() {
    isSocket2On = !isSocket2On;
    notifyListeners();
  }
  void Switch1() {
    isSwitch1On = !isSwitch1On;
    notifyListeners();
  }

  void Switch2() {
    isSwitch2On = !isSwitch2On;
    notifyListeners();
  }

  ///On tapping bottom nav bar items
  void onItemTapped(BuildContext context, int index) {
    selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(HomePage.routeName);
        break;
      case 1:
        Navigator.of(context).pushNamed(NotificationPage.routeName);
        break;
      case 2:
        Navigator.of(context).pushNamed(HomePage.routeName);
        break;
      case 3:
        Navigator.of(context).pushNamed(SettingPage.routeName);
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
