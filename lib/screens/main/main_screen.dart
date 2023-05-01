import 'package:flutter/material.dart';
import '../../responsive.dart';

import 'package:get/get.dart';

import '../../controllers/custom_menu_controller.dart';
import '../buses/bus_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../message/message_screen.dart';
import '../routes/routes_screen.dart';
import '../settings/settings_screen.dart';
import '../tracking/tracking_screen.dart';
import '../tracks/tracks_screen.dart';
import '../users/users_screen.dart';
import './compoenents/slide_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final menuController = Get.find<CustomMenuController>();
    return Scaffold(
      key: menuController.scaffoldKey,
      drawer: const SlideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SlideMenu(),
            ),
          Obx(
            () => Expanded(
              flex: 5,
              child: showMenuScreen(menuController.selectedItem.value),
            ),
          ),
        ],
      ),
    );
  }

  Widget showMenuScreen(MenuItems menuItem) {
    if (menuItem == MenuItems.dashboard) {
      return const DashboardScreen();
    } else if (menuItem == MenuItems.tracking) {
      return const TrackingScreen();
    } else if (menuItem == MenuItems.routes) {
      return const RoutesScreen();
    } else if (menuItem == MenuItems.tracks) {
      return const TracksScreen();
    } else if (menuItem == MenuItems.buses) {
      return const BusesScreen();
    } else if (menuItem == MenuItems.users) {
      return const UsersScreen();
    } else if (menuItem == MenuItems.message) {
      return const MessageScreen();
    } else if (menuItem == MenuItems.settings) {
      return const SettingsScreen();
    } else {
      return const SizedBox.shrink();
    }
  }
}
