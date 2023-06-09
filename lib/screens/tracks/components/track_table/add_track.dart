import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/tracks_controller.dart';
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
            tc.addTrack(name.text);
            Navigator.pop(context);
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
