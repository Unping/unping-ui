import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

class BadgeDot extends StatelessWidget {
  final double size;
  final Color color;
  final bool showOutline;
  final Color outlineColor;
  final double outlineWidth;

  const BadgeDot({
    super.key,
    this.size = 6.0,
    this.color = UiColors.success500,
    this.showOutline = false,
    this.outlineColor = UiColors.background,
    this.outlineWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: showOutline
            ? Border.all(
                color: outlineColor,
                width: outlineWidth,
              )
            : null,
      ),
    );
  }
}
