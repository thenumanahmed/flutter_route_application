import 'package:flutter/material.dart';

import '../.../../../../configs/themes/ui_parameters.dart';
import 'route_table.dart';
import 'route_types.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
      child: Column(
        children: [
          RouteTypes(),
          kHeightSpace,
          RouteTable(),
        ],
      ),
    );
  }
}
