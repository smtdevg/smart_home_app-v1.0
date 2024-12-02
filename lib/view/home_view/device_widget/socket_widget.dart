import 'package:app_smart_home/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';

class SocketWidget extends StatelessWidget {
  final HomePageViewModel model;
  final String deviceId;
  final String iconAsset;
  final String deviceName;

  const SocketWidget({
    Key? key,
    required this.model,
    required this.deviceId,
    required this.iconAsset,
    required this.deviceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tạo một widget cho Socket Device
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(5)),
        child: DarkContainer(
          itsOn: model.getSocketStatus(deviceId), // Trạng thái bật/tắt từ model
          switchButton: model.getSocketState(deviceId), // Switch button
          onTap: () {
            // Mở trang điều khiển hoặc thực hiện hành động khác khi nhấn
            // Ví dụ: Navigator.of(context).pushNamed(ACPage.routeName);
          },
          iconAsset: iconAsset,
          device: deviceName,
          deviceCount: '1 device',
        ),
      ),
    );
  }
}
