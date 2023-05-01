import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/custom_menu_controller.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.color = Colors.white,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.find<CustomMenuController>();
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: menuController.controlMenu,
            icon: Icon(
              Icons.menu,
              color: color,
            ),
          ),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        // const Expanded(child: SearchFeild())
      ],
    );
  }
}
