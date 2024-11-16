import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://192.168.1.155:1601'; // Địa chỉ API

  // Phương thức thêm hoặc cập nhật thông tin điều hòa
  Future<Map<String, dynamic>> addAirConditioner(
      Map<String, dynamic> acData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/aircon/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(acData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Trả về dữ liệu nếu thành công
    } else {
      throw Exception('Failed to update Air Conditioner');
    }
  }

  // Hàm lấy trạng thái của một thiết bị
  Future<Map<String, dynamic>> getDeviceStatus(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/device_status/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load device status');
    }
  }

  // Phương thức cập nhật trạng thái thiết bị
  Future<void> updateDeviceStatus(String id, bool status) async {
    final response = await http.post(
      Uri.parse('$apiUrl/device/$id/update_status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode == 200) {
      print("Device $id status updated successfully.");
    } else {
      print("Failed to update device $id status: ${response.body}");
      throw Exception("Failed to update device status.");
    }
  }
}
