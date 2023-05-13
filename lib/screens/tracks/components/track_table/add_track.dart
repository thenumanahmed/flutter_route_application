import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../models/track.dart';
import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../widgets/custom_icon_button.dart';

class AddTrack extends StatefulWidget {
  const AddTrack({super.key});

  @override
  State<AddTrack> createState() => _AddTrackState();
}

class _AddTrackState extends State<AddTrack> {
  late final TextEditingController name;
  String defaultName = "";

  @override
  void initState() {
    initializeVariables();
    super.initState();
  }

  initializeVariables() {
    final TracksController tc = Get.find();

    name = TextEditingController();
    final tTracks = tc.tracks.length;
    defaultName = 'track ${tTracks + 1}';
    name.text = defaultName;
  }

  @override
  Widget build(BuildContext context) {
    final TracksController tc = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        nameField(),
        kHeightSpace,
        CustomAlertButton(
          title: 'Add',
          onTap: () async {
            Track newTrack = Track(
              id: mongo.ObjectId(),
              name: name.text,
              isAssigned: false,
              path: [],
              stops: [],
            );
            // TODO ADD TRACK
            // MongoDatabase.addTrack(newTrack).then((value) {
            //   if (value == true) {
            //     tc.tracks.add(newTrack);
            //     Navigator.pop(context);
            //   } else {
            //     //  TODO: show error on scaffold messenger
            //   }
            // });
          },
        ),
      ],
    );
  }

  Flexible nameField() {
    return Flexible(
        child: TextFormField(
      controller: name,
      style: kTextStyle,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Track 1',
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
