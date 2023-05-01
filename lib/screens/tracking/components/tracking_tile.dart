import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import 'package:dashboard_route_app/controllers/tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../models/tracking.dart';
import '../../../widgets/progress_line.dart';

class TrackingTile extends StatelessWidget {
  const TrackingTile(
      {super.key, required this.listWidth, required this.tracking});
  final double listWidth;
  final Tracking tracking;
  final textStyle = const TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    final track = tracking.track;
    final cS = tracking.stopCovered;
    final tS = track!.stops.length;
    final pS = cS * 100 ~/ tS;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(track.name, style: textStyle),
        Text(tracking.driverName, style: textStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 120,
              child: ProgressLine(
                percentage: pS,
                color: Colors.blue,
              ),
            ),
            kWidthSpace,
            Text(
              '$cS/$tS',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
