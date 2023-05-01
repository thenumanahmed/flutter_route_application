import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/custom_menu_controller.dart';
import './drawer_list_tile.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menuController = Get.find<CustomMenuController>();
    return Drawer(
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              DrawerHeader(child: Image.asset("assets/images/logo.png")),
              DrawerListTile(
                onPress: () =>
                    menuController.setSelectedItem(MenuItems.dashboard),
                isSelected:
                    menuController.selectedItem.value == MenuItems.dashboard,
                svgSrc: "assets/icons/menu_dashbord.svg",
                title: 'Dashboard',
              ),
              DrawerListTile(
                onPress: () =>
                    menuController.setSelectedItem(MenuItems.tracking),
                isSelected:
                    menuController.selectedItem.value == MenuItems.tracking,
                svgSrc: "assets/icons/menu_tran.svg",
                title: 'Tracking',
              ),
              DrawerListTile(
                onPress: () => menuController.setSelectedItem(MenuItems.routes),
                isSelected:
                    menuController.selectedItem.value == MenuItems.routes,
                svgSrc: "assets/icons/menu_tran.svg",
                title: 'Routes',
              ),
              DrawerListTile(
                onPress: () => menuController.setSelectedItem(MenuItems.tracks),
                isSelected:
                    menuController.selectedItem.value == MenuItems.tracks,
                svgSrc: "assets/icons/menu_task.svg",
                title: 'Tracks',
              ),
              DrawerListTile(
                onPress: () => menuController.setSelectedItem(MenuItems.users),
                isSelected:
                    menuController.selectedItem.value == MenuItems.users,
                svgSrc: "assets/icons/menu_store.svg",
                title: 'Users',
              ),
              DrawerListTile(
                onPress: () => menuController.setSelectedItem(MenuItems.buses),
                isSelected:
                    menuController.selectedItem.value == MenuItems.buses,
                svgSrc: "assets/icons/menu_store.svg",
                title: 'Buses',
              ),
              DrawerListTile(
                onPress: () =>
                    menuController.setSelectedItem(MenuItems.message),
                isSelected:
                    menuController.selectedItem.value == MenuItems.message,
                imageSrc: "assets/icons/message.png",
                title: 'Message',
              ),
              DrawerListTile(
                onPress: () =>
                    menuController.setSelectedItem(MenuItems.settings),
                isSelected:
                    menuController.selectedItem.value == MenuItems.settings,
                svgSrc: "assets/icons/menu_setting.svg",
                title: 'Settings',
              ),
              DrawerListTile(
                onPress: () {},
                isSelected:
                    menuController.selectedItem.value == MenuItems.login,
                svgSrc: "assets/icons/menu_profile.svg",
                title: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
