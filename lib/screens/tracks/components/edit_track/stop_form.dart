import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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
      key: widget.key,
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
}
