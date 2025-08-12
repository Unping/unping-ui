/// Example of how to update existing components to implement the new interface system.
/// 
/// This file demonstrates how BaseButton could be updated to implement the 
/// UnpingUIComponent interface while maintaining backward compatibility.
/// 
/// This is provided as an example and reference - the actual components can
/// be updated incrementally as needed.

import 'package:flutter/widgets.dart';
import '../core/core.dart';

/// Example of how BaseButton could implement the interface system
/// while maintaining its existing API and functionality.
class ExampleInterfaceButton extends BaseInteractiveComponent
    with
        StateVariantMixin<ButtonVisualState>,
        ForceStateMixin<ButtonVisualState>,
        LoadingMixin,
        IconPositionMixin,
        TextContentMixin
    implements SizableComponent, ThemedComponent {

  const ExampleInterfaceButton({
    super.key,
    
    // Existing BaseButton API - maintained for compatibility
    this.text,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    this.onPressed,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    required this.textColor,
    this.hoverTextColor,
    this.focusTextColor,
    this.disabledTextColor,
    this.borderColor,
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
    this.minHeight = 36.0,
    this.minWidth = 36.0,
    this.underlineText = false,
    this.isLoading = false,
    this.loadingWidget,
    this.forceState,
    
    // New interface properties
    this.size = ComponentSize.md,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  })  : padding = padding ??
            (text != null
                ? const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)
                : const EdgeInsets.all(8.0)),
        assert(text != null || icon != null,
            'Either text or icon must be provided');

  // Existing BaseButton properties
  @override
  final String? text;
  
  @override
  final Widget? icon;
  
  @override
  final IconPosition iconPosition;
  
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? focusBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color textColor;
  final Color? hoverTextColor;
  final Color? focusTextColor;
  final Color? disabledTextColor;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final Color? focusBorderColor;
  final Color? disabledBorderColor;
  final double borderWidth;
  
  @override
  final Color? focusRingColor;
  
  @override
  final double focusRingWidth;
  
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double gap;
  final double? minHeight;
  final double? minWidth;
  final bool underlineText;
  
  @override
  final bool isLoading;
  
  @override
  final Widget? loadingWidget;
  
  @override
  final ButtonVisualState? forceState;

  // New interface properties
  @override
  final ComponentSize size;
  
  @override
  final Duration animationDuration;
  
  @override
  final Curve animationCurve;

  // Interface implementations
  @override
  String get componentType => 'ExampleInterfaceButton';

  @override
  bool get isDisabled => onPressed == null;

  @override
  ButtonVisualState get currentState => ButtonVisualState.normal;

  @override
  List<ButtonVisualState> get availableStates => ButtonVisualState.values;

  @override
  Size get actualSize => Size(minWidth ?? 36.0, minHeight ?? 36.0);

  @override
  ComponentTheme get theme => const DefaultComponentTheme();

  @override
  bool get animationsEnabled => true;

  @override
  ValueChanged<bool>? get onFocusChange => null;

  @override
  ValueChanged<bool>? get onHoverChange => null;

  @override
  String? get secondaryText => null;

  @override
  TextStyle? get textStyle => ComponentUtils.createStandardTextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'Outfit',
        decoration: underlineText ? TextDecoration.underline : null,
      );

  @override
  TextStyle? get secondaryTextStyle => null;

  @override
  void validateProperties() {
    super.validateProperties();
    validateState();
    validateTextContent();
    
    ComponentValidation.validatePositiveDuration(animationDuration, 'animationDuration');
    ComponentValidation.validateRange(focusRingWidth, 0.0, 10.0, 'focusRingWidth');
    ComponentValidation.validateRange(fontSize, 8.0, 32.0, 'fontSize');
    ComponentValidation.validateRange(borderWidth, 0.0, 10.0, 'borderWidth');
    ComponentValidation.validateRange(gap, 0.0, 50.0, 'gap');
    
    if (minHeight != null) {
      ComponentValidation.validateRange(minHeight!, 0.0, 200.0, 'minHeight');
    }
    if (minWidth != null) {
      ComponentValidation.validateRange(minWidth!, 0.0, 500.0, 'minWidth');
    }
  }

  @override
  Map<String, dynamic> getStateStyle(ButtonVisualState state) {
    switch (state) {
      case ButtonVisualState.normal:
        return {
          'backgroundColor': backgroundColor,
          'textColor': textColor,
          'borderColor': borderColor,
        };
      case ButtonVisualState.hovered:
        return {
          'backgroundColor': hoverBackgroundColor ?? backgroundColor,
          'textColor': hoverTextColor ?? textColor,
          'borderColor': hoverBorderColor ?? borderColor,
        };
      case ButtonVisualState.focused:
        return {
          'backgroundColor': focusBackgroundColor ?? backgroundColor,
          'textColor': focusTextColor ?? textColor,
          'borderColor': focusBorderColor ?? borderColor,
        };
      case ButtonVisualState.disabled:
        return {
          'backgroundColor': disabledBackgroundColor ?? backgroundColor,
          'textColor': disabledTextColor ?? textColor,
          'borderColor': disabledBorderColor ?? borderColor,
        };
      case ButtonVisualState.pressed:
        return {
          'backgroundColor': backgroundColor,
          'textColor': textColor,
          'borderColor': borderColor,
        };
    }
  }

  @override
  ComponentTheme resolveTheme(BuildContext context) {
    return UnpingUITheme.maybeOf(context) ?? theme;
  }

  @override
  Widget buildDefaultLoadingIndicator() {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _LoadingIndicatorPainter(color: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    validateProperties();
    
    final resolvedTheme = resolveTheme(context);
    
    // Use existing BaseButton build logic but with interface-driven enhancements
    return _ExampleInterfaceButtonWidget(
      button: this,
      theme: resolvedTheme,
    );
  }

  @override
  State<ExampleInterfaceButton> createState() => _ExampleInterfaceButtonState();
}

