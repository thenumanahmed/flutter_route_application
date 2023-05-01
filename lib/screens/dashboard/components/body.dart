import 'package:dashboard_route_app/controllers/bus_controller.dart';
import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import 'package:dashboard_route_app/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/tracking_controller.dart';
import '../../../responsive.dart';
import './my_files.dart';
import './recent_files.dart';
import './storage_details.dart';

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
          child: Text('Tracks'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyMembersToClipboard();
          },
          child: Text('Members'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyAdminsToClipboard();
          },
          child: Text('Admins'),
        ),
        ElevatedButton(
          onPressed: () {
            uc.copyDriversToClipboard();
          },
          child: Text('Drivers'),
        ),
        ElevatedButton(
          onPressed: () {
            bc.copyBusToClipboard();
          },
          child: Text('Buses'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copyMorningToClipboard();
          },
          child: Text('Mornign'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copyEveningToClipboard();
          },
          child: Text('Evenuing'),
        ),
        ElevatedButton(
          onPressed: () {
            rc.copySpeacialToClipboard();
          },
          child: Text('Speacial'),
        ),
        ElevatedButton(
          onPressed: () {
            tgc.copyTrackingToClipboard();
          },
          child: Text('Tracking'),
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
