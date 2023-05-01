import 'package:flutter/material.dart';

import './app_color.dart';

//mixin is used to inherit multiple classes in dart
mixin SubThemeData {
  TextTheme getTextThemes() {
    return const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
      ),
    );
  }

  IconButtonThemeData getIconButtonTheme() {
    return IconButtonThemeData(
        style: IconButton.styleFrom(
      foregroundColor: iconColor,
      hoverColor: iconHoverColor,
    ));
  }

  InputDecorationTheme getInputDecorationLightTheme() {
    return const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black26,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
    );
  }

  InputDecorationTheme getInputDecorationDarkTheme() {
    return const InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );
  }

  DataTableThemeData getDataTableLightTheme() {
    return DataTableThemeData(
        dataRowColor: dataRowColor,
        headingRowColor: headingRowColor,
        dataTextStyle: const TextStyle(color: Colors.black),
        headingTextStyle: const TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600));
  }

  MaterialStateProperty<Color> dataRowColor =
      MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.white70; // Replace with the desired color
      }
      return Colors.white; // Replace with the desired color
    },
  );

  MaterialStateProperty<Color> headingRowColor =
      MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.white; // Replace with the desired color
      }
      return Colors.white; // Replace with the desired color
    },
  );
}
