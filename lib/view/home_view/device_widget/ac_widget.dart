import 'package:app_smart_home/view/ac_view/ac.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';

class ACWidget extends StatelessWidget {
  final DeviceModel device;
  final HomePageViewModel model;

  const ACWidget({
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
          itsOn: device.isOn, // Sử dụng trạng thái từ DeviceModel
          switchButton: () => model.toggleDevice(device),
          onTap: () {
            Navigator.of(context).pushNamed(ACPage.routeName);
          },
          iconAsset: device.icon,
          device: device.name,
          deviceCount: '1 device',
        ),
      ),
    );
  }
}
