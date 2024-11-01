import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatelessWidget {
  static String routeName = '/settings_screen';
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text('Server Address'),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: const Color(0xff1d1617).withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0)
                ]),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(10),
              child: OutlinedButton(
                onPressed: () {
                  // Hành động khi button được nhấn
                  print('OutlinedButton pressed');
                },
                child: Text('Save'),
              ),
            )
          ],
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Setting',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
              color: const Color(0xffDBE0E7),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'lib/assets/icons/chevron.left.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      // actions: [
      //   GestureDetector(
      //     onTap: () {},
      //     child: Container(
      //       margin: const EdgeInsets.all(10),
      //       alignment: Alignment.center,
      //       width: 37,
      //       decoration: BoxDecoration(
      //           color: const Color(0xffDBE0E7),
      //           borderRadius: BorderRadius.circular(10)),
      //       child: SvgPicture.asset(
      //         'lib/assets/icons/chevron.left.svg',
      //         height: 20,
      //         width: 20,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
