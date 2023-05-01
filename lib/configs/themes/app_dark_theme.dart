import 'package:flutter/material.dart';

import './sub_theme_data_mixin.dart';
import './app_color.dart';

class DarkTheme with SubThemeData {
  // with is used instead of extends for mixin class
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColorDark,
          foregroundColor: iconColor,
        ),
        scaffoldBackgroundColor: primaryColorDark,
        primaryColor: primaryColorDark,
        cardColor: cardColorDark,
        drawerTheme: const DrawerThemeData(backgroundColor: drawerColor),
        // iconTheme: getIconTheme(),
        inputDecorationTheme: getInputDecorationDarkTheme(),
        iconButtonTheme: getIconButtonTheme(),
        textTheme: getTextThemes()
            // .apply(bodyColor: textColorDark, displayColor: textColorDark)
            .apply(bodyColor: Colors.black, displayColor: Colors.black));
  }
}
