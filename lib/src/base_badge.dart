import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// Badge size variants
enum BadgeSize {
  /// Small badge - compact size
  sm,

  /// Medium badge - default size
  md,

  /// Large badge - expanded size
  lg,
}

/// A base badge widget that matches the Figma design pattern.
/// Supports customizable text, left widgets (up to 2), right widget (up to 1), and removable functionality.
class BaseBadge extends StatefulWidget {
  /// The text to display on the badge (required)
  final String text;

  /// First widget on the left side (optional)
  final Widget? leftWidget1;

  /// Second widget on the left side (optional)
  final Widget? leftWidget2;

  /// Widget on the right side (optional)
  final Widget? rightWidget;

  /// Whether the badge can be removed (shows X button)
  final bool removable;

  /// Callback when the remove button is pressed
  final VoidCallback? onRemove;

  /// Size of the badge
  final BadgeSize size;

  /// Background color of the badge
  final Color backgroundColor;

  /// Text color
  final Color textColor;

  /// Border color (optional)
  final Color? borderColor;

  /// Border width
  final double borderWidth;

  /// Text style for the badge text (defaults to UiTextStyles based on size)
  final TextStyle textStyle;

  /// Border radius of the badge
  final double borderRadius;

  /// Padding inside the badge
  final EdgeInsetsGeometry padding;

  /// Gap between widgets
  final double gap;

  /// Minimum height of the badge
  final double? minHeight;

  BaseBadge({
    super.key,
    required this.text,
    this.leftWidget1,
    this.leftWidget2,
    this.rightWidget,
    this.removable = false,
    this.onRemove,
    this.size = BadgeSize.md,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.borderWidth = 1.0,
    TextStyle? textStyle,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    double? gap,
    this.minHeight,
  })  : textStyle = textStyle ?? _getDefaultTextStyle(size),
        borderRadius = borderRadius ?? _getDefaultBorderRadius(size),
        padding = padding ?? _getDefaultPadding(size),
        gap = gap ?? _getDefaultGap(size);

  @override
  State<BaseBadge> createState() => _BaseBadgeState();

  /// Get default text style based on badge size
  static TextStyle _getDefaultTextStyle(BadgeSize size) {
    switch (size) {
      case BadgeSize.sm:
        return UiTextStyles.textXs.copyWith(fontWeight: UiTextStyles.medium);
      case BadgeSize.md:
        return UiTextStyles.textSm.copyWith(fontWeight: UiTextStyles.medium);
      case BadgeSize.lg:
        return UiTextStyles.textMd.copyWith(fontWeight: UiTextStyles.medium);
    }
  }

  /// Get default border radius based on badge size
  static double _getDefaultBorderRadius(BadgeSize size) {
    switch (size) {
      case BadgeSize.sm:
        return UiRadius.xs;
      case BadgeSize.md:
        return UiRadius.sm;
      case BadgeSize.lg:
        return UiRadius.sm;
    }
  }

  /// Get default padding based on badge size
  static EdgeInsetsGeometry _getDefaultPadding(BadgeSize size) {
    switch (size) {
      case BadgeSize.sm:
        return const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0);
      case BadgeSize.md:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case BadgeSize.lg:
        return const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0);
    }
  }

  /// Get default gap based on badge size
  static double _getDefaultGap(BadgeSize size) {
    switch (size) {
      case BadgeSize.sm:
        return 4.0;
      case BadgeSize.md:
        return 6.0;
      case BadgeSize.lg:
        return 8.0;
    }
  }
}

class _BaseBadgeState extends State<BaseBadge> {
  bool _isVisible = true;

  void _handleRemove() {
    if (widget.onRemove != null) {
      widget.onRemove!();
    } else {
      setState(() {
        _isVisible = false;
      });
    }
  }

  Widget _buildRemoveButton() {
    return GestureDetector(
      onTap: _handleRemove,
      child: Container(
        width: 14.0,
        height: 14.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CustomPaint(
          painter: _XIconPainter(color: widget.textColor),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> children = [];

    // Add left widgets
    if (widget.leftWidget1 != null) {
      children.add(widget.leftWidget1!);
      children.add(SizedBox(width: widget.gap));
    }

    if (widget.leftWidget2 != null) {
      children.add(widget.leftWidget2!);
      children.add(SizedBox(width: widget.gap));
    }

    // Add text
    children.add(
      Text(
        widget.text,
        style: widget.textStyle.copyWith(
          color: widget.textColor,
        ),
      ),
    );

    // Add right widget (only if not removable)
    if (widget.rightWidget != null && !widget.removable) {
      children.add(SizedBox(width: widget.gap));
      children.add(widget.rightWidget!);
    }

    // Add remove button (if removable)
    if (widget.removable) {
      children.add(SizedBox(width: widget.gap));
      children.add(_buildRemoveButton());
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: BoxConstraints(
        minHeight: widget.minHeight ?? 0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.borderColor != null
            ? Border.all(
                color: widget.borderColor!,
                width: widget.borderWidth,
              )
            : null,
      ),
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildChildren(),
      ),
    );
  }
}

/// Avatar widget for badges
class BadgeImage extends StatelessWidget {
  /// URL or path to the avatar image
  final String? imageUrl;

  /// Fallback widget when no image is provided
  final Widget? fallback;

  /// Size of the avatar
  final double size;

  /// Border radius of the avatar
  final double borderRadius;

  /// Whether to show a contrast border
  final bool showContrastBorder;

  /// Contrast border color
  final Color contrastBorderColor;

  const BadgeImage({
    super.key,
    this.imageUrl,
    this.fallback,
    this.size = 16.0,
    this.borderRadius = UiRadius.sm,
    this.showContrastBorder = true,
    this.contrastBorderColor = const Color(0x14000000), // 8% opacity black
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
        painter: _PersonIconPainter(color: UiColors.neutral500),
      ),
    );
  }
}

/// Count badge widget for badges
class BadgeCount extends StatelessWidget {
  /// The count number to display
  final int count;

