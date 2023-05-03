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

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});
  // final UserType userType;

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController phoneNo;
  late final TextEditingController password;
  String defaultUsername = "";
  String defaultEmail = "0";
  String defaultPhoneNo = "0";
  String defaultPassword = "0";

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

    final UsersController uc = Get.find();
    final admins = uc.admins;
    final tAdmins = admins.length;

    defaultUsername = 'a0${tAdmins + 1}';
    defaultEmail = 'a0${tAdmins + 1}@google.com';
    defaultPhoneNo = '+92 1234567890';
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
                User newAdmin = User(
                  id: mongo.ObjectId(),
                  password: password
                      .text, // passwor.text ko yaha encrypt karna ha bas takey databse main excrypted value jaey
                  phoneNo: phoneNo.text,
                  username: username.text,
                  email: email.text,
                );
                MongoDatabase.addAdmin(newAdmin).then((value) {
                  if (value == true) {
                    uc.admins.add(newAdmin);
                    Navigator.pop(context);
                    customSnackbar(context, value, 'Add Admin');
                  } else {
                    customSnackbar(context, value, 'Add Admin');
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
