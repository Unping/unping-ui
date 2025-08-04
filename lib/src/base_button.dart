import 'package:flutter/widgets.dart';

/// Position of the icon relative to the text
enum IconPosition {
  /// Icon appears before the text (leading)
  leading,
  /// Icon appears after the text (trailing)
  trailing,
}

/// A base button widget that matches the Figma design pattern.
/// Supports customizable text, icon, and styling with flexible positioning.
class BaseButton extends StatefulWidget {
  /// The text to display on the button (optional)
  final String? text;

  /// The icon to display on the button (optional)
  final Widget? icon;

  /// Position of the icon relative to the text
  final IconPosition iconPosition;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Background color of the button
  final Color? backgroundColor;

  /// Text color
  final Color textColor;

  /// Border color (for outlined style)
  final Color? borderColor;

  /// Border width (for outlined style)
  final double borderWidth;

  /// Font size of the button text
  final double fontSize;

  /// Font weight of the button text
  final FontWeight fontWeight;

  /// Font family of the button text
  final String? fontFamily;

  /// Border radius of the button
  final double borderRadius;

  /// Padding inside the button
  final EdgeInsetsGeometry padding;

  /// Gap between icon and text
  final double gap;

  /// Minimum height of the button
  final double? minHeight;

  /// Minimum width of the button
  final double? minWidth;

  /// Whether the text should be underlined
  final bool underlineText;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Custom loading widget (if null, uses default CircularProgressIndicator)
  final Widget? loadingWidget;

  const BaseButton({
    super.key,
    this.text,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    this.onPressed,
    this.backgroundColor,
    required this.textColor, // No default - must be specified by caller
    this.borderColor, // Nullable to allow no border for ghost buttons
    this.borderWidth = 1.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = 'Outfit',
    this.borderRadius = 4.0,
    EdgeInsetsGeometry? padding,
    this.gap = 8.0,
    this.minHeight = 36.0,//icon only
    this.minWidth = 36.0,//icon only,
    this.underlineText = false,
    this.isLoading = false,
    this.loadingWidget,
  }) : padding = padding ?? (text != null 
      ? const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)
      : const EdgeInsets.all(8.0)), // Use 8px all around when no text
    assert(text != null || icon != null, 'Either text or icon must be provided');

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    if (widget.onPressed != null && !widget.isLoading) {
      widget.onPressed!();
    }
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      color: widget.backgroundColor,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: widget.borderColor != null
          ? Border.all(
              color: widget.borderColor!,
              width: widget.borderWidth,
            )
          : null,
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> children = [];

    if (widget.isLoading) {
      children.add(
        widget.loadingWidget ??
            SizedBox(
              width: 16,
              height: 16,
              child: _CustomCircularProgressIndicator(
                strokeWidth: 2,
                color: widget.textColor,
              ),
            ),
      );
      return children;
    }

    // Build text widget if provided
    Widget? textWidget;
    if (widget.text != null) {
      textWidget = Text(
        widget.text!,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          fontFamily: widget.fontFamily,
          decoration: widget.underlineText ? TextDecoration.underline : null,
          decorationColor: widget.textColor,
          height: 20 / widget.fontSize, // Line height as per Figma design
        ),
      );
    }

    // Build content based on icon position
    if (widget.iconPosition == IconPosition.leading) {
      if (widget.icon != null) children.add(widget.icon!);
      if (widget.icon != null && textWidget != null) {
        children.add(SizedBox(width: widget.gap));
      }
      if (textWidget != null) children.add(textWidget);
    } else {
      if (textWidget != null) children.add(textWidget);
      if (widget.icon != null && textWidget != null) {
        children.add(SizedBox(width: widget.gap));
      }
      if (widget.icon != null) children.add(widget.icon!);
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.minHeight ?? 0,
                minWidth: widget.minWidth ?? 0,
              ),
              decoration: _getDecoration(),
              padding: widget.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildChildren(),
              ),
            ),
          ),
        );
      },
    );
  }
}


/// Custom circular progress indicator that doesn't depend on Material
class _CustomCircularProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final Color color;

  const _CustomCircularProgressIndicator({
    required this.strokeWidth,
    required this.color,
  });

  @override
  State<_CustomCircularProgressIndicator> createState() => _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState extends State<_CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
        return CustomPaint(
          painter: _CircularProgressPainter(
            progress: _controller.value,
            strokeWidth: widget.strokeWidth,
            color: widget.color,
          ),
        );
      },
    );
  }
}

/// Custom painter for the circular progress indicator
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the arc
    const startAngle = -1.5708; // -90 degrees in radians (top of circle)
    final sweepAngle = 2 * 3.14159 * 0.75; // 270 degrees

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + (progress * 2 * 3.14159),
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Predefined button configurations matching common design patterns
class Buttons {
  /// Creates a ghost button
  static BaseButton ghost({
    required String text,
    VoidCallback? onPressed,
    Color textColor = const Color(0xFFFFFFFF), // White text for ghost buttons
    bool underlineText = false,
    Color? backgroundColor,
    Color? borderColor, // Nullable to allow no border
  }) {
    return BaseButton(
      text: text,
      onPressed: onPressed,
      textColor: textColor,
      underlineText: underlineText,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }

  /// Creates a button with filled background
  static BaseButton filled({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    Color backgroundColor = const Color(0xFFFFFFFF), // White background for filled buttons
    Color textColor = const Color(0xFF2A313C), // Grey text for filled buttons
    bool underlineText = false,
  }) {
    return BaseButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      underlineText: underlineText,
    );
  }

  /// Creates a button with outline style
  static BaseButton outline({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    Color borderColor = const Color(0xFFFFFFFF),
    Color textColor = const Color(0xFFFFFFFF), // White text for outline buttons when not specified
    bool underlineText = false,
  }) {
    return BaseButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      borderColor: borderColor,
      textColor: textColor,
      underlineText: underlineText,
    );
  }
}
