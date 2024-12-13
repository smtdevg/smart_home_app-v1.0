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
      // Lấy danh sách thiết bị từ các API
      final switches = await apiService.getAllDevices('switch') ?? [];
      final aircons = await apiService.getAllDevices('aircon') ?? [];
      final locks = await apiService.getAllDevices('lock') ?? [];
      final sockets = await apiService.getAllDevices('socket') ?? [];

      // Xử lý riêng cho Switch và Socket để giữ 2 widget cho mỗi switch
      devices = [
        // AirConditioner
        ...aircons.map((e) => DeviceModel.fromJson(e, 'AirConditioner')),

        // Lock
        ...locks.map((e) => DeviceModel.fromJson(e, 'Lock')),

        // Switch: Mỗi Switch sẽ có 2 button, button1 và button2
        ...switches.map((e) => DeviceModel.fromJson(e, 'Switch')),

        // Socket: Tạo 1 widget cho mỗi socket
        ...sockets.map((e) => DeviceModel.fromJson(e, 'Socket')),
      ];

      // Thông báo cho giao diện cập nhật
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
      final updatedStatus = {
        ...originalDevice.status,
        buttonKey: !(originalDevice.status[buttonKey] ?? false),
      };

      // Cập nhật trạng thái cục bộ của Switch
      devices[deviceIndex] = DeviceModel(
        id: originalDevice.id,
        name: originalDevice.name,
        type: originalDevice.type,
        room: originalDevice.room,
        status: updatedStatus,
        icon: originalDevice.icon,
      );

      notifyListeners();

      // Chuẩn bị payload để gửi lên API
      final payload = {
        "_id": originalDevice.id,
        "status": updatedStatus,
        // "name": originalDevice.name,
        "typeDevice": originalDevice.type,
        // "room": originalDevice.room,
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

    // Xử lý riêng cho Switch
    if (device.type.toLowerCase() == 'socket' && buttonKey != null) {
      final updatedStatus = {
        ...originalDevice.status,
        buttonKey: !(originalDevice.status[buttonKey] ?? false),
      };

      // Cập nhật trạng thái cục bộ của Switch
      devices[deviceIndex] = DeviceModel(
        id: originalDevice.id,
        name: originalDevice.name,
        type: originalDevice.type,
        room: originalDevice.room,
        status: updatedStatus,
        icon: originalDevice.icon,
      );

      notifyListeners(); // Cập nhật giao diện

      // Chuẩn bị payload để gửi lên API
      final payload = {
        "_id": originalDevice.id, // Luôn dùng ID gốc (1123)
        "status": updatedStatus, // Toàn bộ trạng thái (button1 và button2)
        // "name": originalDevice.name,
        "typeDevice": originalDevice.type,
        // "room": originalDevice.room,
      };

      try {
        // Gửi API với ID chính xác của Switch
        await apiService.updateDeviceStatus('socket', originalDevice.id, payload);
        print("Switch ${originalDevice.id} updated successfully. $payload");
      } catch (e) {
        print("Failed to update switch ${originalDevice.id}: $e");

        // Hoàn nguyên trạng thái nếu có lỗi
        devices[deviceIndex] = originalDevice;
        notifyListeners();
      }
      return; // Kết thúc xử lý cho Switch
    }

    // Xử lý logic chung cho các thiết bị khác (AirConditioner, Socket, Lock,...)
    final currentStatus = originalDevice.status.values.first ?? false;
    final updatedStatus = {
      ...originalDevice.status,
      'on': !currentStatus, // Đảo ngược trạng thái 'on' cho các thiết bị khác
    };

    devices[deviceIndex] = DeviceModel(
      id: originalDevice.id,
      name: originalDevice.name,
      type: originalDevice.type,
      room: originalDevice.room,
      status: updatedStatus,
      icon: originalDevice.icon,
    );

    notifyListeners();

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
