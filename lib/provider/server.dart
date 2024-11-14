import 'package:flutter/material.dart';

class ServerAddressProvider with ChangeNotifier {
  String _serverAddress = '';

  String get serverAddress => _serverAddress;

  void setServerAddress(String address) {
    _serverAddress = address;
    notifyListeners();
  }
}
