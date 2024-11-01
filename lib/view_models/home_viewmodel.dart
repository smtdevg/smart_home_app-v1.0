import 'package:app_smart_home/models/sk_model.dart';
import 'package:app_smart_home/provider/base_model.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class HomePageViewModel extends BaseModel {
  //-------------VARIABLES-------------//
  int selectedIndex = 0;
  int randomNumber = 1;
  final PageController pageController = PageController();
  bool isSocketOn = false;
  bool isACON = false;
  bool isSwitch1On = false;
  bool isSwitch2On = true;
  bool isSwitch1Fav = false;
  bool isSwitch2Fav = false;
  bool isSocketFav = false;
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

  void socketFav() {
    isSocketFav = !isSocketFav;
    notifyListeners();
  }

  void acSwitch() {
    isACON = !isACON;
    notifyListeners();
  }

  void skSwitch() {
    isSocketOn = !isSocketOn;
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
  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }
}
