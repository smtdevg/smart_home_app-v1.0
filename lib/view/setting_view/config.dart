import 'package:shared_preferences/shared_preferences.dart';

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();
  String apiUrl = "http://192.168.100.203:1601"; // Giá trị mặc định
  String websocketUrl = "ws://192.168.100.203:1901"; // Giá trị mặc định

  factory ConfigManager() {
    return _instance;
  }

  ConfigManager._internal();

  // Cập nhật địa chỉ IP
  Future<void> updateIpAddress(String ipAddress) async {
    apiUrl = "http://$ipAddress:1601";
    websocketUrl = "ws://$ipAddress:1901";

    // Lưu giá trị mới vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ipAddress', ipAddress);
  }

  // Tải địa chỉ IP từ SharedPreferences
  Future<void> loadIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIp = prefs.getString('ipAddress');

    if (savedIp != null && savedIp.isNotEmpty) {
      apiUrl = "http://$savedIp:1601";
      websocketUrl = "ws://$savedIp:1901";
    }
  }
}
