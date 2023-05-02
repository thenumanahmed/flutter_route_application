import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/track/tracks_controller.dart';
import '../../../controllers/tracking_controller.dart';
import '../../../widgets/dots_progress_line.dart';
import '../../../widgets/custom_icon_button.dart';

class TrackingDetails extends StatelessWidget {
  const TrackingDetails({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    final tgc = Get.find<TrackingController>();

    // return Obx(() {
    tgc.trackingState.value;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(
          left: defaultPadding, bottom: defaultPadding, right: defaultPadding),
      padding: defaultEdgePadding,
      child: Obx(() {
        // ignore: invalid_use_of_protected_member
        final tracking = tgc.trackings.value[tgc.indexes[0]];
        final track = tracking.track;
        final String routeName = tracking.routeName;
        final String routeType = tracking.typeCharacter;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  routeName,
                  style: const TextStyle(color: Colors.black),
                ),
                kWidthSpace,
                Chip(
                  label: Text('${routeType[0].capitalize}',
                      style: const TextStyle(color: Colors.black)),
                ),
                const Spacer(),
                CustomIconButton(
                  onTap: () => tgc.stopTracking([tgc.indexes[0]]),
                  icon: Icons.stop_circle_rounded,
                  color: Colors.redAccent,
                  message: 'Stop Tracking',
                ),
              ],
            ),
            kHeightSpace,
            Text(tracking.driverName,
                style: const TextStyle(color: Colors.black)),
            kHeightSpace,
            if (track != null)
              DotsProgressLine(
                height: 10,
                currentStop: tracking.stopCovered,
                stops: List.generate(
                    track.stops.length, (index) => track.stops[index].name),
              ),
          ],
        );
      }),
    );
    // });
  }
}
