import 'package:dashboard_route_app/configs/themes/ui_parameters.dart';
import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/functions/custom_scafold.dart';
import 'package:dashboard_route_app/widgets/custom_alert_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'route_form.dart';
import '../../../models/route.dart' as r;

class EditRoute extends StatefulWidget {
  const EditRoute({super.key, required this.rIndex});
  final int rIndex;
  @override
  State<EditRoute> createState() => _EditRouteState();
}

class _EditRouteState extends State<EditRoute> {
  final name = TextEditingController();
  final track = TextEditingController();
  final driver = TextEditingController();
  final bus = TextEditingController();

  @override
  void initState() {
    final rc = Get.find<RouteController>();
    final route = rc.currentRoute(widget.rIndex);
    name.text = route.name;
    track.text = route.trackName;
    driver.text = route.driverName;
    bus.text = route.busNumber;

    // check if anyone is not_found
    if (name.text == r.Route.notFound) {
      name.text = RouteForm.none;
    }
    if (track.text == r.Route.notFound) {
      track.text = RouteForm.none;
    }
    if (driver.text == r.Route.notFound) {
      driver.text = RouteForm.none;
    }
    if (bus.text == r.Route.notFound) {
      bus.text = RouteForm.none;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RouteForm(
          formKey: GlobalKey(),
          name: name,
          track: track,
          driver: driver,
          bus: bus,
        ),
        kHeightSpace,
        CustomAlertButton(
          onTap: saveRoute,
          title: 'Save Route',
        ),
      ],
    );
  }

  void saveRoute() {
    final rc = Get.find<RouteController>();
    final trackId =
        track.text != RouteForm.none ? rc.stringToTrackId(track.text) : null;
    final driverId =
        driver.text != RouteForm.none ? rc.stringToDriverId(driver.text) : null;
    final busId =
        bus.text != RouteForm.none ? rc.stringToBusId(bus.text) : null;

    rc
        .updateRoute(
      index: widget.rIndex,
      name: name.text,
      trackId: trackId,
      driverId: driverId,
      busId: busId,
    )
        .then((value) {
      if (value == true) {
        Navigator.pop(context);

        customSnackbar(context, value, 'Route Updated');
      } else {
        customSnackbar(context, value, 'Route Updated');
      }
    });
  }
}
