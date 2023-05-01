import 'package:flutter/material.dart';

import '../configs/themes/ui_parameters.dart';

class CustomScrollableArea extends StatelessWidget {
  const CustomScrollableArea(
      {super.key, required this.width, required this.widget});

  final double width;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scrollbar(
      thumbVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.top,
      thickness: defaultPadding,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: width,
          child: widget,
        ),
      ),
    );
  }
}
