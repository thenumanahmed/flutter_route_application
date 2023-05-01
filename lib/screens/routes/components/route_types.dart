import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/models/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_tab_button.dart';

class RouteTypes extends StatelessWidget {
  const RouteTypes({super.key});

  @override
  Widget build(BuildContext context) {
    final rc = Get.find<RouteController>();
    return Obx(() {
      final isMorning = rc.routeState.value == RouteType.morning;
      final isEvening = rc.routeState.value == RouteType.evening;
      final isSpeacial = rc.routeState.value == RouteType.speacial;

      return Row(
        children: [
          CustomTabButton(
            boxCurveType: BoxCurveType.left,
            isSelected: isMorning,
            onTap: () =>
                !isMorning ? rc.routeState.value = RouteType.morning : null,
            text: 'Morning',
          ),
          CustomTabButton(
            boxCurveType: BoxCurveType.none,
            isSelected: isEvening,
            onTap: () =>
                !isEvening ? rc.routeState.value = RouteType.evening : null,
            text: 'Evening',
          ),
          CustomTabButton(
            boxCurveType: BoxCurveType.right,
            isSelected: isSpeacial,
            onTap: () =>
                !isSpeacial ? rc.routeState.value = RouteType.speacial : null,
            text: 'Speacial',
          ),
        ],
      );
    });
  }
}
