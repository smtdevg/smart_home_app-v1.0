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
                SizedBox(height: getProportionateScreenHeight(10)),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_outlined),
                ),
                Stack(
                  children: [
                    Text(
                      'Air\nConditioner',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 45,
                            color: const Color(0xFFBDBDBD).withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),

          // Slider đk nhiệt độ
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
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 22,
                  handlerSize: 25,
                ),
              ),
              onChangeEnd: (double value) {
                model.setTemperature(value);
              },
              innerWidget: (double value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${value.toInt()}°',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Celsius',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                );
              },
            ),
          ),

          //Chế độ & Mức gió
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daikin AC',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Switch.adaptive(
                value: model.isACon,
                onChanged: model.acSwitch,
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // Điều khiển chế độ
          Text('Mode', style: Theme.of(context).textTheme.displayMedium),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          ToggleButtons(
            selectedColor: Colors.white,
            fillColor: const Color(0xFF464646),
            renderBorder: true,
            borderRadius: BorderRadius.circular(15),
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white),
            onPressed: (index) => model.onToggleTapped(index),
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
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // Điều khiển tốc độ gió
          Text('Fan speed', style: Theme.of(context).textTheme.displayMedium),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          ToggleButtons(
            selectedColor: Colors.white,
            fillColor: const Color(0xFF464646),
            renderBorder: true,
            borderRadius: BorderRadius.circular(15),
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white),
            onPressed: (index) => model.onToggleTapped1(index),
            isSelected: model.isSelected1,
            children: [
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
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),

        ],
      ),
    );
  }
}
