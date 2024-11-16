import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAddressProvider extends ChangeNotifier {
  String _ipAddress = '192.168.1.155'; // Giá trị mặc định nếu chưa có

  String get ipAddress => _ipAddress;

  String get apiHost => 'http://$_ipAddress:1601';
  String get webSocketHost => 'ws://$_ipAddress:1901';

  ServerAddressProvider() {
    _loadIpAddress();
  }

  get serverAddress => null;

  Future<void> _loadIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    _ipAddress = prefs.getString('server_ip') ?? _ipAddress;
    notifyListeners();
  }

  Future<void> setIpAddress(String ip) async {
    _ipAddress = ip;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_ip', ip);
    notifyListeners();
  }

  void setServerAddress(String newServerAddress) {}
}
