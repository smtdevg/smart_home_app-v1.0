import 'dart:convert';
import 'package:http/http.dart' as http;
import '../view/setting_view/config.dart';
import 'package:app_smart_home/service/websocket_service.dart';

class ApiService {
  final String apiUrl = ConfigManager().apiUrl;
  final WebSocketService webSocketService; // Đã thêm WebSocketService làm thuộc tính

  // Constructor thêm WebSocketService
  ApiService({required this.webSocketService});

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
  Future<void> updateDeviceStatus(String endpoint, String id, dynamic status) async {
    webSocketService.sendDeviceStatus({'payload':status
    });
    final response = await http.put(
      Uri.parse('$apiUrl/$endpoint/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(status), // Gửi trực tiếp status mà không cần bọc trong key-value
    );

    if (response.statusCode == 200) {
      print("Cập nhật trạng thái thiết bị $id thành công: $status.");
    } else {
      print("Không thể cập nhật trạng thái thiết bị $id: ${response.body}");
      throw Exception("Không thể cập nhật trạng thái thiết bị.");
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

