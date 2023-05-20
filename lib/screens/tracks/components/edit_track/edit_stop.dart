import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/stops_controller.dart';
import '../../../../functions/latlng_string.dart';
import '../../../../functions/time.dart';
import '../../../../models/track.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../controllers/track/tracks_controller.dart';
import './stop_form.dart';

class EditStop extends StatefulWidget {
  const EditStop({
    Key? key,
    required this.stop,
    required this.tIndex,
  }) : super(key: key);
  final Stop stop;
  final int tIndex;

  @override
  State<EditStop> createState() => _EditStopState();
}

class _EditStopState extends State<EditStop> {
  final TextEditingController location = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController time = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();
    final sc = Get.find<StopsController>();
    form = GlobalKey<FormState>();
    return Container(
      color: Colors.white,
      padding: defaultEdgePadding,
      child: Column(
        children: [
          StopForm(
            formKey: form,
            location: location,
            name: name,
            time: time,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => editStop(tc, ec, sc),
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void initializeData() {
    form = GlobalKey<FormState>();
    location.text = "${widget.stop.latitude},${widget.stop.longitude}";
    name.text = widget.stop.name;
    time.text = timeOfDayToString(widget.stop.time);
  }

  void editStop(
      TracksController tc, EditController ec, StopsController sc) async {
    if (form.currentState!.validate()) {
      // updated Stop locally
      Stop toUpdateStop = widget.stop;
      LatLng p1 = stringToLatLng(location.text);
      toUpdateStop.latitude = p1.latitude;
      toUpdateStop.longitude = p1.longitude;
      toUpdateStop.time = stringToTimeOfDay(time.text);
      toUpdateStop.name = name.text;

      sc.updateStop(toUpdateStop);
      await Future.delayed(const Duration(seconds: 1));
      ec.doUpdate();
    }
  }
}
