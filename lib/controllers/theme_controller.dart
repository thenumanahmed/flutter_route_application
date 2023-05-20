import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../configs/themes/app_color.dart';
import '../configs/themes/app_dark_theme.dart';
import '../configs/themes/app_light_theme.dart';
import '../sockets/api.dart';

class ThemeController extends GetxController {
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  final isDark = (Get.isDarkMode).obs;

  @override
  void onInit() {
    initializeThemeData();
    super.onInit();

    print(kBusesWsUrl);
  }

  initializeThemeData() {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLigtTheme();
  }

  switchTheme() {
    isDark.value = !isDark.value;
    update();
    notifyChildrens();
  }

  //GETTERR
  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  Color customCursorColor(BuildContext context) =>
      isDark.value ? textColorDark : textColorLight;

  TextStyle chatText(context) => TextStyle(
        color: isDark.value ? textColorDark : textColorLight,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  TextStyle textFieldStyle(context) => TextStyle(
        color: isDark.value ? textColorDark : textColorLight,
      );
}
