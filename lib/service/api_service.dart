import 'dart:convert';
import 'package:http/http.dart' as http;
import '../view/setting_view/config.dart';

class ApiService {
  final String apiUrl = ConfigManager().apiUrl;

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


  // Hàm lấy trạng thái của một thiết bị bất kỳ
  Future<Map<String, dynamic>> getDeviceStatus(String deviceType, String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$deviceType/get/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load $deviceType status for device $id');
    }
  }


  //  Cập nhật 1 thiết bị
  Future<void> updateDeviceStatus(String endpoint, String id, Map<String, dynamic> status) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$endpoint/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}), // Gửi toàn bộ trạng thái
    );

    if (response.statusCode == 200) {
      print("Device $id status updated successfully.");
    } else {
      print("Failed to update device $id status: ${response.body}");
      throw Exception("Failed to update device status.");
    }
  }


  // Lấy tất cả các thiết bị của một loại (switch, socket, aircon, lock)
  Future<List<Map<String, dynamic>>> getAllDevices(String deviceType) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$deviceType/getall'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      try {
        final List<dynamic> devices = jsonDecode(response.body);
        return devices.cast<Map<String, dynamic>>();
      } catch (e) {
        throw Exception('Invalid JSON format: ${response.body}');
      }
    } else {
      print('Error response: ${response.statusCode} ${response.body}');
      throw Exception('Failed to fetch devices of type $deviceType');
    }
  }
}

