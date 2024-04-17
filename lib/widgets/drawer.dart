import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

import '../controller/theme_controller.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  bool _isDarkMode = false; // State variable to track dark mode

  int value = 0;
  bool positive = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: CustomColors.firstGradientColor, // Dynamically get primary color
          ),
          accountName: Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          accountEmail: Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "sample@email.com",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        DayNightSwitch(
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
              // Toggle dark mode
              Get.find<ThemeController>().toggleTheme();
            });
          },
        ),

      ],
    );
  }
}
