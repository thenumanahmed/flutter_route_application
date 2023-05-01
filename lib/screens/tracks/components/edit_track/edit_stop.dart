import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../dbHelper/mongo_db.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../functions/custom_scafold.dart';
import '../../../../functions/latlng_string.dart';
import '../../../../functions/time.dart';
import '../../../../models/track.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../controllers/track/tracks_controller.dart';
import './stop_form.dart';

class EditStop extends StatefulWidget {
  const EditStop({
    Key? key,
    required this.sIndex,
    required this.tIndex,
  }) : super(key: key);
  final int sIndex;
  final int tIndex;

  @override
  State<EditStop> createState() => _EditStopState();
}

class _EditStopState extends State<EditStop> {
  final TextEditingController location = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController time = TextEditingController();

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();

    return Container(
      color: Colors.white,
      padding: defaultEdgePadding,
      child: Column(
        children: [
          StopForm(
            formKey: GlobalKey(),
            location: location,
            name: name,
            time: time,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => editStop(tc, ec),
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void initializeData() {
    final tc = Get.find<TracksController>();
    final Stop stop = tc.tracks[widget.tIndex].stops[widget.sIndex];
    location.text = "${stop.latitude},${stop.longitude}";
    name.text = stop.name;
    time.text = timeOfDayToString(stop.time);
  }

  void editStop(TracksController tc, EditController ec) async {
    // updated Stop locally
    Stop toUpdateStop = tc.tracks[widget.tIndex].stops[widget.sIndex];
    LatLng p1 = stringToLatLng(location.text);
    toUpdateStop.latitude = p1.latitude;
    toUpdateStop.longitude = p1.longitude;
    toUpdateStop.time = stringToTimeOfDay(time.text);
    toUpdateStop.name = name.text;

    // try to update on MongoDb
    MongoDatabase.updateStop(toUpdateStop).then((value) {
      if (value == true) {
        // Update Localy
        tc.tracks[widget.tIndex].stops[widget.sIndex] = toUpdateStop;
        customSnackbar(context, true, 'Stop Updated!');
        ec.doUpdate();
      } else {
        // Error
        customSnackbar(context, true, 'Stop not Updated!');
      }
    });
    // update Stop in mongodb
  }
}
