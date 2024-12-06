import 'package:app_smart_home/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DarkContainer extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onTap;
  final String device;
  final String deviceCount;
  final bool itsOn;
  final VoidCallback? switchButton;

  const DarkContainer({
    super.key,
    required this.iconAsset,
    this.onTap, // Có thể null
    required this.device,
    required this.deviceCount,
    required this.itsOn,
    this.switchButton, // Có thể null
  });

  @override
  Widget build(BuildContext context) {
    // Tính toán tỷ lệ dựa trên kích thước màn hình
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 650; // 400 là kích thước tham chiếu mặc định

    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: 280 * scaleFactor, // Scale theo tỷ lệ
        height: 140 * scaleFactor, // Scale theo tỷ lệ
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20 * scaleFactor),
          color: itsOn
              ? const Color.fromRGBO(0, 0, 0, 1)
              : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * scaleFactor,
            vertical: 6 * scaleFactor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50 * scaleFactor,
                    height: 50 * scaleFactor,
                    decoration: BoxDecoration(
                      color: itsOn
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius: BorderRadius.circular(45 * scaleFactor),
                    ),
                    child: SvgPicture.asset(
                      iconAsset,
                      width: 24 * scaleFactor,
                      height: 24 * scaleFactor,
                      color: itsOn ? Colors.amber : const Color(0xFF808080),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: Theme.of(context).textTheme.displayMedium!.fontSize! * scaleFactor,
                      color: itsOn ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    deviceCount,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromRGBO(166, 166, 166, 1),
                      fontSize: 13 * scaleFactor,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itsOn ? 'On' : 'Off',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: Theme.of(context).textTheme.displayMedium!.fontSize! * scaleFactor,
                      color: itsOn ? Colors.white : Colors.black,
                    ),
                  ),
                  if (switchButton != null)
                    GestureDetector(
                      onTap: switchButton,
                      child: Container(
                        width: 48 * scaleFactor,
                        height: 25.6 * scaleFactor,
                        padding: EdgeInsets.all(2 * scaleFactor),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20 * scaleFactor),
                          color: itsOn ? Colors.black : const Color(0xffd6d6d6),
                          border: Border.all(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            width: itsOn ? 2 : 0,
                          ),
                        ),
                        child: Row(
                          children: [
                            itsOn ? const Spacer() : const SizedBox(),
                            Container(
                              width: 20 * scaleFactor,
                              height: 20 * scaleFactor,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50 * scaleFactor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