/// State class that leverages the interface system
class _ExampleInterfaceButtonState extends State<ExampleInterfaceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ButtonVisualState get _effectiveState {
    if (widget.hasForceState) return widget.effectiveState;
    if (widget.isDisabled) return ButtonVisualState.disabled;
    if (_isFocused) return ButtonVisualState.focused;
    if (_isHovered) return ButtonVisualState.hovered;
    return ButtonVisualState.normal;
  }

  void _handleTap() {
    if (widget.isDisabled || widget.isLoading) return;
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.resolveTheme(context);
    final stateStyle = widget.getStateStyle(_effectiveState);
    
    Widget content;
    
    if (widget.isLoading) {
      content = widget.getLoadingWidget();
    } else {
      final children = widget.buildContentWithIcon(
        widget.hasText ? widget.buildTextWidget(text: widget.text!) : Container(),
        gap: widget.gap,
      );
      
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    Widget child = Container(
      constraints: BoxConstraints(
        minHeight: widget.actualSize.height,
        minWidth: widget.actualSize.width,
      ),
      decoration: ComponentUtils.createStandardDecoration(
        backgroundColor: stateStyle['backgroundColor'] as Color? ?? theme.colors.primary,
        borderColor: stateStyle['borderColor'] as Color? ?? theme.colors.border,
        borderWidth: widget.borderWidth,
        borderRadius: widget.borderRadius,
        boxShadow: _isFocused && widget.focusRingColor != null
            ? [ComponentUtils.createFocusRingShadow(
                color: widget.focusRingColor!,
                width: widget.focusRingWidth,
              )]
            : null,
      ),
      padding: widget.padding,
      child: content,
    );

    if (!widget.isDisabled) {
      child = Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _handleTap,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}

/// Custom painter for loading indicator
class _LoadingIndicatorPainter extends CustomPainter {
  const _LoadingIndicatorPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 2.0) / 2;

    const startAngle = -1.5708; // -90 degrees
    const sweepAngle = 2 * 3.14159 * 0.75; // 270 degrees

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Widget implementation that uses the interface system
class _ExampleInterfaceButtonWidget extends StatelessWidget {
  const _ExampleInterfaceButtonWidget({
    required this.button,
    required this.theme,
  });

  final ExampleInterfaceButton button;
  final ComponentTheme theme;

  @override
  Widget build(BuildContext context) {
    // Implementation would use the interface-provided methods
    // and theme system for consistent styling
    return Container(
      child: Text('Interface-compliant button implementation'),
    );
  }
}

/// Button visual states that map to ComponentVisualState
enum ButtonVisualState {
  normal,
  hovered,
  focused,
  pressed,
  disabled,
}

/// Factory methods using the interface system
class ExampleInterfaceButtons {
  ExampleInterfaceButtons._();

  /// Create a ghost button using interface patterns
  static ExampleInterfaceButton ghost({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    final theme = const DefaultComponentTheme();
    
    return ExampleInterfaceButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      size: size,
      textColor: theme.colors.text,
      focusRingColor: theme.colors.primary.withOpacity(0.5),
    );
  }

  /// Create a filled button using interface patterns
  static ExampleInterfaceButton filled({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    final theme = const DefaultComponentTheme();
    
    return ExampleInterfaceButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      size: size,
      backgroundColor: theme.colors.primary,
      textColor: theme.colors.background,
      focusRingColor: theme.colors.primary.withOpacity(0.5),
    );
  }

  /// Create an outline button using interface patterns
  static ExampleInterfaceButton outline({
    String? text,
    Widget? icon,
    IconPosition iconPosition = IconPosition.trailing,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    final theme = const DefaultComponentTheme();
    
    return ExampleInterfaceButton(
      text: text,
      icon: icon,
      iconPosition: iconPosition,
      onPressed: onPressed,
      size: size,
      textColor: theme.colors.text,
      borderColor: theme.colors.border,
      focusRingColor: theme.colors.primary.withOpacity(0.5),
    );
  }
}