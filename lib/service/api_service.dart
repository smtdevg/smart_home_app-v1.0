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
  Future<void> updateDeviceStatus(String deviceType,id, bool status) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$deviceType/update/$id'),
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

Future<List<Map<String, dynamic>>> getAllDevices(String deviceType) async {
  final response = await http.get(
    Uri.parse('$apiUrl/$deviceType/getall'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    try {
      final List<dynamic> devices = jsonDecode(response.body);
      return devices.cast<Map<String, dynamic>>(); // Trả về danh sách các thiết bị
    } catch (e) {
      throw Exception('Invalid JSON format: ${response.body}');
    }
  } else {
    print('Error response: ${response.statusCode} ${response.body}');
    throw Exception('Failed to fetch devices of type $deviceType');
  }
}

