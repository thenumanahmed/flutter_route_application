import 'package:dashboard_route_app/dbHelper/mongo_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../functions/custom_scafold.dart';
import '../../../../functions/latlng_string.dart';
import '../../../../functions/time.dart';
import '../../../../models/track.dart';
import '../../../../widgets/edit_text.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'set_location.dart';
import 'stop_form.dart';

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
  void updateScreen() {
    // setState(() {});
  }

  final TextEditingController location = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController time = TextEditingController();

  @override
  void initState() {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();
    final Stop stop = tc.tracks[widget.tIndex].stops[widget.sIndex];
    print('hi');
    location.text = "${stop.latitude},${stop.longitude}";
    name.text = stop.name;
    time.text = timeOfDayToString(stop.time);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();
    const textStyle = TextStyle(color: Colors.black);
    final Stop stop = tc.tracks[widget.tIndex].stops[widget.sIndex];

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
                  onPressed: () async {
                    print(location.text);
                    // updated Stop locally
                    Stop toUpdateStop =
                        tc.tracks[widget.tIndex].stops[widget.sIndex];
                    LatLng p1 = stringToLatLng(location.text);
                    toUpdateStop.latitude = p1.latitude;
                    toUpdateStop.longitude = p1.longitude;
                    print(toUpdateStop.latitude);
                    print(toUpdateStop.longitude);
                    toUpdateStop.time = stringToTimeOfDay(time.text);
                    toUpdateStop.name = name.text;

                    MongoDatabase.updateStop(stop).then((value) {
                      if (value == true) {
                        tc.tracks[widget.tIndex].stops[widget.sIndex] =
                            toUpdateStop;
                        customSnackbar(context, 'Success: Stop Updated!');
                        ec.doUpdate();
                      } else {
                        customSnackbar(context, 'Error: Stop not Updated!');
                      }
                    });
                    // update Stop in mongodb
                  },
                  child: const Text('Save')),
            ],
          )
        ],
      ),
    );
  }

  onSaveName(String name, TracksController tc, EditController ec) {
    tc.tracks[widget.tIndex].stops[widget.sIndex].name = name;
    ec.doUpdate();
    updateScreen();
  }

  onSaveTime(TimeOfDay time, TracksController tc, EditController ec) {
    tc.tracks[widget.tIndex].stops[widget.sIndex].time = time;
    ec.doUpdate();
  }

  onSaveLattitude(String val, TracksController tc, EditController ec) {
    double lat = double.parse(val);
    tc.tracks[widget.tIndex].stops[widget.sIndex].latitude = lat;
    ec.doUpdate();
    updateScreen();
  }

  onSaveLongitude(String val, TracksController tc, EditController ec) {
    double lon = double.parse(val);
    tc.tracks[widget.tIndex].stops[widget.sIndex].longitude = lon;
    ec.doUpdate();
    updateScreen();
  }
}