  /// Maximum count to display before showing "99+"
  final int maxCount;

  /// Background color of the count badge
  final Color backgroundColor;

  /// Text color of the count
  final Color textColor;

  /// Text style for the count text (defaults to UiTextStyles.textXs with medium weight)
  final TextStyle textStyle;

  /// Border radius of the count badge
  final double borderRadius;

  /// Padding inside the count badge
  final EdgeInsetsGeometry padding;

  BadgeCount({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.backgroundColor = UiColors.neutral100,
    this.textColor = UiColors.neutral800,
    TextStyle? textStyle,
    this.borderRadius = UiRadius.xs,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
  }) : textStyle = textStyle ??
            UiTextStyles.textXs.copyWith(fontWeight: UiTextStyles.medium);

  @override
  Widget build(BuildContext context) {
    final displayText = count > maxCount ? '$maxCount+' : count.toString();

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
      child: Text(
        displayText,
        style: textStyle.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}

/// Dot indicator widget for badges
class BadgeDot extends StatelessWidget {
  /// Size of the dot
  final double size;

  /// Color of the dot
  final Color color;

  /// Whether to show an outline/border
  final bool showOutline;

  /// Color of the outline
  final Color outlineColor;

  /// Width of the outline
  final double outlineWidth;

  const BadgeDot({
    super.key,
    this.size = 6.0,
    this.color = UiColors.success500, // Success green from palette
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

/// Predefined badge configurations matching common design patterns
class Badges {
  /// Creates a default badge with dark background
  static BaseBadge badge({
    required String text,
    Widget? leftWidget1,
    Widget? leftWidget2,
    Widget? rightWidget,
    bool removable = false,
    VoidCallback? onRemove,
    BadgeSize size = BadgeSize.md,
    Color backgroundColor = UiColors.neutral700,
    Color textColor = UiColors.onPrimary,
    Color? borderColor = UiColors.neutral300,
  }) {
    return BaseBadge(
      text: text,
      leftWidget1: leftWidget1,
      leftWidget2: leftWidget2,
      rightWidget: rightWidget,
      removable: removable,
      onRemove: onRemove,
      size: size,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
    );
  }

  /// Creates a checkbox for use in badges
  /// Uses the BaseCheckbox component with appropriate sizing for badges
  static BaseCheckbox checkbox({
    bool isChecked = false,
    ValueChanged<bool>? onChanged,
    double? size,
    Color? backgroundColor,
    Color? borderColor,
    Color? checkColor,
  }) {
    // Convert bool to CheckboxState
    final state = isChecked ? CheckboxState.checked : CheckboxState.unchecked;

    // Convert bool callback to CheckboxState callback
    ValueChanged<CheckboxState>? checkboxCallback;
    if (onChanged != null) {
      checkboxCallback = (CheckboxState newState) {
        onChanged(newState == CheckboxState.checked);
      };
    }

    // Determine appropriate size for badges
    CheckboxSize checkboxSize;
    if (size != null) {
      if (size <= 16.0) {
        checkboxSize = CheckboxSize.sm;
      } else if (size <= 20.0) {
        checkboxSize = CheckboxSize.md;
      } else {
        checkboxSize = CheckboxSize.lg;
      }
    } else {
      checkboxSize = CheckboxSize.sm; // Default to small for badges
    }

    return BaseCheckbox(
      state: state,
      onChanged: checkboxCallback,
      size: checkboxSize,
      shape: CheckboxShape.rectangle,
      checkedBackgroundColor: backgroundColor ?? const Color(0xFF3B4554),
      uncheckedBackgroundColor: UiColors.background,
      checkedBorderColor: borderColor ?? const Color(0xFF3B4554),
      uncheckedBorderColor: borderColor ?? UiColors.neutral300,
      checkColor: checkColor ?? UiColors.onPrimary,
    );
  }
}

/// Custom painter for X (close) icon
class _XIconPainter extends CustomPainter {
  final Color color;

  _XIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw X shape
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.75),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.25),
      Offset(size.width * 0.25, size.height * 0.75),
      paint,
    );
  }

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  // coverage:ignore-end
}

/// Custom painter for person icon
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
    final headRadius = size.width * 0.2;
    canvas.drawCircle(headCenter, headRadius, paint);

    // Draw body (rounded rectangle)
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

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  // coverage:ignore-end
}
