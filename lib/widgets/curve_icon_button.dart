import 'package:flutter/material.dart';

enum CurveDirection { left, top, right, bottom }

class CurveIconButton extends StatelessWidget {
  const CurveIconButton({
    super.key,
    required this.icon,
    this.onPress,
    this.size = 40,
    this.curveDirection = CurveDirection.right,
    this.background = Colors.white,
    this.foreground = Colors.black54,
  });
  final Function()? onPress;
  final IconData icon;
  final double size;
  final Color background;
  final Color foreground;
  final CurveDirection curveDirection;

  @override
  Widget build(BuildContext context) {
    double size1 = size < 20 ? 20 : size;
    final isVertical = curveDirection == CurveDirection.top ||
        curveDirection == CurveDirection.bottom;
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        height: (isVertical) ? size1 / 2 + 5 : size1,
        width: (isVertical) ? size1 : size1 / 2 + 5,
        child: Stack(
          children: [
            ClipPath(
              clipper: _getClipper(),
              child: Container(
                width: size1,
                height: size1,
                color: background,
              ),
            ),
            Align(
              alignment: (isVertical)
                  ? const Alignment(0, 0)
                  : (curveDirection == CurveDirection.right)
                      ? const Alignment(-0.5, 0)
                      : const Alignment(0.5, 0),
              child: Icon(
                icon,
                color: foreground,
                size: size1 / 2 - size1 / 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getClipper() {
    if (curveDirection == CurveDirection.right) {
      return RightCurve();
    } else if (curveDirection == CurveDirection.left) {
      return LeftCurve();
    } else if (curveDirection == CurveDirection.top) {
      return TopCurve();
    } else {
      return BottomCurve();
    }
  }
}

class RightCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 2, size.height / 2, 0, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height / 2, 0, size.height);
    path.lineTo(0, 0);
    // path.close(); // close the path to fill the shape
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LeftCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(
        -size.width, size.height / 2, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(0, size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TopCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, -size.height, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0); // Move to top right
    path.lineTo(size.width, 0); // Move to bottom right
    path.quadraticBezierTo(size.width / 2, size.height * 2, 0, 0); // Draw curve
    path.lineTo(0, 0); // Move to bottom left
    path.close(); // Close the path to fill the shape
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
