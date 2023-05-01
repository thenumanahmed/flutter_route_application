import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/users_controller.dart';
import '../../../widgets/custom_tab_button.dart';
import '../../../models/users.dart';

class UsersType extends StatelessWidget {
  const UsersType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UsersController uc = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 3 buttons
        Obx(
          () => Row(
            children: [
              CustomTabButton(
                text: 'Admins',
                boxCurveType: BoxCurveType.left,
                isSelected: uc.usersState.value == UserType.admin,
                onTap: () => uc.usersState.value = UserType.admin,
              ),
              CustomTabButton(
                text: 'Drivers',
                isSelected: uc.usersState.value == UserType.driver,
                onTap: () => uc.usersState.value = UserType.driver,
              ),
              CustomTabButton(
                text: 'Members',
                boxCurveType: BoxCurveType.right,
                isSelected: uc.usersState.value == UserType.member,
                onTap: () => uc.usersState.value = UserType.member,
              ),
            ],
          ),
        ),

        // TOtal Memebers + Blocked Users
        kWidthSpace,
        const Spacer(),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  'Total ${User.userTypeToString(uc.usersState.value)} : ${uc.total}'),
              Text('BLocked : ${uc.blocked}')
            ],
          ),
        ),
      ],
    );
  }
}
