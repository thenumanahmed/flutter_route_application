import 'package:dashboard_route_app/controllers/track/stops_controller.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/map/flutter_map.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../functions/latlng_string.dart';
import '../../../../models/track.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../functions/time.dart';
import '../../../../functions/custom_snackbar.dart';
import '../../../tracks/components/edit_track/stop_form.dart';

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

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final sc = Get.find<StopsController>();
    final ec = Get.find<EditController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StopForm(
          name: name,
          time: time,
          location: location,
          formKey: GlobalKey(),
        ),
        kHeightSpace,
        CustomAlertButton(
          title: 'Add',
          onTap: () => addStop(tc, sc, ec),
        ),
      ],
    );
  }

  void initializeValues() {
    final tc = Get.find<TracksController>();
    final sc = Get.find<StopsController>();
    final ec = Get.find<EditController>();

    Track track = tc.tracks[ec.tIndex.value];
    final stops = sc.getStopByTrackID(track.id);

    defaultName = 'stop ${stops.length + 1}';
    name.text = defaultName;

    if (stops.isNotEmpty) {
      final lastStop = stops[stops.length - 1];
      center = LatLng(lastStop.latitude, lastStop.longitude);
      time.text = timeOfDayToString(lastStop.time);
    } else {
      center = kUetMainPoint;
      time.text = timeOfDayToString(TimeOfDay.now());
    }
    location.text = latLngToString(center);
  }

  void addStop(TracksController tc, StopsController sc, EditController ec) {
    Stop toAddStop = Stop(
        id: mongo.ObjectId(),
        trackId: tc.tracks[ec.tIndex.value].id,
        name: name.text,
        time: stringToTimeOfDay(time.text),
        isStop: true,
        stopNo: tc.tracks[ec.tIndex.value].stops.length,
        latitude: center.latitude,
        longitude: center.longitude);
    //TODO: ADD STOP
    // MongoDatabase.addStop(toAddStop).then((value) {
    //   if (value == true) {
    //     tc.tracks[ec.tIndex.value].stops.add(toAddStop);
    //     ec.doUpdate();
    //     Navigator.pop(context);
    //     customSnackbar(context, true, 'Stop Added');
    //   } else {
    //     customSnackbar(context, false, 'Stop not Added');
    //   }
    // });
  }
}
