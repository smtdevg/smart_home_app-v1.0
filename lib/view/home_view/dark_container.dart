import 'package:app_smart_home/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DarkContainer extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onTap; // Hành động khi nhấn vào toàn bộ container (có thể null)
  final String device; // Tên thiết bị
  final String deviceCount; // Thông tin bổ sung
  final bool itsOn; // Trạng thái bật/tắt
  final VoidCallback? switchButton; // Hành động khi nhấn nút chuyển trạng thái (có thể null)

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
    return InkWell(
      onTap: onTap ?? () {}, // Nếu không có hành động cụ thể, để mặc định là rỗng
      child: Container(
        width: getProportionateScreenWidth(140),
        height: getProportionateScreenHeight(140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: itsOn
              ? const Color.fromRGBO(0, 0, 0, 1)
              : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: itsOn
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                      const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: SvgPicture.asset(
                      iconAsset,
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
                      color: itsOn ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    deviceCount,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(166, 166, 166, 1),
                      fontSize: 13,
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
                      color: itsOn ? Colors.white : Colors.black,
                    ),
                  ),
                  if (switchButton != null) // Chỉ hiển thị nút nếu có `switchButton`
                    GestureDetector(
                      onTap: switchButton,
                      child: Container(
                        width: 48,
                        height: 25.6,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
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
