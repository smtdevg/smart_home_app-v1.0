import 'package:flutter/material.dart';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';

class SocketWidget extends StatelessWidget {
  final DeviceModel device;
  final HomePageViewModel model;

  const SocketWidget({
    Key? key,
    required this.device,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DarkContainer(
          itsOn: device.status['on'] ?? false, // Trạng thái từ status['on']
          switchButton: () => model.toggleDevice(device),
          onTap: () {
            // Điều hướng chi tiết thiết bị
          },
          iconAsset: device.icon,
          device: device.name,
          deviceCount: '1 device',
        ),
      ),
    );
  }
}
