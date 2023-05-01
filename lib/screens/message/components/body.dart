import 'package:dashboard_route_app/responsive.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_list/custom_list.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return CustomList(height: Responsive.screenHeight(context)-150, searchBy: (st){return [];}, onSelectedIndexUpdate: , getTile: getTile, list: list);
  }
}
