import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';
import '../dashboard/components/header.dart';
import './components/body.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: defaultEdgePadding,
        child: Column(
          children: const [
            Header(title: 'Tracks'),
            kHeightSpace,
            Body(),
          ],
        ),
      ),
    );
  }
}
