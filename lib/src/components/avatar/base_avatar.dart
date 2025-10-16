import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:unping_ui/unping_ui.dart';
import 'package:universal_image/universal_image.dart';
import 'package:figma_squircle/figma_squircle.dart';

/// A base avatar widget that supports images, initials, and icons
class BaseAvatar extends StatefulWidget {
  /// Image URL for image-based avatars
  final String? imageUrl;

  /// Initials text for text-based avatars
  final String? initials;

  /// Icon for icon-based avatars
  final IconData? icon;

  /// Custom widget to display (overrides image/initials/icon)
  final Widget? child;

  /// Fallback widget when image fails to load
  final Widget? fallback;

  /// Size of the avatar
  final AvatarSize size;

  /// Shape of the avatar
  final AvatarShape shape;

  /// Background color
  final Color backgroundColor;

  /// Text/icon color
  final Color foregroundColor;

  /// Optional border color
  final Color? borderColor;

  /// Border width
  final double borderWidth;

  /// Optional badge widget
  final AvatarBadge? badge;

  /// Badge position (if badge is provided)
  final BadgePosition badgePosition;

  /// Optional semantic label for accessibility
  /// When null/empty, a descriptive label is derived automatically based on content.
  final String? semanticsLabel;

  final

      /// Custom border radius (overrides default for shape)
      double? borderRadius;

  /// Text style for initials
  final TextStyle? textStyle;

  const BaseAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.child,
    this.fallback,
    this.size = AvatarSize.md,
    this.shape = AvatarShape.roundedRectangle,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.badge,
    this.badgePosition = BadgePosition.bottomRight,
    this.semanticsLabel,
    this.borderRadius,
    this.textStyle,
  });

  @override
  State<BaseAvatar> createState() => _BaseAvatarState();
}

class _BaseAvatarState extends State<BaseAvatar> {
  // bool _imageLoadError = false;

  double get _avatarSize => AvatarSizeHelper.getSize(widget.size);

  double get _borderRadius {
    if (widget.borderRadius != null) return widget.borderRadius!;
    if (widget.shape == AvatarShape.circle) return _avatarSize / 2;
    return AvatarSizeHelper.getBorderRadius(widget.size);
  }

