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

  // Trạng thái thiết bị
  bool isSocket1On = false;
  bool isSocket2On = false;
  bool isACON = false;
  bool isSwitch1On = false;
  bool isSwitch2On = false;


  HomePageViewModel({
    required this.apiService,
    required this.webSocketService,
  });

  List<DeviceModel> devices = [];

  // Getter bật/tắt thiết bị, gọi toggleDevice
  get acSwitch => () => toggleDevice("1", "isACON", isACON);
  get Switch1 => () => toggleDevice("2", "isSwitch1On", isSwitch1On);
  get sk1Switch => () => toggleDevice("3", "isSocket1On", isSocket1On);
  get Switch2 => () => toggleDevice("4", "isSwitch2On", isSwitch2On);
  get sk2Switch => () => toggleDevice("5", "isSocket2On", isSocket2On);


  // Lấy trạng thái thiết bị từ API
  Future<void> fetchDeviceStatuses() async {
    try {
      final switches = await apiService.getAllDevices('switch');
      final sockets = await apiService.getAllDevices('socket');
      final aircons = await apiService.getAllDevices('aircon');
      final locks = await apiService.getAllDevices('lock');
      final devices = [
        {"id": " 1", "key": "isACON"},
        {"id": " 2", "key": "isSwitch1On"},
        {"id": " 3", "key": "isSocket1On"},
        {"id": " 4", "key": "isSwitch2On"},
        {"id": " 5", "key": "isSocket2On"}
      ];

      for (var device in devices) {
        final status = await apiService.getDeviceStatus("switch",device["id"]!);
        final buttonStatus = status['status']['button1'] as bool;
        updateState(device["key"]!, buttonStatus);
      }

      notifyListeners();
    } catch (e) {
      print('Failed to fetch device statuses: $e');
    }
  }

  // Cập nhật trạng thái thiết bị cục bộ
  void updateState(String key, bool status) {
    switch (key) {
      case "isACON":
        isACON = status;
        break;
      case "isSwitch1On":
        isSwitch1On = status;
        break;
      case "isSocket1On":
        isSocket1On = status;
        break;
      case "isSwitch2On":
        isSwitch2On = status;
        break;
      case "isSocket2On":
        isSocket2On = status;
        break;
    }
  }

  // Gửi trạng thái thiết bị qua WebSocket và xử lý lỗi
  Future<void> toggleDevice(
      String deviceId, String key, bool currentStatus) async {
    final newStatus = !currentStatus;

    // Cập nhật trạng thái cục bộ ngay lập tức
    updateState(key, newStatus);
    notifyListeners();

    final model = {
      "_id": deviceId,
      "status": {"button1": newStatus}
    };

    try {
      // Gửi trạng thái mới qua WebSocket
      webSocketService.sendDeviceStatus(model);

      // Gửi qua API để xác nhận
      await apiService.updateDeviceStatus("switch",deviceId, newStatus);
      print("Device $deviceId status updated successfully.");
    } catch (e) {
      print("Failed to update device $deviceId status: $e");

      // Nếu lỗi xảy ra, tự động đặt trạng thái về lại sau 1 giây
      Future.delayed(const Duration(seconds: 1), () {
        updateState(key, currentStatus);
        notifyListeners();
        print("Device $deviceId automatically reverted due to error.");
      });
    }
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
}
