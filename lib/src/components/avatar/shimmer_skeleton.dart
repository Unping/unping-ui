import 'package:flutter/widgets.dart';

class ShimmerSkeleton extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;

  const ShimmerSkeleton({
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        return ShaderMask(
          shaderCallback: (rect) {
            // Move gradient from left to right continuously
            final double dx = (rect.width + rect.width) * (progress - 0.5);
            return LinearGradient(
              begin: Alignment(-1.0, -0.1),
              end: Alignment(1.0, 0.1),
              colors: [
                widget.baseColor,
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
              transform: GradientTranslation(dx, 0.0),
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: Container(color: widget.baseColor),
        );
      },
    );
  }
}

class GradientTranslation extends GradientTransform {
  final double translateX;
  final double translateY;

  const GradientTranslation(this.translateX, this.translateY);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.identity()..translateByDouble(translateX, translateY, 0, 1);
  }
}
