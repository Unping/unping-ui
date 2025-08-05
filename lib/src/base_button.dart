import 'package:flutter/widgets.dart';

/// Position of the icon relative to the text
enum IconPosition {
  /// Icon appears before the text (leading)
  leading,
  /// Icon appears after the text (trailing)
  trailing,
}

/// Button visual states
enum ButtonState {
  /// Normal state - default appearance
  normal,
  /// Hovered state - when mouse is over the button
  hovered,
  /// Focused state - when button has keyboard focus
  focused,
  /// Disabled state - when button is not interactive
  disabled,
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

  /// Background color when hovered
  final Color? hoverBackgroundColor;

  /// Background color when focused
  final Color? focusBackgroundColor;

  /// Background color when disabled
  final Color? disabledBackgroundColor;

  /// Text color
  final Color textColor;

  /// Text color when hovered
  final Color? hoverTextColor;

  /// Text color when focused
  final Color? focusTextColor;

  /// Text color when disabled
  final Color? disabledTextColor;

  /// Border color (for outlined style)
  final Color? borderColor;

  /// Border color when hovered
  final Color? hoverBorderColor;

  /// Border color when focused
  final Color? focusBorderColor;

  /// Border color when disabled
  final Color? disabledBorderColor;

  /// Border width (for outlined style)
  final double borderWidth;

  /// Focus ring color (for focus state shadow)
  final Color? focusRingColor;

  /// Focus ring width (for focus state shadow)
  final double focusRingWidth;

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

  /// Force a specific button state (overrides automatic state detection)
  /// Useful for showcasing different states in Widgetbook or design systems
  final ButtonState? forceState;

