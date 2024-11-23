import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_smart_home/models/sw_model.dart';

class SwitchApiService {
  final String apiBaseUrl = 'http://192.168.100.230:1601';

  // Get switch data by ID
  Future<SwitchModel> getSwitchData(int id) async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/switch/get/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SwitchModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load switch data');
    }
  }

  // Update switch status by ID
  Future<void> updateSwitchStatus(int id, SwitchStatusModel status) async {
    final response = await http.put(
      Uri.parse('$apiBaseUrl/switch/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(status.toJson()),
    );

    if (response.statusCode == 200) {
      print('Switch $id status updated successfully.');
    } else {
      print('Failed to update switch status: ${response.body}');
      throw Exception('Failed to update switch status');
    }
  }
}
