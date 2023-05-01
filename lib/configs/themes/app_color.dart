import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = const Color(0xFF343541);
Color card1Color = const Color(0xFFF7F7F8);
Color card2Color = const Color(0xFF444654);

const double appBarIconRadius = 10;
const textFieldPadding = EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8);

const Color primaryColorDark = Color(0xFF353541);
const Color cardColorDark = Color(0xFF454654);
const Color cardHoverColorDark = Color(0xFF202123);
const Color textFieldColorDark = Color(0xFF454654);
const Color textColorDark = Color(0xFFD1D5DB);

const Color primaryColorLight = Color(0xFF2697FF);
const Color secondaryColorLight = Color(0xFF2A2D3E);
const Color secondaryColorbg = Color(0xFF2A2D3E);
const Color bgColorLight = Color(0xFF212332);
const Color cardColorLight = Color(0xFFF7F7F8);
const Color cardHoverColorLight = Color(0xFFD9D9E3);
const Color textFieldColorLight = Color(0xFFFFFFFF);
const Color textColorLight = Colors.black;

const Color drawerColor = Color(0xFF202123);
const Color iconColor = Color(0xFFD9D9E3);
const Color iconHoverColor = Color(0xFF202123);

const svgWhiteFilter = ColorFilter.mode(Colors.white, BlendMode.srcIn);
const svgGreenFilter = ColorFilter.mode(Colors.green, BlendMode.srcIn);

ColorFilter getColorFilter(Color color) {
  return ColorFilter.mode(color, BlendMode.srcIn);
}

const markerColor = Color(0xFFFF1100);

final kShadow = [
  BoxShadow(
    blurStyle: BlurStyle.solid,
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 4,
    blurRadius: 40,
    offset: const Offset(0, 1), // sets the offset of the shadow to the right
  )
];
