import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://192.168.100.203:1601'; // Địa chỉ API

  // Phương thức thêm hoặc cập nhật thông tin điều hòa
  Future<Map<String, dynamic>> addAirConditioner(
      Map<String, dynamic> acData) async {
    final response = await http.put(
      Uri.parse('$apiUrl/aircon/update/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(acData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Trả về dữ liệu nếu thành công
    } else {
      throw Exception('Failed to update Air Conditioner');
    }
  }

  // Lấy trạng thái của điều hòa từ API
  Future<Map<String, dynamic>> getAirconStatus(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/aircon/get/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Trả về dữ liệu JSON của điều hòa
    } else {
      throw Exception('Failed to fetch Aircon status');
    }
  }

  // Hàm lấy trạng thái của một thiết bị bất kỳ
  Future<Map<String, dynamic>> getDeviceStatus(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/aircon/get/$id'),
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
