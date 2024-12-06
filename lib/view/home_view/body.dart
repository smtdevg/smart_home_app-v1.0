import 'package:flutter/material.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:app_smart_home/models/device_model.dart';
import 'package:app_smart_home/view/home_view/device_widget/ac_widget.dart';
import 'package:app_smart_home/view/home_view/device_widget/lock_widget.dart';
import 'package:app_smart_home/view/home_view/device_widget/socket_widget.dart';
import 'package:app_smart_home/view/home_view/device_widget/switch_widget.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final HomePageViewModel model;

  const Body({Key? key, required this.model}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, model, child) {
        if (model.devices.isEmpty) {
          return Center(
            child: Text(
              'No devices found',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: model.devices.length,
          itemBuilder: (context, index) {
            final device = model.devices[index];
            switch (device.type.toLowerCase()) {
              case 'airconditioner':
                return ACWidget(device: device, model: model);
              case 'lock':
                return LockWidget(device: device, model: model);
              case 'switch':
                return SwitchWidget(device: device, model: model);
              case 'socket':
                return SocketWidget(device: device, model: model);
              default:
                return const SizedBox
                    .shrink(); // Nếu không khớp, hiển thị trống
            }
          },
        );
      },
    );
  }
}
