import 'package:flutter/material.dart';

/// A customizable, animated button widget with modern design features
class CoolButton extends StatefulWidget {
  /// The text to display on the button
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Width of the button. If null, adapts to content
  final double? width;

  /// Height of the button
  final double height;

  /// Primary color for the button gradient
  final Color primaryColor;

  /// Secondary color for the button gradient
  final Color secondaryColor;

  /// Text color
  final Color textColor;

  /// Font size of the button text
  final double fontSize;

  /// Border radius of the button
  final double borderRadius;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Icon to display before the text (optional)
  final IconData? icon;

  /// Button style variant
  final CoolButtonStyle style;

  /// Animation duration
  final Duration animationDuration;

  /// Shadow elevation
  final double elevation;

  const CoolButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 56.0,
    this.primaryColor = const Color(0xFF6C63FF),
    this.secondaryColor = const Color(0xFF4ECDC4),
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.borderRadius = 28.0,
    this.isLoading = false,
    this.icon,
    this.style = CoolButtonStyle.gradient,
    this.animationDuration = const Duration(milliseconds: 200),
    this.elevation = 8.0,
  });

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
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
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  BoxDecoration _getDecoration() {
    switch (widget.style) {
      case CoolButtonStyle.gradient:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            colors: [
              widget.primaryColor,
              widget.secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.primaryColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        );

      case CoolButtonStyle.solid:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.primaryColor,
          boxShadow: [
            BoxShadow(
              color: widget.primaryColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        );

      case CoolButtonStyle.outlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.transparent,
          border: Border.all(
            color: widget.primaryColor,
            width: 2,
          ),
        );

      case CoolButtonStyle.glass:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.primaryColor.withValues(alpha: 0.2),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        );
    }
  }

  Color _getTextColor() {
    switch (widget.style) {
      case CoolButtonStyle.outlined:
        return widget.primaryColor;
      case CoolButtonStyle.glass:
        return widget.primaryColor;
      default:
        return widget.textColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: _getDecoration(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                onTap: widget.isLoading ? null : widget.onPressed,
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTapCancel: _onTapCancel,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isLoading) ...[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getTextColor(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ] else if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: _getTextColor(),
                          size: widget.fontSize + 2,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: _getTextColor(),
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
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

/// Different visual styles for the CoolButton
enum CoolButtonStyle {
  /// Gradient background with shadow
  gradient,

  /// Solid color background with shadow
  solid,

  /// Transparent background with colored border
  outlined,

  /// Glass morphism effect
  glass,
}

/// Predefined button configurations for common use cases
class CoolButtonPresets {
  /// Primary action button with gradient
  static CoolButton primary({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFF6C63FF),
      secondaryColor: const Color(0xFF4ECDC4),
      style: CoolButtonStyle.gradient,
    );
  }

  /// Success button with green colors
  static CoolButton success({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFF4CAF50),
      secondaryColor: const Color(0xFF8BC34A),
      style: CoolButtonStyle.gradient,
    );
  }

  /// Warning button with orange colors
  static CoolButton warning({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFFFF9800),
      secondaryColor: const Color(0xFFFFB74D),
      style: CoolButtonStyle.gradient,
    );
  }

  /// Danger button with red colors
  static CoolButton danger({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFFF44336),
      secondaryColor: const Color(0xFFE57373),
      style: CoolButtonStyle.gradient,
    );
  }

  /// Outlined secondary button
  static CoolButton secondary({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFF6C63FF),
      style: CoolButtonStyle.outlined,
    );
  }

  /// Glass morphism button
  static CoolButton glass({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    bool isLoading = false,
    IconData? icon,
  }) {
    return CoolButton(
      text: text,
      onPressed: onPressed,
      width: width,
      isLoading: isLoading,
      icon: icon,
      primaryColor: const Color(0xFF6C63FF),
      style: CoolButtonStyle.glass,
    );
  }
}
