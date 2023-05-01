import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/map/flutter_map.dart';
import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../models/track.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../functions/custom_dialog.dart';
import '../../../../functions/time.dart';
import 'set_location.dart';
import 'center_map.dart';

class AddStop extends StatefulWidget {
  const AddStop({super.key});

  @override
  State<AddStop> createState() => _AddStopState();
}

class _AddStopState extends State<AddStop> {
  final name = TextEditingController();

  // TimeOfDay time = TimeOfDay.now();
  final location = TextEditingController();

  final time = TextEditingController();

  LatLng center = LatLng(0, 0);
  String defaultName = '';

  @override
  void initState() {
    initializeValues();
    super.initState();
  }

  void initializeValues() {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();

    Track track = tc.tracks[ec.tIndex.value];
    final tStops = track.stops.length;

    defaultName = 'stop ${tStops + 1}';
    name.text = defaultName;

    if (tStops != 0) {
      final lastStop = track.stops[tStops - 1];
      center = LatLng(lastStop.latitude, lastStop.longitude);
      time.text = timeOfDayToString(lastStop.time);
    } else {
      center = kUetMainPoint;
      time.text = timeOfDayToString(TimeOfDay.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          nameField(name, defaultName),
          kHeightSpace,
          timeField(time, context),
          kHeightSpace,
          Flexible(
            child: SetLocation(
              location: location,
            ),
          ),
          kHeightSpace,
          CustomAlertButton(
            title: 'Add',
            onTap: () {
              tc.tracks[ec.tIndex.value].stops.add(
                Stop(
                    id: mongo.ObjectId(),
                    name: name.text,
                    time: stringToTimeOfDay(time.text),
                    isStop: true,
                    stopNo: tc.tracks[ec.tIndex.value].stops.length,
                    latitude: center.latitude,
                    longitude: center.longitude),
              );
              ec.doUpdate();
              Navigator.pop(context);
            },
          ),
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
          hintText: '8:40 AM',
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
        hintText: 'Chan Da Qila',
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
