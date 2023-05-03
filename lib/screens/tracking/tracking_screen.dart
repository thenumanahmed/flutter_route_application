import 'package:dashboard_route_app/dbHelper/mongo_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/ui_parameters.dart';
import '../../controllers/routes_controller.dart';
import '../dashboard/components/header.dart';
import './components/body.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: defaultTopPadding,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Header(title: 'Tracking'),
            ),
            kHeightSpace,
            Obx(() {
              final rc = Get.find<RouteController>();
              final tgc = Get.find<RouteController>();
              if (rc.fetching.value == FetchingState.getting &&
                  tgc.fetching.value == FetchingState.getting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Body();
              }
            }),
          ],
        ),
      ),
    );
  }
}
