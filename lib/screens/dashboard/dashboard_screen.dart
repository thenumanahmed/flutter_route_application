import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';
import './components/header.dart';
import 'components/body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: defaultEdgePadding,
        child: Column(
          children: const [
            Header(title: 'Dashboard'),
            kHeightSpace,
            Body(),
          ],
        ),
      ),
    );
  }
}
