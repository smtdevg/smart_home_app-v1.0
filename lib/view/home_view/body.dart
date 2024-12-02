import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view/home_view/home.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/config/size_config.dart';
import 'package:app_smart_home/view/ac_view/ac.dart';

import '../device_view/device.dart';

class Body extends StatelessWidget {
  final HomePageViewModel model;
  const Body({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(7),
          vertical: getProportionateScreenHeight(7),
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
        ),
        child: Column(
          children: [
            // Weather widget placeholder
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            ),
            // Placeholder for any additional widgets
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            ),
            // Row for Air Conditioner
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isACON,
                      switchButton: model.acSwitch,
                      onTap: () {
                        Navigator.of(context).pushNamed(ACPage.routeName);
                      },
                      iconAsset: 'assets/svg/ac.svg',
                      device: 'Air Conditioner',
                      deviceCount: '1 device',
                    ),
                  ),
                ),
              ],
            ),
            // Row for Switch 1 and Socket 1
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSwitch1On,
                      switchButton: model.Switch1,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DeviceSettingsPage.routeName,
                          arguments: {
                            'deviceId': '1',
                            'deviceType': 'Switch',
                            'deviceName': 'Living Room AC',
                          },
                        );

                      },
                      iconAsset: 'assets/svg/light.svg',
                      device: 'Switch 1',
                      deviceCount: '1 device',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSocket1On,
                      switchButton: model.sk1Switch,
                      onTap: () {
                        // Add navigation or additional action here
                      },
                      iconAsset: 'assets/svg/fan.svg',
                      device: 'Socket 1',
                      deviceCount: '1 device',
                    ),
                  ),
                ),
              ],
            ),
            // Spacer
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            ),
            // Row for Switch 2 and Socket 2
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSwitch2On,
                      switchButton: model.Switch2,
                      onTap: () {
                        // Add navigation or additional action here
                      },
                      iconAsset: 'assets/svg/light.svg',
                      device: 'Switch 2',
                      deviceCount: '1 device',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSocket2On,
                      switchButton: model.sk2Switch,
                      onTap: () {
                        // Add navigation or additional action here
                      },
                      iconAsset: 'assets/svg/fan.svg',
                      device: 'Socket 2',
                      deviceCount: '1 device',
                    ),
                  ),
                ),
              ],
            ),
            // Placeholder for additional widgets
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            ),
          ],
        ),
      ),
    );
  }
}
