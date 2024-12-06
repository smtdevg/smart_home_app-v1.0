import 'dart:async';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/provider/base_model.dart';
import 'package:app_smart_home/view/home_view/home.dart';
import 'package:app_smart_home/view/notif_view/notif.dart';
import 'package:app_smart_home/view/setting_view/setting.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:app_smart_home/service/websocket_service.dart';

class HomePageViewModel extends BaseModel {
  final ApiService apiService;
  final WebSocketService webSocketService;

  int selectedIndex = 0;
  final PageController pageController = PageController();
  List<DeviceModel> devices = [];
  Timer? _refreshTimer; // Hẹn giờ để làm mới thiết bị tự động

  HomePageViewModel({
    required this.apiService,
    required this.webSocketService,
  });
  final Map<String, String> endpointMapping = {
    'AirConditioner': 'aircon',
    'Lock': 'lock',
    'Switch': 'switch',
    'Socket': 'socket',
  };

  String getEndpoint(String typeDevice) {
    return endpointMapping[typeDevice] ?? typeDevice.toLowerCase();
  }
  // Lấy danh sách thiết bị từ API
  Future<void> fetchDevices() async {
    try {
      final switches = await apiService.getAllDevices('switch') ?? [];

      devices = switches.map((e) {
        return DeviceModel.fromJson(e, 'Switch'); // Giữ trạng thái đầy đủ (button1, button2)
      }).toList();

      final aircons = await apiService.getAllDevices('aircon') ?? [];
      final locks = await apiService.getAllDevices('lock') ?? [];
      final sockets = await apiService.getAllDevices('socket') ?? [];

      devices = [
        ...aircons.map((e) => DeviceModel.fromJson(e, 'AirConditioner')),
        ...locks.map((e) => DeviceModel.fromJson(e, 'Lock')),
        ...switches.expand((e) {
          final device = DeviceModel.fromJson(e, 'Switch');
          return device.status.keys.map((key) => DeviceModel(
            id: '${device.id}',
            name: '${device.name}',
            type: device.type,
            room: device.room,
            status: {key: device.status[key] ?? false},
            icon: device.icon,
          ));
        }),
        ...sockets.expand((e) {
          final device = DeviceModel.fromJson(e, 'Socket');
          return device.status.keys.map((key) => DeviceModel(
            id: '${device.id}',
            name: '${device.name} - $key',
            type: device.type,
            room: device.room,
            status: {key: device.status[key] ?? false},
            icon: device.icon,
          ));
        }),
      ];

      notifyListeners();
    } catch (e) {
      print('Failed to fetch devices: $e');
    }
  }


  Future<void> toggleDevice(DeviceModel device, [String? buttonKey]) async {
    // Tìm thiết bị trong danh sách
    final deviceIndex = devices.indexWhere((d) => d.id == device.id);
    if (deviceIndex == -1) {
      print("Device not found: ${device.id}");
      return;
    }

    final originalDevice = devices[deviceIndex];

    // Xử lý riêng cho Switch
    if (device.type.toLowerCase() == 'switch' && buttonKey != null) {
      // Cập nhật trạng thái của nút cụ thể
      final updatedStatus = {
        ...originalDevice.status,
        buttonKey: !(originalDevice.status[buttonKey] ?? false), // Đảo ngược trạng thái nút
      };

      // Cập nhật trạng thái cục bộ
      devices[deviceIndex] = DeviceModel(
        id: originalDevice.id,
        name: originalDevice.name,
        type: originalDevice.type,
        room: originalDevice.room,
        status: updatedStatus, // Cập nhật trạng thái mới
        icon: originalDevice.icon,
      );

      notifyListeners(); // Cập nhật giao diện

      // Chuẩn bị payload để gửi lên API
      final payload = {
        "_id": originalDevice.id, // Luôn dùng ID gốc (1123)
        "status": updatedStatus, // Toàn bộ trạng thái (button1 và button2)
        "name": originalDevice.name,
        "typeDevice": originalDevice.type,
        "room": originalDevice.room,
      };

      try {
        // Gửi API với ID chính xác của Switch
        await apiService.updateDeviceStatus('switch', originalDevice.id, payload);
        print("Switch ${originalDevice.id} updated successfully.");
      } catch (e) {
        print("Failed to update switch ${originalDevice.id}: $e");

        // Hoàn nguyên trạng thái nếu có lỗi
        devices[deviceIndex] = originalDevice;
        notifyListeners();
      }
      return; // Kết thúc xử lý cho Switch
    }

    // Xử lý logic chung cho các thiết bị khác
    if (device.type.toLowerCase() != 'switch') {
      final currentStatus = originalDevice.status.values.first ?? false;
      final updatedStatus = {
        ...originalDevice.status,
        'on': !currentStatus, // Đảo ngược trạng thái 'on' cho các thiết bị khác
      };

      // Cập nhật trạng thái cục bộ
      devices[deviceIndex] = DeviceModel(
        id: originalDevice.id,
        name: originalDevice.name,
        type: originalDevice.type,
        room: originalDevice.room,
        status: updatedStatus,
        icon: originalDevice.icon,
      );

      notifyListeners();

      // Chuẩn bị endpoint và payload cho các thiết bị khác
      final endpoint = getEndpoint(originalDevice.type); // Lấy endpoint phù hợp
      final payload = {'status': updatedStatus};

      try {
        await apiService.updateDeviceStatus(endpoint, originalDevice.id, payload);
        print("Device ${originalDevice.id} updated successfully.");
      } catch (e) {
        print("Failed to update device ${originalDevice.id}: $e");

        // Hoàn nguyên trạng thái nếu có lỗi
        devices[deviceIndex] = originalDevice;
        notifyListeners();
      }
    }
  }









  // Bắt đầu làm mới tự động
  void startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await fetchDevices();
    });
  }

  // Dừng làm mới tự động
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  //Navbar/// Phần này bị lỗi overscale nên kh sử dụng
  void onItemTapped(BuildContext context, int index) {
    selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(HomePage.routeName);
        break;
      case 1:
        Navigator.of(context).pushNamed(NotificationPage.routeName);
        break;
      case 2:
        Navigator.of(context).pushNamed(HomePage.routeName);
        break;
      case 3:
        Navigator.of(context).pushNamed(SettingPage.routeName);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}
