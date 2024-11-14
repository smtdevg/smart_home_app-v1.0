import 'package:app_smart_home/config/size_config.dart';
import 'package:app_smart_home/view_models/ac_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Body extends StatelessWidget {
  final ACViewModel model;

  const Body({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(10),
              top: getProportionateScreenHeight(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_outlined)),
                Stack(
                  children: [
                    Text(
                      'Air\nConditioner',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 45,
                            color: const Color(0xFFBDBDBD).withOpacity(0.5),
                          ),
                    ),
                    // Text(
                    //   'Living\nRoom',
                    //   style: Theme.of(context).textTheme.displayLarge,
                    // ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SleekCircularSlider(
              min: 18,
              max: 30,
              initialValue: model.temperature,
              appearance: CircularSliderAppearance(
                size: 200,
                startAngle: 250,
                angleRange: 360,
                customColors: CustomSliderColors(
                  trackColor: const Color(0xFFBDBDBD),
                  progressBarColor: const Color(0xFF464646),
                  shadowColor: const Color(0xFFBDBDBD).withOpacity(0.1),
                  shadowMaxOpacity: 1,
                  shadowStep: 25,
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 22,
                  handlerSize: 25,
                  trackWidth: 22,
                  shadowWidth: 50,
                ),
              ),
              onChangeEnd: (double value) {
                model.setTemperature(value);
              },
              innerWidget: (double value) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenHeight(12),
                    top: getProportionateScreenHeight(45),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${value.toInt()}°',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'Celcius',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                );
              },
            )
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daikin AC',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Connected',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              Switch.adaptive(
                inactiveThumbColor: const Color(0xFFE4E4E4),
                inactiveTrackColor: Colors.white,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF464646),
                value: model.isACon,
                onChanged: (value) {
                  model.acSwitch(value);
                },
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          // Divider(
          //   thickness: 2,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Text(
            'Mode',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: ToggleButtons(
              selectedColor: Colors.white,
              fillColor: const Color(0xFF464646),
              renderBorder: false,
              borderRadius: BorderRadius.circular(15),
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
              onPressed: (int index) {
                model.onToggleTapped(index);
              },
              isSelected: model.isSelected,
              children: <Widget>[
                SizedBox(
                  width: getProportionateScreenWidth(70),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/cool.svg',
                        color: model.isSelected[0]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Cool',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/air.svg',
                        color: model.isSelected[1]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Air',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/sun.svg',
                        color: model.isSelected[2]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Hot',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/eco.svg',
                        color: model.isSelected[3]
                            ? Colors.white
                            : const Color(0xFF808080),
                        height: getProportionateScreenHeight(
                          22,
                        ),
                      ),
                      const Text(
                        'Eco',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Text(
            'Fan speed',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: ToggleButtons(
              selectedColor: Colors.white,
              fillColor: const Color(0xFF464646),
              renderBorder: false,
              borderRadius: BorderRadius.circular(15),
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
              onPressed: (int index) {
                model.onToggleTapped1(index);
              },
              isSelected: model.isSelected1,
              children: <Widget>[
                SizedBox(
                  width: getProportionateScreenWidth(70),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '1',
                        selectionColor: model.isSelected1[0]
                            ? Colors.white
                            : const Color(0xFF808080),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '2',
                        selectionColor: model.isSelected1[1]
                            ? Colors.white
                            : const Color(0xFF808080),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '3',
                        selectionColor: model.isSelected1[2]
                            ? Colors.white
                            : const Color(0xFF808080),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(57.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '4',
                        selectionColor: model.isSelected1[3]
                            ? Colors.white
                            : const Color(0xFF808080),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    );
  }
}
