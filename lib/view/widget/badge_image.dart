import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import '../../core/class/person_icon_painter.dart';

class BadgeImage extends StatelessWidget {
  final String? imageUrl;
  final Widget? fallback;
  final double size;
  final double borderRadius;
  final bool showContrastBorder;
  final Color contrastBorderColor;

  const BadgeImage({
    super.key,
    this.imageUrl,
    this.fallback,
    this.size = 16.0,
    this.borderRadius = UiRadius.sm,
    this.showContrastBorder = true,
    this.contrastBorderColor = const Color(0x14000000),
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return fallback ?? _buildDefaultAvatar();
        },
      );
    } else {
      child = fallback ?? _buildDefaultAvatar();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          child,
          if (showContrastBorder)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: contrastBorderColor,
                    width: 0.333,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: UiColors.neutral300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: CustomPaint(
        size: Size(size * 0.6, size * 0.6),
        painter: PersonIconPainter(color: UiColors.neutral500),
      ),
    );
  }
}
