import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/users_controller.dart';
import '../../../../functions/custom_snackbar.dart';
import '../../../../models/users.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import 'user_form.dart';

class EditUser extends StatefulWidget {
  const EditUser(
      {super.key,
      required this.index,
      required this.user,
      required this.userType});
  final int index;
  final dynamic user;
  final UserType userType;
  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController phoneNo;
  late final TextEditingController password;
  String defaultUsername = "";
  String defaultEmail = "0";
  String defaultPhoneNo = "0";
  String defaultPassword = "0";
  late User user;

  @override
  void initState() {
    initializeVariables();
    super.initState();
  }

  initializeVariables() {
    username = TextEditingController();
    email = TextEditingController();
    phoneNo = TextEditingController();
    password = TextEditingController();

    user = widget.user as User;

    defaultUsername = user.username;
    defaultEmail = user.email;
    defaultPhoneNo = user.phoneNo;
    defaultPassword = user.password;

    username.text = defaultUsername;
    email.text = defaultEmail;
    phoneNo.text = defaultPhoneNo;
    password.text = defaultPassword;
  }

  @override
  Widget build(BuildContext context) {
    final UsersController uc = Get.find();

    final key = GlobalKey<FormState>();
    return Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserForm(
            username: username,
            email: email,
            phoneNo: phoneNo,
            password: password,
            defaultUsername: defaultUsername,
            defaultEmail: defaultEmail,
            defaultPhoneNo: defaultPhoneNo,
            defaultPassword: defaultPassword,
          ),
          kHeightSpace,
          CustomAlertButton(
            title: 'Save',
            onTap: () async {
              if (key.currentState!.validate()) {
                user.username = username.text;
                user.password = password.text;
                user.phoneNo = phoneNo.text;
                user.email = email.text;

                if (widget.userType == UserType.admin) {
                  await uc.updateUser(user, UserType.admin).then((value) {
                    if (value == true) {
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Update user');
                    } else {
                      customSnackbar(context, value, 'Update user');
                    }
                  });
                } else if (widget.userType == UserType.driver) {
                  await uc.updateUser(user, UserType.driver).then((value) {
                    if (value == true) {
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Update Driver');
                    } else {
                      customSnackbar(context, value, 'Update Driver');
                    }
                  });
                } else if (widget.userType == UserType.member) {
                  await uc.updateUser(user, UserType.member).then((value) {
                    if (value == true) {
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Update Member');
                    } else {
                      customSnackbar(context, value, 'Update Member');
                    }
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
