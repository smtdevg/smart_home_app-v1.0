import 'package:flutter/material.dart';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';

import '../../../config/size_config.dart';

class SocketWidget extends StatelessWidget {
  final DeviceModel device;
  final HomePageViewModel model;

  const SocketWidget({
    Key? key,
    required this.device,
    required this.model,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final button1Status = device.status['button1'] ?? false;
    final button2Status = device.status['button2'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: DarkContainer(
              itsOn: button1Status,
              switchButton: () => model.toggleDevice(device, 'button1'),
              onTap: () {},
              //
              iconAsset: device.icon,
              device: '${device.name}',
              deviceCount: 'Button 1',
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),

          Expanded(
            child: DarkContainer(
              itsOn: button2Status,
              switchButton: () => model.toggleDevice(device, 'button2'),
              onTap: () {},
              iconAsset: device.icon,
              device: '${device.name}',
              deviceCount: 'Button 2',
            ),
          ),
        ],
      ),
    );
  }
}
