import 'package:flutter/material.dart';

import '../../../configs/themes/app_color.dart';
import '../../../configs/themes/ui_parameters.dart';

enum BoxCurveType { none, left, right }

class CustomTabButton extends StatelessWidget {
  const CustomTabButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.boxCurveType = BoxCurveType.none,
    required this.onTap,
  });
  final String text;
  final bool isSelected;
  final Function() onTap;
  final BoxCurveType boxCurveType;
  final height = 45.0;
  final width = 100.0;

  BorderRadius? getBorderRadius() {
    if (boxCurveType == BoxCurveType.none) {
      return null;
    } else if (boxCurveType == BoxCurveType.left) {
      return const BorderRadius.horizontal(left: Radius.circular(10));
    } else if (boxCurveType == BoxCurveType.right) {
      return const BorderRadius.horizontal(right: Radius.circular(10));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: defaultEdgePadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? primaryColorLight : Colors.white,
          borderRadius: getBorderRadius(),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
