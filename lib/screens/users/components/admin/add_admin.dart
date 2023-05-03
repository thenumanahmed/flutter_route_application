import 'package:dashboard_route_app/dbHelper/mongo_db.dart';
import 'package:dashboard_route_app/functions/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../models/users.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../controllers/users_controller.dart';
import '../user_form.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key, required this.userType});
  final UserType userType;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController phoneNo;
  late final TextEditingController password;
  String defaultUsername = "";
  String defaultEmail = "0";
  String defaultPhoneNo = "0";
  String defaultPassword = "0";

  int tUser = 0;
  late String defaultC;

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

    final uc = Get.find<UsersController>();

    if (widget.userType == UserType.admin) {
      tUser = uc.admins.length;
      defaultC = 'a0';
    } else if (widget.userType == UserType.driver) {
      tUser = uc.drivers.length;
      defaultC = 'd0';
    } else {
      tUser = uc.members.length;
      defaultC = '2021se';
    }

    final String defaultString = '$defaultC${tUser + 1}';
    defaultUsername = defaultString;
    defaultEmail = '$defaultString@uet.edu.pk';
    defaultPhoneNo = '+92-1234567890';
    defaultPassword = '12345678';
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
            title: 'Add',
            onTap: () async {
              if (key.currentState!.validate()) {
                User newUser = User(
                  id: mongo.ObjectId(),
                  password: password
                      .text, // passwor.text ko yaha encrypt karna ha bas takey databse main excrypted value jaey
                  phoneNo: phoneNo.text,
                  username: username.text,
                  email: email.text,
                );

                if (widget.userType == UserType.admin) {
                  MongoDatabase.addAdmin(newUser).then((value) {
                    if (value == true) {
                      uc.admins.add(newUser);
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Add Admin');
                    } else {
                      customSnackbar(context, value, 'Add Admin');
                    }
                  });
                } else if (widget.userType == UserType.driver) {
                  MongoDatabase.addDriver(newUser).then((value) {
                    if (value == true) {
                      uc.drivers.add(newUser);
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Add Driver');
                    } else {
                      customSnackbar(context, value, 'Add Driver');
                    }
                  });
                } else if (widget.userType == UserType.member) {
                  MongoDatabase.addMember(newUser).then((value) {
                    if (value == true) {
                      uc.members.add(newUser);
                      Navigator.pop(context);
                      customSnackbar(context, value, 'Add member');
                    } else {
                      customSnackbar(context, value, 'Add member');
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
