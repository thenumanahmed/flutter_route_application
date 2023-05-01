import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../controllers/bus_controller.dart';
import '../../../controllers/users_controller.dart';

class RouteForm extends StatefulWidget {
  const RouteForm({
    super.key,
    required this.name,
    required this.track,
    required this.driver,
    required this.bus,
    required this.formKey,
  });
  final TextEditingController name;
  final TextEditingController track;
  final TextEditingController driver;
  final TextEditingController bus;

  static const String none = 'none';
  final GlobalKey<FormState> formKey;
  @override
  State<RouteForm> createState() => _RouteFormState();
}

class _RouteFormState extends State<RouteForm> {
  String defaultName = '';
  @override
  void initState() {
    defaultName = widget.name.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> names = Get.find<TracksController>().names;
    List<String> driverUsername = Get.find<UsersController>().driverUsername;
    List<String> numberPlate = Get.find<BusController>().numberPlates;
    names.insert(0, RouteForm.none);
    driverUsername.insert(0, RouteForm.none);
    numberPlate.insert(0, RouteForm.none);

    return Form(
      key: widget.key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          nameField(widget.name, defaultName),
          kHeightSpace,
          dropdownField(
            dropdownValue: widget.track,
            dropdownOptions: names,
            label: 'Tracks',
          ),
          kHeightSpace,
          dropdownField(
            dropdownValue: widget.driver,
            dropdownOptions: driverUsername,
            label: 'Driver',
          ),
          kHeightSpace,
          dropdownField(
            dropdownValue: widget.bus,
            dropdownOptions: numberPlate,
            label: 'Bus',
          ),
        ],
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
        hintText: 'Enter Route name',
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

  Flexible dropdownField({
    required TextEditingController dropdownValue,
    required List<String> dropdownOptions,
    String defaultOption = RouteForm.none,
    required String label,
  }) {
    return Flexible(
      child: DropdownButtonFormField<String>(
        value:
            dropdownValue.text.isNotEmpty ? dropdownValue.text : defaultOption,
        onChanged: (String? newValue) {
          if (newValue != null) {
            dropdownValue.text = newValue;
          }
        },
        items: dropdownOptions.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: kTextStyle,
              ),
            );
          },
        ).toList(),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Select $label',
          hintStyle: kHintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
