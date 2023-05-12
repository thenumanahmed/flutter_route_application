import 'package:flutter/material.dart';

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../widgets/custom_icon_button.dart';

class UserForm extends StatelessWidget {
  const UserForm({
    super.key,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.defaultUsername,
    required this.defaultEmail,
    required this.defaultPhoneNo,
    required this.defaultPassword,
  });
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController phoneNo;
  final TextEditingController password;
  final String defaultUsername;
  final String defaultEmail;
  final String defaultPhoneNo;
  final String defaultPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        usernameField(),
        kHeightSpace,
        emailField(),
        kHeightSpace,
        passwordField(),
        kHeightSpace,
        phoneNoField(),
      ],
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
