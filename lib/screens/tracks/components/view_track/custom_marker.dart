import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({
    super.key,
    this.message = '',
    this.icon = Icons.circle,
    this.size = 25.0,
    this.isAbove = true,
    this.color = Colors.blueAccent,
  });
  final String message;
  final IconData icon;
  final double size;
  final bool isAbove;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: size,
            color: color,
          ),
          SizedBox(
            height: isAbove ? size : 0,
          )
        ],
      ),
    );
  }
}
