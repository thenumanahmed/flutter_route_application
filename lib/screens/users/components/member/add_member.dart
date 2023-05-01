import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../models/users.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../controllers/users_controller.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
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
    final members = uc.members;
    final tMembers = members.length;

    defaultUsername = 'a0${tMembers + 1}';
    defaultEmail = 'a0${tMembers + 1}@google.com';
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
          usernameField(),
          kHeightSpace,
          emailField(),
          kHeightSpace,
          passwordField(),
          kHeightSpace,
          phoneNoField(),
          kHeightSpace,
          CustomAlertButton(
            title: 'Add',
            onTap: () {
              if (key.currentState!.validate()) {
                uc.members.add(User(
                  id: mongo.ObjectId(),
                  password: password.text,
                  phoneNo: phoneNo.text,
                  username: username.text,
                  email: email.text,
                ));

                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Flexible usernameField() {
    return Flexible(
      child: TextFormField(
        controller: username,
        style: kTextStyle,
        decoration: InputDecoration(
          labelText: 'username',
          hintText: '2021se4',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixButton(
            icon: Icons.hdr_auto_sharp,
            onTap: () {
              username.text = defaultUsername;
            },
            message: 'Auto Genrate username',
          ),
        ),
      ),
    );
  }

  Flexible emailField() {
    return Flexible(
      child: TextFormField(
        controller: email,
        style: kTextStyle,
        decoration: InputDecoration(
          labelText: 'email',
          hintText: '2021se4@gmail.com',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixButton(
            icon: Icons.hdr_auto_sharp,
            onTap: () {
              email.text = defaultEmail;
            },
            message: 'Auto Genrate email',
          ),
        ),
      ),
    );
  }

  Flexible passwordField() {
    return Flexible(
      child: TextFormField(
        controller: password,
        style: kTextStyle,
        decoration: InputDecoration(
          labelText: 'password',
          hintText: '12345678',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixButton(
            icon: Icons.hdr_auto_sharp,
            onTap: () {
              password.text = defaultPassword;
            },
            message: 'Auto Genrate password',
          ),
        ),
      ),
    );
  }

  Flexible phoneNoField() {
    return Flexible(
      child: TextFormField(
        controller: phoneNo,
        style: kTextStyle,
        decoration: InputDecoration(
          labelText: 'phoneNo',
          hintText: '+92 1234567890',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixButton(
            icon: Icons.hdr_auto_sharp,
            onTap: () {
              phoneNo.text = defaultPhoneNo;
            },
            message: 'Auto Genrate phoneNo',
          ),
        ),
      ),
    );
  }
}
