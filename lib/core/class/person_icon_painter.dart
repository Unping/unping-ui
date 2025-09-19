
import 'package:flutter/widgets.dart';
class PersonIconPainter extends CustomPainter {
  final Color color;

  PersonIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final headCenter = Offset(size.width * 0.5, size.height * 0.35);
    final headRadius = size.width * 0.2;
    canvas.drawCircle(headCenter, headRadius, paint);

    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.25,
        size.height * 0.55,
        size.width * 0.5,
        size.height * 0.4,
      ),
      Radius.circular(size.width * 0.25),
    );
    canvas.drawRRect(bodyRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
