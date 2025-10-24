import 'package:flutter/widgets.dart';
import 'package:unping_ui/src/components/avatar/squircle_clipper.dart';

class Squircle extends StatelessWidget {
  const Squircle(
      {Key? key,
      required this.child,
      required this.size,
      this.borderColor,
      this.borderWidth,
      this.color,
      this.opacity})
      : super(key: key);
  final Widget child;
  final double size;
  final Color? color;
  final double? opacity;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    Container children = Container(color: color, child: child);

    if (borderColor != null && borderWidth != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipPath(
          clipper: SquircleClipper(),
          child: Container(
            color: borderColor,
            child: Center(
              child: SizedBox(
                width: size - (borderWidth! * 2),
                height: size - (borderWidth! * 2),
                child: ClipPath(
                  clipper: SquircleClipper(),
                  child: children,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipPath(
        clipper: SquircleClipper(),
        child: children,
      ),
    );
  }
}
