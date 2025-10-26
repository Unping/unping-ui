import 'package:flutter/widgets.dart';

class SquircleClipper extends CustomClipper<Path> {
  SquircleClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 100;
    final double yScaling = size.height / 100;

    double leftCenterAnglePoint = 50 * yScaling;
    double rightCenterAnglePoint = 50 * yScaling;

    path.lineTo(0 * xScaling, leftCenterAnglePoint);

    path.cubicTo(
      0 * xScaling,
      8.825 * yScaling,
      8.825 * xScaling,
      0 * yScaling,
      50 * xScaling,
      0 * yScaling,
    );

    path.cubicTo(
      91.175 * xScaling,
      0 * yScaling,
      100 * xScaling,
      8.825 * yScaling,
      100 * xScaling,
      rightCenterAnglePoint,
    );

    path.cubicTo(
      100 * xScaling,
      91.175 * yScaling,
      91.175 * xScaling,
      100 * yScaling,
      50 * xScaling,
      100 * yScaling,
    );

    path.cubicTo(
      8.825 * xScaling,
      100 * yScaling,
      0 * xScaling,
      91.175 * yScaling,
      0 * xScaling,
      50 * yScaling,
    );

    path.cubicTo(
      0 * xScaling,
      50 * yScaling,
      0 * xScaling,
      50 * yScaling,
      0 * xScaling,
      50 * yScaling,
    );

    return path;
  }

  // coverage:ignore-start
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
  // coverage:ignore-end
}
