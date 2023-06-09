import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../functions/custom_snackbar.dart';
import './route_form.dart';
import '../../../models/route.dart' as r;
import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/routes_controller.dart';
import '../../../widgets/custom_alert_buttons.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({super.key});

  @override
  State<AddRoute> createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  final name = TextEditingController();
  final track = TextEditingController();
  final driver = TextEditingController();
  final bus = TextEditingController();

  @override
  void initState() {
    track.text = 'none';
    driver.text = 'none';
    bus.text = 'none';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RouteForm(
          formKey: formKey,
          name: name,
          track: track,
          driver: driver,
          bus: bus,
        ),
        kHeightSpace,
        CustomAlertButton(
          onTap: () {
            if (formKey.currentState!.validate() == false) {
              return;
            }
            final rc = Get.find<RouteController>();
            final trackId = track.text != RouteForm.none
                ? rc.stringToTrackId(track.text)
                : null;
            final driverId = driver.text != RouteForm.none
                ? rc.stringToDriverId(driver.text)
                : null;
            final busId =
                bus.text != RouteForm.none ? rc.stringToBusId(bus.text) : null;

            final route = r.Route(
              id: mongo.ObjectId(),
              name: name.text,
              trackId: trackId,
              driverId: driverId,
              busId: busId,
              type: rc.routeState.value,
            );
            rc.addRoute(route).then((value) {
              if (value) {
                Navigator.pop(context);
                customSnackbar(context, value, 'Add Route');
              } else {
                customSnackbar(context, value, 'Add Route');
              }
            });

            rc.routeState.value = rc.routeState.value;
          },
          title: 'Add Route',
        ),
      ],
    );
  }
}