  const BaseButton({
    super.key,
    this.text,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    this.onPressed,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    required this.textColor, // No default - must be specified by caller
    this.hoverTextColor,
    this.focusTextColor,
    this.disabledTextColor,
    this.borderColor, // Nullable to allow no border for ghost buttons
    this.hoverBorderColor,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.borderWidth = 1.0,
    this.focusRingColor,
    this.focusRingWidth = 3.0,
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
    this.forceState,
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
  bool _isHovered = false;
  bool _isFocused = false;

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

  /// Get the current button state based on conditions
  /// Priority: forceState > disabled > focused > hovered > normal
  ButtonState get _currentState {
    // If forceState is provided, use it (except when disabled)
    if (widget.forceState != null) {
      // Still respect disabled state when onPressed is null
      if (widget.onPressed == null) return ButtonState.disabled;
      return widget.forceState!;
    }
    
    // Normal state detection logic
    if (widget.onPressed == null) return ButtonState.disabled;
    if (_isFocused) return ButtonState.focused;
    if (_isHovered) return ButtonState.hovered;
    return ButtonState.normal;
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
    final currentState = _currentState;
    
    Color? backgroundColor;
    Color? borderColor;
    List<BoxShadow>? boxShadow;
    
    switch (currentState) {
      case ButtonState.disabled:
        backgroundColor = widget.disabledBackgroundColor ?? widget.backgroundColor;
        borderColor = widget.disabledBorderColor ?? widget.borderColor;
        break;
      case ButtonState.focused:
        backgroundColor = widget.focusBackgroundColor ?? widget.backgroundColor;
        borderColor = widget.focusBorderColor ?? widget.borderColor;
        // Add focus ring shadow
        if (widget.focusRingColor != null) {
          boxShadow = [
            BoxShadow(
              color: widget.focusRingColor!,
              offset: Offset.zero,
              blurRadius: 0,
              spreadRadius: widget.focusRingWidth,
            ),
          ];
        }
        break;
      case ButtonState.hovered:
        backgroundColor = widget.hoverBackgroundColor ?? widget.backgroundColor;
        borderColor = widget.hoverBorderColor ?? widget.borderColor;
        break;
      case ButtonState.normal:
        backgroundColor = widget.backgroundColor;
        borderColor = widget.borderColor;
        break;
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: borderColor != null
          ? Border.all(
              color: borderColor,
              width: widget.borderWidth,
            )
          : null,
      boxShadow: boxShadow,
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
      final currentState = _currentState;
      Color textColor;
      
      switch (currentState) {
        case ButtonState.disabled:
          textColor = widget.disabledTextColor ?? widget.textColor;
          break;
        case ButtonState.focused:
          textColor = widget.focusTextColor ?? widget.textColor;
          break;
        case ButtonState.hovered:
          textColor = widget.hoverTextColor ?? widget.textColor;
          break;
        case ButtonState.normal:
          textColor = widget.textColor;
          break;
      }
      
      textWidget = Text(
        widget.text!,
        style: TextStyle(
          color: textColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          fontFamily: widget.fontFamily,
          decoration: widget.underlineText ? TextDecoration.underline : null,
          decorationColor: textColor,
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
    final isDisabled = widget.onPressed == null;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!isDisabled) {
                setState(() => _isFocused = hasFocus);
              }
            },
            child: MouseRegion(
              onEnter: (_) {
                if (!isDisabled) {
                  setState(() => _isHovered = true);
                }
              },
              onExit: (_) {
                if (!isDisabled) {
                  setState(() => _isHovered = false);
                }
              },
              child: GestureDetector(
                onTapDown: isDisabled ? null : _onTapDown,
                onTapUp: isDisabled ? null : _onTapUp,
                onTapCancel: isDisabled ? null : _onTapCancel,
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
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    Color textColor = const Color(0xFFFFFFFF), // White text for ghost buttons
    Color? hoverTextColor, // Can be customized per use case
    Color? focusTextColor, // Can be customized per use case
    Color? disabledTextColor, // Can be customized per use case
    Color? backgroundColor, // Transparent by default for ghost buttons
    Color? hoverBackgroundColor,
    Color? focusBackgroundColor = const Color(0xFF2A313C), // Dark gray background when focused
    Color? disabledBackgroundColor,
    Color? borderColor, // Nullable to allow no border
    Color? hoverBorderColor,
    Color? focusBorderColor, // No focus border for ghost buttons
    Color? disabledBorderColor,
    Color? focusRingColor = const Color(0xFF989DB3), // Focus ring color from Figma
    double focusRingWidth = 3.0,
    bool underlineText = false,
    ButtonState? forceState,
  }) {
    return BaseButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      textColor: textColor,
      hoverTextColor: hoverTextColor,
      focusTextColor: focusTextColor,
      disabledTextColor: disabledTextColor,
      backgroundColor: backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor,
      focusBackgroundColor: focusBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      focusBorderColor: focusBorderColor,
      disabledBorderColor: disabledBorderColor,
      focusRingColor: focusRingColor,
      focusRingWidth: focusRingWidth,
      underlineText: underlineText,
      forceState: forceState,
    );
  }

  /// Creates a button with filled background
  static BaseButton filled({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    Color backgroundColor = const Color(0xFFFFFFFF), // White background for filled buttons
    Color? hoverBackgroundColor = const Color(0xFFABB5C4), // Gray hover color from Figma
    Color? focusBackgroundColor, // Can be customized per use case
    Color? disabledBackgroundColor, // Can be customized per use case
    Color textColor = const Color(0xFF2A313C), // Grey text for filled buttons
    Color? hoverTextColor, // Keep same text color on hover by default
    Color? focusTextColor, // Can be customized per use case
    Color? disabledTextColor, // Can be customized per use case
    Color? borderColor, // No border by default for filled buttons
    Color? hoverBorderColor,
    Color? focusBorderColor = const Color(0xFFFFFFFF), // White border when focused
    Color? disabledBorderColor,
    Color? focusRingColor = const Color(0xFF989DB3), // Focus ring color from Figma
    double focusRingWidth = 3.0,
    bool underlineText = false,
    ButtonState? forceState,
  }) {
    return BaseButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor,
      focusBackgroundColor: focusBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      textColor: textColor,
      hoverTextColor: hoverTextColor,
      focusTextColor: focusTextColor,
      disabledTextColor: disabledTextColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      focusBorderColor: focusBorderColor,
      disabledBorderColor: disabledBorderColor,
      focusRingColor: focusRingColor,
      focusRingWidth: focusRingWidth,
      underlineText: underlineText,
      forceState: forceState,
    );
  }

  /// Creates a button with outline style
  static BaseButton outline({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    Color borderColor = const Color(0xFFFFFFFF),
    Color? hoverBorderColor,
    Color? focusBorderColor,
    Color? disabledBorderColor,
    Color textColor = const Color(0xFFFFFFFF), // White text for outline buttons when not specified
    Color? hoverTextColor,
    Color? focusTextColor,
    Color? disabledTextColor,
    Color? backgroundColor, // Transparent by default for outline buttons
    Color? hoverBackgroundColor = const Color(0xFFABB5C4), // Gray hover color from Figma
    Color? focusBackgroundColor = const Color(0xFF2A313C), // Dark gray background when focused
    Color? disabledBackgroundColor,
    Color? focusRingColor = const Color(0xFF989DB3), // Focus ring color from Figma
    double focusRingWidth = 3.0, // Focus ring width from Figma
    bool underlineText = false,
    ButtonState? forceState,
  }) {
    return BaseButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      focusBorderColor: focusBorderColor,
      disabledBorderColor: disabledBorderColor,
      textColor: textColor,
      hoverTextColor: hoverTextColor,
      focusTextColor: focusTextColor,
      disabledTextColor: disabledTextColor,
      backgroundColor: backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor,
      focusBackgroundColor: focusBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      focusRingColor: focusRingColor,
      focusRingWidth: focusRingWidth,
      underlineText: underlineText,
      forceState: forceState,
    );
  }
}
