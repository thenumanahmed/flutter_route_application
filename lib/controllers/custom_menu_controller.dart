import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MenuItems {
  login,
  dashboard,
  tracking,
  routes,
  tracks,
  users,
  buses,
  message,
  settings,
}

class CustomMenuController extends GetxController {
  final selectedItem = MenuItems.tracking.obs;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setSelectedItem(MenuItems item) {
    selectedItem.value = item;
  }
}
