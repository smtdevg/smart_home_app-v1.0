import 'package:app_smart_home/provider/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ACViewModel extends BaseModel {
  bool isACon = true;
  double temperature = 26;  // Giá trị nhiệt độ
  List<bool> isSelected = [true, false, false, false]; // Trạng thái chế độ gió
  List<bool> isSelected1 = [true, false, false, false]; // Trạng thái tốc độ quạt

  ACViewModel() {
    loadState();
  }

  // Lưu trạng thái vào SharedPreferences
  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isACon', isACon);
    await prefs.setDouble('temperature', temperature);
    await prefs.setStringList('isSelected', isSelected.map((e) => e.toString()).toList());
    await prefs.setStringList('isSelected1', isSelected1.map((e) => e.toString()).toList());
  }

  // Tải trạng thái từ SharedPreferences
  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    isACon = prefs.getBool('isACon') ?? true;
    temperature = prefs.getDouble('temperature') ?? 26;
    isSelected = prefs.getStringList('isSelected')?.map((e) => e == 'true').toList() ?? [true, false, false, false];
    isSelected1 = prefs.getStringList('isSelected1')?.map((e) => e == 'true').toList() ?? [true, false, false, false];
    notifyListeners();
  }

  // Cập nhật trạng thái và lưu lại
  void setTemperature(double value) {
    temperature = value;
    saveState();
    notifyListeners();
  }

  void onToggleTapped(int index) {
    isSelected = [false, false, false, false];
    isSelected[index] = true;
    saveState();
    notifyListeners();
  }

  void onToggleTapped1(int index) {
    isSelected1 = [false, false, false, false];
    isSelected1[index] = true;
    saveState();
    notifyListeners();
  }

  void acSwitch(bool value) {
    isACon = value;
    saveState();
    notifyListeners();
  }
}
