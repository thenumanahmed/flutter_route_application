import 'package:flutter/material.dart';

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../functions/time.dart';
import 'set_location.dart';

class StopForm extends StatefulWidget {
  const StopForm({
    super.key,
    required this.name,
    required this.time,
    required this.location,
    required this.formKey,
  });
  final TextEditingController name;
  final TextEditingController time;
  final TextEditingController location;

  final GlobalKey<FormState> formKey;
  @override
  State<StopForm> createState() => _StopFormState();
}

class _StopFormState extends State<StopForm> {
  String defaultName = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          nameField(widget.name, defaultName),
          kHeightSpace,
          timeField(widget.time, context),
          kHeightSpace,
          Flexible(
            child: SetLocation(
              location: widget.location,
            ),
          ),
          kHeightSpace,
        ],
      ),
    );
  }

  Flexible timeField(TextEditingController time, BuildContext context) {
    return Flexible(
      child: TextFormField(
        controller: time,
        style: kTextStyle,
        validator: validateTimeField,
        decoration: InputDecoration(
          labelText: 'Time of Arrival',
          hintText: 'Format: 8:40 AM',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixButton(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: stringToTimeOfDay(time.text),
              ).then((value) {
                if (value != null) {
                  time.text = value.format(context);
                }
              });
            },
            message: 'Set Time',
            icon: Icons.access_time_rounded,
          ),
        ),
      ),
    );
  }

  Flexible nameField(TextEditingController name, String defaultName) {
    return Flexible(
        child: TextFormField(
      controller: name,
      style: kTextStyle,
      validator: validateNameField,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter Stop name',
        hintStyle: kHintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixButton(
          icon: Icons.hdr_auto_sharp,
          onTap: () {
            name.text = defaultName;
          },
          message: 'Auto Genrate Name',
        ),
      ),
    ));
  }

  String? validateTimeField(String? value) {
    const timeRegex = r'^(0?[1-9]|1[0-2]):[0-5][0-9] (AM|PM)$';

    if (value == null || value.isEmpty) {
      return 'Time field cannot be empty.';
    }

    if (!RegExp(timeRegex).hasMatch(value)) {
      return 'Invalid time format. Please use the format "H:MM AM/PM".';
    }

    return null; // Return null if there are no validation errors
  }

  String? validateNameField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty.';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long.';
    }

    return null;
  }
}
