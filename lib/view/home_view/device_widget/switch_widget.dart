import 'package:flutter/material.dart';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';

class SwitchWidget extends StatelessWidget {
  final DeviceModel device;
  final HomePageViewModel model;

  const SwitchWidget({
    Key? key,
    required this.device,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final button1Status = device.status['button1'] ?? false;
    final button2Status = device.status['button2'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(8.0), // Padding chung cho các widget
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Sắp xếp các widget theo hàng ngang
        children: [
          // Widget cho Button 1 của Switch
          Expanded(
            child: DarkContainer(
              itsOn: button1Status,
              switchButton: () => model.toggleDevice(device, 'button1'),
              onTap: () {}, // Không cần hành động cho toàn bộ container
              iconAsset: device.icon,
              device: '${device.name} - Button 1', // Hiển thị tên Button 1
              deviceCount: '1', // Số thứ tự button
            ),
          ),
          const SizedBox(width: 10), // Khoảng cách giữa button 1 và button 2
          // Widget cho Button 2 của Switch
          Expanded(
            child: DarkContainer(
              itsOn: button2Status,
              switchButton: () => model.toggleDevice(device, 'button2'),
              onTap: () {}, // Không cần hành động cho toàn bộ container
              iconAsset: device.icon,
              device: '${device.name} - Button 2', // Hiển thị tên Button 2
              deviceCount: '2', // Số thứ tự button
            ),
          ),
        ],
      ),
    );
  }
}
