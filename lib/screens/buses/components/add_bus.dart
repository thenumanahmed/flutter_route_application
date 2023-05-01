import 'package:dashboard_route_app/controllers/bus_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../models/bus.dart';

class AddBus extends StatefulWidget {
  const AddBus({super.key});

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  late final TextEditingController numberPlate;
  late final TextEditingController modelNo;
  String defaultPlateNo = "";
  String defaultModelNo = "0";

  @override
  void initState() {
    initializeVariables();
    super.initState();
  }

  initializeVariables() {
    final BusController bc = Get.find();

    numberPlate = TextEditingController();
    modelNo = TextEditingController();
    final tBuses = bc.buses.length;
    defaultPlateNo = 'LEK ${tBuses + 1}';
    numberPlate.text = defaultPlateNo;
    modelNo.text = defaultModelNo;
  }

  @override
  Widget build(BuildContext context) {
    final BusController bc = Get.find();
    final key = GlobalKey<FormState>();
    return Form(
      key: key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          numberPlateField(),
          kHeightSpace,
          modelNoField(),
          kHeightSpace,
          CustomAlertButton(
            title: 'Add',
            onTap: () {
              if (key.currentState!.validate()) {
                bc.buses.add(Bus(
                  id: mongo.ObjectId(),
                  numberPlate: numberPlate.text,
                  modelNo: int.parse(modelNo.text),
                ));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Flexible numberPlateField() {
    return Flexible(
        child: TextFormField(
      controller: numberPlate,
      style: kTextStyle,
      decoration: InputDecoration(
        labelText: 'numberPlate',
        hintText: 'Track 1',
        hintStyle: kHintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixButton(
          icon: Icons.hdr_auto_sharp,
          onTap: () {
            numberPlate.text = defaultPlateNo;
          },
          message: 'Auto Genrate numberPlate',
        ),
      ),
    ));
  }

  Flexible modelNoField() {
    return Flexible(
        child: TextFormField(
      controller: modelNo,
      style: kTextStyle,
      validator: (value) {
        if (int.tryParse(value!) == null) {
          return 'digits (0-99)';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Model No',
        hintText: '16',
        hintStyle: kHintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixButton(
          icon: Icons.hdr_auto_sharp,
          onTap: () {
            modelNo.text = defaultModelNo;
          },
          message: 'Auto Genrate Model No',
        ),
      ),
    ));
  }
}
