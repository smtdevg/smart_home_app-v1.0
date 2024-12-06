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

  // Lấy danh sách thiết bị từ API
  Future<void> fetchDevices() async {
    try {
      final aircons = await apiService.getAllDevices('aircon') ?? [];
      final locks = await apiService.getAllDevices('lock') ?? [];
      final switches = await apiService.getAllDevices('switch') ?? [];
      final sockets = await apiService.getAllDevices('socket') ?? [];

      devices = [
        ...aircons.map((e) {
          print('Aircon data: $e'); // Log dữ liệu từng thiết bị
          return DeviceModel.fromJson(e, 'airconditioner');
        }),
        ...locks.map((e) => DeviceModel.fromJson(e, 'lock')),
        ...switches.map((e) => DeviceModel.fromJson(e, 'switch')),
        ...sockets.map((e) => DeviceModel.fromJson(e, 'socket')),
      ];

      print('Devices after mapping: $devices'); // Log toàn bộ danh sách thiết bị
      notifyListeners();
    } catch (e) {
      print('Failed to fetch devices: $e');
    }
  }





  Future<void> toggleDevice(DeviceModel device) async {
    String statusKey;

    // Xác định khóa trạng thái dựa trên loại thiết bị
    switch (device.type.toLowerCase()) {
      case 'airconditioner':
        statusKey = 'on';
        break;
      case 'lock':
        statusKey = 'button';
        break;
      case 'switch':
        statusKey = 'button1'; // Hoặc xử lý cho 'button2' nếu cần
        break;
      case 'socket':
        statusKey = 'on';
        break;
      default:
        print("Unknown device type: ${device.type}");
        return;
    }

    final bool currentStatus = device.status[statusKey] ?? false; // Lấy trạng thái hiện tại
    final bool newStatus = !currentStatus; // Đảo ngược trạng thái

    // Cập nhật trạng thái cục bộ ngay lập tức
    final deviceIndex = devices.indexWhere((d) => d.id == device.id);
    if (deviceIndex == -1) return;

    devices[deviceIndex] = DeviceModel(
      id: device.id,
      name: device.name,
      type: device.type,
      room: device.room,
      status: {...device.status, statusKey: newStatus}, // Cập nhật trạng thái
      icon: device.icon,
    );
    notifyListeners();

    // Chuẩn bị dữ liệu gửi qua WebSocket và API
    final model = {
      "_id": device.id,
      "status": {statusKey: newStatus}, // Trạng thái mới
    };

    try {
      // Gửi trạng thái mới qua WebSocket
      webSocketService.sendDeviceStatus(model);

      // Gửi qua API để xác nhận
      await apiService.updateDeviceStatus(device.type, device.id, newStatus);
      print("Device ${device.id} status updated successfully.");
    } catch (e) {
      print("Failed to update device ${device.id} status: $e");

      // Nếu lỗi xảy ra, hoàn nguyên trạng thái sau 1 giây
      Future.delayed(const Duration(seconds: 1), () {
        devices[deviceIndex] = DeviceModel(
          id: device.id,
          name: device.name,
          type: device.type,
          room: device.room,
          status: {...device.status, statusKey: currentStatus}, // Hoàn nguyên trạng thái
          icon: device.icon,
        );
        notifyListeners();
        print("Device ${device.id} automatically reverted due to error.");
      });
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

  // Xử lý khi nhấn vào các mục trên bottom navigation bar
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
    stopAutoRefresh(); // Đảm bảo dừng hẹn giờ khi không dùng nữa
    super.dispose();
  }
}
