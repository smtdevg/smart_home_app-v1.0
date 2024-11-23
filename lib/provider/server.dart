import 'package:flutter/material.dart';

class ServerAddressProvider with ChangeNotifier {
  String _ipAddress = "192.168.1.1"; // Địa chỉ IP mặc định

  String get ipAddress => _ipAddress;

  void setIpAddress(String newIp) {
    _ipAddress = newIp;
    notifyListeners(); // Thông báo cho các widget đang sử dụng provider
  }

  String getApiUrl(String endpoint) {
    return "http://$_ipAddress:1601/$endpoint";
  }

  String getWebSocketUrl() {
    return "ws://$_ipAddress:1901";
  }
}
