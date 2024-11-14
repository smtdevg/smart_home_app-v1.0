// import 'dart:io';
import 'package:app_smart_home/view/home_view/dark_container.dart';
import 'package:app_smart_home/view/home_view/home.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/config/size_config.dart';
import 'package:app_smart_home/view/ac_view/ac.dart';

class Body extends StatelessWidget {
  final HomePageViewModel model;
  const Body({Key? key, required this.model}) : super(key: key);

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
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              // child: Weather(model: model),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              // child: //wg (model: model),
            ),
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
                      device: 'AC',
                      deviceCount: '1 device',
                      switchFav: model.acFav,
                      isFav: model.isACFav,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSwitch1On,
                      switchButton: model.Switch1,
                      onTap: () {
                        Navigator.of(context).pushNamed(HomePage.routeName);
                      },
                      iconAsset: 'assets/svg/light.svg',
                      device: 'Switch 1',
                      deviceCount: 'Lamp',
                      switchFav: model.switch1Fav,
                      isFav: model.isSwitch1Fav,
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
                        // Navigator.of(context).pushNamed(Socket.routeName);
                      },
                      iconAsset: 'assets/svg/fan.svg',
                      device: 'Socket 1',
                      deviceCount: '1 devices',
                      switchFav: model.socket1Fav,
                      isFav: model.isSocket1Fav,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                    child: DarkContainer(
                      itsOn: model.isSwitch2On,
                      switchButton: model.Switch2,
                      onTap: () {
                        // Navigator.of(context).pushNamed(Socket.routeName);
                      },
                      iconAsset: 'assets/svg/light.svg',
                      device: 'Switch 2',
                      deviceCount: '1 device',
                      switchFav: model.switch2Fav,
                      isFav: model.isSwitch2Fav,
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
                        // Navigator.of(context).pushNamed(Socket.routeName);
                      },
                      iconAsset: 'assets/svg/fan.svg',
                      device: 'Socket 2',
                      deviceCount: '1 devices',
                      switchFav: model.socket2Fav,
                      isFav: model.isSocket2Fav,
                    ),
                  ),
                ),
              ],
            ),


            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8)),
              // child: const AddNewDevice(),
            ),
            //   ElevatedButton(
            //     onPressed: () {
            //       //   Navigator.of(context).pushNamed(SetEventScreen.routeName);
            //     },
            //     child: const Text(
            //       'To SetEventScreen',
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            //   ElevatedButton(
            //     onPressed: () {
            //       // Navigator.of(context).pushNamed(SmartTV.routeName);
            //     },
            //     child: const Text(
            //       'Smart TV Screen',
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
