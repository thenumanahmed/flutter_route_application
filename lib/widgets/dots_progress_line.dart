import 'package:flutter/material.dart';

import '../configs/themes/app_color.dart';

class DotsProgressLine extends StatelessWidget {
  const DotsProgressLine({
    super.key,
    this.color = primaryColorLight,
    this.height = 5,
    required this.currentStop,
    required this.stops,
  });

  final Color color;
  final double height;
  final int currentStop;
  final List<String> stops;

  @override
  Widget build(BuildContext context) {
    final percentage = (currentStop) * 100 ~/ stops.length;
    return SizedBox(
      height: height + 10,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: height,
                  width: constraints.maxWidth * (percentage / 100),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...getCircles(height + 5),
                //  List.generate(length, (index) => CustomCircle(size: size, color: color)
                //  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getCircles(double circleHeight) {
    List<Widget> circles = [];
    // first simple Sicrcle
    circles.add(CustomCircleTip(
      size: circleHeight,
      color: Colors.transparent,
      message: 'UET',
    ));
    // Filed Circles
    int i = 0;
    for (i = 0; i < currentStop; i++) {
      circles.add(CustomCircleTip(
        size: circleHeight,
        color: Colors.pink,
        message: stops[i],
      ));
    }
    // Not Reached Circles
    for (i; i < stops.length; i++) {
      circles.add(CustomCircleTip(
        size: circleHeight,
        color: const Color.fromARGB(255, 223, 142, 169),
        message: stops[i],
      ));
    }

    return circles;
  }
}

class CustomCircle extends StatelessWidget {
  const CustomCircle({
    super.key,
    required this.size,
    required this.color,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}

class CustomCircleTip extends StatelessWidget {
  const CustomCircleTip({
    super.key,
    required this.size,
    required this.color,
    required this.message,
  });
  final double size;
  final Color color;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size),
        ),
      ),
    );
  }
}
