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
    required this.existingUsernames,
    required this.existingEmails,
  });
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController phoneNo;
  final TextEditingController password;
  final String defaultUsername;
  final String defaultEmail;
  final String defaultPhoneNo;
  final String defaultPassword;
  final List<String> existingUsernames;
  final List<String> existingEmails;

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
        validator: validateUsername,
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
        validator: emailValidator,
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
        validator: passwordValidator,
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
        validator: validatePhoneNumber,
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

  String? validateUsername(String? value) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9_.]+$');

    if (value == null || !regex.hasMatch(value)) {
      return 'Username can only contain alphabets, numbers, underscores, and periods';
    } else if (existingUsernames.contains(value.trim()) == true) {
      return 'Username already exits';
    }

    return null; // Return null if the value is valid
  }

  String? validatePhoneNumber(String? value) {
    if (value == null) return 'Please Enter Phone 0300-1234567';
    final RegExp regex = RegExp(r'^03\d{2}-\d{7}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Invalid phone number : 0300-1234567';
    }

    return null; // Return null if the value is valid
  }

  String? emailValidator(String? val) {
    if (val == null || val == '') {
      return 'Please Enter Email';
    } else if (isEmailValid(val.trim()) == false) {
      return 'Invalid Email';
    } else if (existingEmails.contains(val.trim()) == true) {
      return 'Email already exits';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else {
      List<String> errors = [];
      if (password.length < 8) {
        errors.add('Required 8 characters long');
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        errors.add('Required one uppercase letter');
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        errors.add('Required one lowercase letter');
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        errors.add('Required one digit');
      }
      if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        errors.add('Required one speacial character');
      }

      if (errors.isEmpty) {
        return null;
      } else {
        String error = '';
        for (int i = 0; i < errors.length; i++) {
          error += errors[i];
          if (i != errors.length - 1) error += '\n';
        }
        return error;
      }
    }
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return regex.hasMatch(email.trim());
  }
}