  ShapeBorder get _shapeBorder {
    if (widget.shape == AvatarShape.circle) {
      return CircleBorder(
        side: widget.borderColor != null
            ? BorderSide(color: widget.borderColor!, width: widget.borderWidth)
            : BorderSide.none,
      );
    } else {
      // Use RSuperellipse for rounded rectangles
      return SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: _borderRadius,
          cornerSmoothing: 1.0, // Full squircle effect
        ),
        side: widget.borderColor != null
            ? BorderSide(color: widget.borderColor!, width: widget.borderWidth)
            : BorderSide.none,
      );
    }
  }

  Widget _buildContent() {
    // Priority: child > image > initials > icon > fallback
    if (widget.child != null) {
      return widget.child!;
    }

    if (widget.imageUrl != null) {
      return _buildImageAvatar();
    }

    if (widget.initials != null) {
      return _buildInitialsAvatar();
    }

    if (widget.icon != null) {
      return _buildIconAvatar();
    }

    return _buildDefaultAvatar();
  }

  Widget _buildImageAvatar() {
    Widget imageWidget = UniversalImage(
      widget.imageUrl!,
      width: _avatarSize,
      height: _avatarSize,
      fit: BoxFit.cover,
      placeholder: _buildLoadingState(),
      errorBuilder: (context, url, error) =>
          widget.fallback ?? _buildDefaultAvatar(),
    );

    // Use appropriate clipping based on shape
    if (widget.shape == AvatarShape.circle) {
      return ClipOval(child: imageWidget);
    } else {
      return ClipSmoothRect(
        radius: SmoothBorderRadius(
          cornerRadius: _borderRadius,
          cornerSmoothing: 1.0,
        ),
        child: imageWidget,
      );
    }
  }

  Widget _buildInitialsAvatar() {
    final fontSize =
        widget.textStyle?.fontSize ?? AvatarSizeHelper.getFontSize(widget.size);

    return Center(
      child: Text(
        widget.initials!,
        style: (widget.textStyle ?? UiTextStyles.textSm).copyWith(
          fontSize: fontSize,
          color: widget.foregroundColor,
          fontWeight: UiTextStyles.semiBold,
        ),
      ),
    );
  }

  Widget _buildIconAvatar() {
    return Center(
      child: Icon(
        widget.icon!,
        size: AvatarSizeHelper.getIconSize(widget.size),
        color: widget.foregroundColor,
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Center(
      child: CustomPaint(
        size: Size.square(AvatarSizeHelper.getIconSize(widget.size)),
        painter: _PersonIconPainter(color: widget.foregroundColor),
      ),
    );
  }

  Widget _buildLoadingState() {
    return _ShimmerSkeleton(
      baseColor: UiColors.neutral500,
      highlightColor: UiColors.neutral400,
    );
  }

  Widget _buildPositionedBadge() {
    final badge = widget.badge!;
    final badgeSize = badge.size;
    final nudge = badgeSize * 0.12;

    // For rounded rectangles (default), pin to outer corners
    if (widget.shape == AvatarShape.roundedRectangle) {
      return switch (widget.badgePosition) {
        BadgePosition.topLeft =>
          Positioned(left: -nudge, top: -nudge, child: badge),
        BadgePosition.topRight =>
          Positioned(right: -nudge, top: -nudge, child: badge),
        BadgePosition.bottomLeft =>
          Positioned(left: -nudge, bottom: -nudge, child: badge),
        BadgePosition.bottomRight =>
          Positioned(right: -nudge, bottom: -nudge, child: badge)
      };
    }

    // For circles, place the badge tangent to the circle at the specified quadrant
    final radius = _avatarSize / 2;
    final center = Offset(radius, radius);

    final angle = switch (widget.badgePosition) {
      BadgePosition.topLeft => 225 * (math.pi / 180), // 225°
      BadgePosition.topRight => 315 * (math.pi / 180), // 315°
      BadgePosition.bottomLeft => 135 * (math.pi / 180), // 135°
      BadgePosition.bottomRight => 45 * (math.pi / 180), // 45°
    };

    // Position the badge center slightly outside the circle for visual balance
    final badgeCenter = Offset(
      center.dx + (radius + badgeSize * 0.2) * math.cos(angle),
      center.dy + (radius + badgeSize * 0.2) * math.sin(angle),
    );

    return Positioned(
      left: badgeCenter.dx - badgeSize / 2,
      top: badgeCenter.dy - badgeSize / 2,
      child: badge,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Derive a sensible semantics label if none provided
    String? resolvedSemanticsLabel = widget.semanticsLabel;
    if (resolvedSemanticsLabel == null || resolvedSemanticsLabel.isEmpty) {
      if (widget.initials != null && widget.initials!.isNotEmpty) {
        resolvedSemanticsLabel = 'Avatar: ${widget.initials}';
      } else if (widget.icon != null) {
        resolvedSemanticsLabel = 'Avatar icon';
      } else if (widget.imageUrl != null) {
        resolvedSemanticsLabel = 'User avatar image';
      } else {
        resolvedSemanticsLabel = 'User avatar';
      }
    }

    Widget avatar = Container(
      width: _avatarSize,
      height: _avatarSize,
      decoration: ShapeDecoration(
        color: widget.backgroundColor,
        shape: _shapeBorder,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(),
    );

    // Add badge if provided
    if (widget.badge != null) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          _buildPositionedBadge(),
        ],
      );
    }

    // Add semantics
    avatar = Semantics(
      label: resolvedSemanticsLabel,
      image: widget.imageUrl != null,
      child: avatar,
    );

    return avatar;
  }
}

/// Simple loading spinner for avatar loading states
class _ShimmerSkeleton extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;

  const _ShimmerSkeleton({
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<_ShimmerSkeleton>
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
    return Matrix4.identity()..translate(translateX, translateY);
  }
}

/// Custom painter for person icon (default avatar)
class _PersonIconPainter extends CustomPainter {
  final Color color;

  _PersonIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw head (circle)
    final headCenter = Offset(size.width * 0.5, size.height * 0.35);
    final headRadius = size.width * 0.25;
    canvas.drawCircle(headCenter, headRadius, paint);

    // Draw body (rounded rectangle)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.6,
        size.width * 0.6,
        size.height * 0.45,
      ),
      Radius.circular(size.width * 0.3),
    );
    canvas.drawRRect(bodyRect, paint);
  }

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  // coverage:ignore-end
}
