import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://192.168.30.155:1601';

  Future<void> updateDeviceStatus(String id, bool status) async {
    final response = await http.post(
      Uri.parse('$apiUrl/update_status'),
      body: jsonEncode({
        'id': id,
        'status': status,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print("Status updated successfully");
    } else {
      print("Failed to update status");
    }
  }
}
