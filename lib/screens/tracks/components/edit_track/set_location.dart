import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../configs/themes/custom_text_styles.dart';
import '../../../../configs/themes/ui_parameters.dart';
import '../../../../functions/custom_dialog.dart';
import '../../../../functions/latlng_string.dart';
import '../../../../widgets/custom_alert_buttons.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'center_map.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({
    super.key,
    required this.location,
  });
  final TextEditingController location;

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.location,
      style: kTextStyle,
      validator: validateLatLngString,
      decoration: InputDecoration(
        labelText: 'Location',
        hintText: '31.77,45.666',
        hintStyle: kHintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixButton(
          onTap: () {
            customDialog(
              context: context,
              title: 'Set Marker',
              widget: setMarker(context, widget.location),
            );
          },
          message: 'Set Location by Map',
          icon: Icons.add_location,
        ),
      ),
    );
  }

  String? validateLatLngString(String? value) {
    const regex =
        r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),[-+]?((1[0-7]|[1-9])?\d(\.\d+)?|180(\.0+)?)$';

    if (value == null || value.isEmpty) {
      return 'Postion cannot be empty.';
    }

    if (!RegExp(regex).hasMatch(value)) {
      return 'Invalid format. Please use the format "double,double".';
    }

    return null; // Return null if there are no validation errors
  }

  SizedBox setMarker(BuildContext context, TextEditingController location) {
    final mc = MapController();
    return SizedBox(
      height: 500,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Container(
            color: Colors.amber,
            child: CenterMap(
              mc: mc,
              center: stringToLatLng(location.text),
            ),
          )),
          kHalfHeightpace,
          CustomAlertButton(
            onTap: () {
              final pos = mc.center;
              location.text = latLngToString(pos);
              Navigator.pop(context);
            },
            title: 'Add',
          ),
        ],
      ),
    );
  }
}
