import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  static const double desktopSize = 1100.0;
  static const double tabletSize = 850.0;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletSize;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopSize &&
      MediaQuery.of(context).size.width >= tabletSize;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopSize;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double avaliableWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= desktopSize ? (width * 5 / 6) : width;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= desktopSize) {
      return desktop!;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= tabletSize && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile!;
    }
  }
}
