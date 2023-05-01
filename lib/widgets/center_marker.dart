import 'package:flutter/material.dart';
import '../configs/themes/app_color.dart';

class CenterMarker extends StatelessWidget {
  const CenterMarker({
    super.key,
    this.size = 40,
    this.color = markerColor,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size * 2,
        child: Align(
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.location_on_rounded,
            size: size,
            color: color,
          ),
        ),
      ),
    );
  }
}
