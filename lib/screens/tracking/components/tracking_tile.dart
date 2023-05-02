import 'package:flutter/material.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../models/tracking.dart';
import '../../../widgets/progress_line.dart';

class TrackingTile extends StatelessWidget {
  const TrackingTile(
      {super.key, required this.listWidth, required this.dTracking});
  final double listWidth;
  final dynamic dTracking;
  final textStyle = const TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    final tracking = dTracking as Tracking;
    final cS = tracking.stopCovered;
    final tS = tracking.totalStops;
    final pS = tS != 0 ? cS * 100 ~/ tS : 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tracking.routeName, style: textStyle),
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
