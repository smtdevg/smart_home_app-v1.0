import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:app_smart_home/provider/base_model.dart';

class ACViewModel extends BaseModel {
  final ApiService apiService;

  bool isACon = true; // Trạng thái bật/tắt của điều hòa
  double temperature = 25; // Giá trị nhiệt độ
  int mode = 1;
  int fanSpeed = 1;
  List<bool> isSelected = [true, false, false, false]; // Chế độ gió
  List<bool> isSelected1 = [true, false, false, false]; // Tốc độ quạt
  String? errorMessage; // Biến lưu lỗi nếu có

  Timer? _syncTimer; // Timer để đồng bộ trạng thái định kỳ

  ACViewModel(this.apiService) {
    loadState();
    fetchACStatus(); // Tải trạng thái từ server khi khởi tạo
    startSync(); // Bắt đầu đồng bộ định kỳ
  }

  // Khởi động liền đồng bộ định kỳ với server
  void startSync() {
    _syncTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      fetchACStatus();
    });
  }

  // Dừng đồng bộ
  void stopSync() {
    _syncTimer?.cancel();
  }

  @override
  void dispose() {
    stopSync();
    super.dispose();
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

  // Lấy trạng thái từ server
  Future<void> fetchACStatus() async {
    try {
      final acStatus = await apiService.getDeviceStatus("aircon","1"); // ID của thiết bị
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
      errorMessage = null; // Xóa thông báo lỗi nếu thành công
      notifyListeners();
    } catch (e) {
      errorMessage = "Không thể kết nối đến server: $e";
      print("Failed to fetch Air Conditioner status: $e");
      notifyListeners();
    }
  }

  // Gửi trạng thái tới server
  Future<void> updateACStatus() async {
    final acData = {
      "_id": 1, // ID thiết bị
      "name": "Living Room AC",
      "typeDevice": "AirConditioner",
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
      errorMessage = null; // Xóa thông báo lỗi nếu thành công
    } catch (e) {
      errorMessage = "Không thể cập nhật trạng thái: $e";
      print("Failed to update Air Conditioner status: $e");
      notifyListeners();
    }
  }

  // Cập nhật trạng thái nhiệt độ
  void setTemperature(double value) {
    temperature = value.roundToDouble();
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
    fanSpeed = index + 1;
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
