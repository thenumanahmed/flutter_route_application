import 'package:flutter/material.dart';

import './sub_theme_data_mixin.dart';
import './app_color.dart';

class LightTheme with SubThemeData {
  // with is used instead of extends for mixin class
  ThemeData buildLigtTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColorDark,
        foregroundColor: iconColor,
      ),
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: bgColorLight,
      cardColor: cardColorLight,
      drawerTheme: const DrawerThemeData(backgroundColor: drawerColor),
      scrollbarTheme: ScrollbarThemeData(thumbColor: thumbColorLight),
      // iconTheme: getIconTheme(),

      inputDecorationTheme: getInputDecorationLightTheme(),
      iconButtonTheme: getIconButtonTheme(),
      dataTableTheme: getDataTableLightTheme(),
      textTheme: getTextThemes()
          // .apply(bodyColor: textColorLight, displayColor: textColorLight),
          .apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }
}

MaterialStateProperty<Color> thumbColorLight =
    MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return Colors.black12; // Replace with the desired color
    }
    return Colors.black26; // Replace with the desired color
  },
);

MaterialStateProperty<Color> thumbColorDark =
    MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return Colors.white24; // Replace with the desired color
    }
    return Colors.white12; // Replace with the desired color
  },
);
