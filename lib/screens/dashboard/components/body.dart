import 'package:dashboard_route_app/controllers/bus_controller.dart';
import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import 'package:dashboard_route_app/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/tracking_controller.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final uc = Get.find<UsersController>();
    final rc = Get.find<RouteController>();
    final tgc = Get.find<TrackingController>();
    final bc = Get.find<BusController>();

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            tc.copyTracksToClipboard();
          },
          child: const Text('Tracks'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyMembersToClipboard();
          },
          child: const Text('Members'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyAdminsToClipboard();
          },
          child: const Text('Admins'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyDriversToClipboard();
          },
          child: const Text('Drivers'),
        ),
        ElevatedButton(
          onPressed: () {
            bc.copyBusToClipboard();
          },
          child: const Text('Buses'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copyMorningToClipboard();
          },
          child: const Text('Mornign'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copyEveningToClipboard();
          },
          child: const Text('Evenuing'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copySpeacialToClipboard();
          },
          child: const Text('Speacial'),
        ),
        ElevatedButton(
          onPressed: () {
            tgc.copyTrackingToClipboard();
          },
          child: const Text('Tracking'),
        ),

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       flex: Responsive.isDesktop(context) ? 5 : 6,
        //       child: Column(
        //         children: [
        //           const MyFiles(),
        //           const RecentFiles(),
        //           if (Responsive.isMobile(context))
        //             const Padding(
        //               padding: EdgeInsets.only(top: defaultPadding),
        //               child: StorageDetails(),
        //             ),
        //         ],
        //       ),
        //     ),
        //     if (!Responsive.isMobile(context))
        //       Expanded(
        //         flex: Responsive.isDesktop(context) ? 2 : 3,
        //         child: const Padding(
        //           padding: EdgeInsets.only(left: defaultPadding),
        //           child: StorageDetails(),
        //         ),
        //       )
        //   ],
        // ),
      ],
    );
  }
}
