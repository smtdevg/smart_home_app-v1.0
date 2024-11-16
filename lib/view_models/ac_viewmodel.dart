import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:app_smart_home/provider/base_model.dart';

class ACViewModel extends BaseModel {
  final ApiService apiService;

  bool isACon = true;
  double temperature = 26; // Giá trị nhiệt độ
  int mode = 2; // Chế độ gió (default: Cool)
  int fanSpeed = 3; // Tốc độ quạt (default: Medium)
  List<bool> isSelected = [true, false, false, false]; // Trạng thái chế độ gió
  List<bool> isSelected1 = [
    true,
    false,
    false,
    false
  ]; // Trạng thái tốc độ quạt

  ACViewModel(this.apiService) {
    loadState();
    fetchACStatus(); // Tải trạng thái từ server khi khởi tạo
  }

  // Lưu trạng thái vào SharedPreferences
  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isACon', isACon);
    await prefs.setDouble('temperature', temperature);
    await prefs.setInt('mode', mode);
    await prefs.setInt('fanSpeed', fanSpeed);
    await prefs.setStringList(
        'isSelected', isSelected.map((e) => e.toString()).toList());
    await prefs.setStringList(
        'isSelected1', isSelected1.map((e) => e.toString()).toList());
  }

  // Tải trạng thái từ SharedPreferences
  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    isACon = prefs.getBool('isACon') ?? true;
    temperature = prefs.getDouble('temperature') ?? 26;
    mode = prefs.getInt('mode') ?? 2;
    fanSpeed = prefs.getInt('fanSpeed') ?? 3;
    isSelected =
        prefs.getStringList('isSelected')?.map((e) => e == 'true').toList() ??
            [true, false, false, false];
    isSelected1 =
        prefs.getStringList('isSelected1')?.map((e) => e == 'true').toList() ??
            [true, false, false, false];
    notifyListeners();
  }

  // Gửi trạng thái tới server qua API
  Future<void> updateACStatus() async {
    final acData = {
      "_id": 1, // ID thiết bị
      "name": "Living Room AC",
      "typeDevice": "AirConditioner",
      "room": "Living Room",
      "status": {
        "on": isACon,
        "temp": temperature,
        "mode": mode,
        "fanSpeed": fanSpeed,
        "swing": false, // Tạm thời cố định
      }
    };

    try {
      await apiService.addAirConditioner(acData);
      print("Air Conditioner status updated successfully.");
    } catch (e) {
      print("Failed to update Air Conditioner status: $e");
      // Nếu HTTP request thất bại, tự động chuyển trạng thái về off
      Future.delayed(const Duration(seconds: 1), () {
        isACon = false;
        saveState();
        notifyListeners();
        print("AC automatically turned off due to error.");
      });
    }
  }

  // Lấy trạng thái từ server
  Future<void> fetchACStatus() async {
    try {
      final acStatus = await apiService.getDeviceStatus("1"); // ID thiết bị
      isACon = acStatus['status']['on'];
      temperature = acStatus['status']['temp'];
      mode = acStatus['status']['mode'];
      fanSpeed = acStatus['status']['fanSpeed'];

      // Cập nhật chế độ gió
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = (i + 1) == mode;
      }

      // Cập nhật tốc độ quạt
      for (int i = 0; i < isSelected1.length; i++) {
        isSelected1[i] = (i + 1) == fanSpeed;
      }

      saveState();
      notifyListeners();
    } catch (e) {
      print("Failed to fetch Air Conditioner status: $e");
    }
  }

  // Cập nhật trạng thái nhiệt độ
  void setTemperature(double value) {
    temperature = value;
    updateACStatus();
    saveState();
    notifyListeners();
  }

  // Cập nhật chế độ gió
  void onToggleTapped(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    mode = index + 1;
    updateACStatus();
    saveState();
    notifyListeners();
  }

  // Cập nhật tốc độ quạt
  void onToggleTapped1(int index) {
    for (int i = 0; i < isSelected1.length; i++) {
      isSelected1[i] = i == index;
    }
    fanSpeed = index + 1; // Cập nhật tốc độ quạt
    updateACStatus();
    saveState();
    notifyListeners();
  }

  // Bật/Tắt điều hòa
  void acSwitch(bool value) {
    isACon = value;
    updateACStatus();
    saveState();
    notifyListeners();
  }
}
