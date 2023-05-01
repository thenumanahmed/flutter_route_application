import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/users_controller.dart';
import 'driver/driver.table.dart';
import './user_type_row.dart';
import 'member/member_table.dart';
import 'admin/admin_table.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersController uc = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //  Upper Row
        const UsersType(),
        kHeightSpace, // 16 pixel sizebox height
        // Middle row and table
        Obx(() {
          if (uc.usersState.value == UserType.admin) {
            return const AdminTable();
          } else if (uc.usersState.value == UserType.driver) {
            return const DriverTable();
          }
          return const MemberTable();
        }),
      ],
    );
  }
}
