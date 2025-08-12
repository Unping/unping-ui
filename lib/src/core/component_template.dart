import 'package:flutter/widgets.dart';
import 'component_interface.dart';
import 'base_components.dart';
import 'component_utils.dart';
import 'default_theme.dart';

/// Template for creating a new interactive component that follows Unping UI patterns.
/// 
/// This serves as both documentation and a starting point for new components.
/// Copy this file and modify it to create new components that automatically
/// conform to the Unping UI interface standards.
///
/// Required steps to create a new component:
/// 1. Copy this template
/// 2. Rename the class and update the componentType
/// 3. Define your component-specific enums and properties
/// 4. Implement the required abstract methods
/// 5. Add your component to the main library export
/// 6. Create corresponding widgetbook stories
/// 7. Write comprehensive tests
/// 8. Create factory methods in a helper class
///
/// Example usage:
/// ```dart
/// NewComponent(
///   text: 'Hello World',
///   onPressed: () => print('Pressed'),
///   size: ComponentSize.md,
/// )
/// ```
class NewComponentTemplate extends BaseInteractiveComponent
    with
        StateVariantMixin<NewComponentState>,
        ForceStateMixin<NewComponentState>,
        LoadingMixin,
        IconPositionMixin,
        TextContentMixin
    implements SizableComponent, ThemedComponent {
  
  /// Creates a new component following Unping UI patterns.
  ///
  /// The [text] or [icon] must be provided (or both).
  /// 
  /// Example:
  /// ```dart
  /// NewComponentTemplate(
  ///   text: 'Click me',
  ///   onPressed: () => print('Clicked'),
  /// )
  /// ```
  const NewComponentTemplate({
    super.key,
    
    // Content properties
    this.text,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    
    // Interaction properties
    this.onPressed,
    this.onLongPress,
    
    // State properties
    this.state = NewComponentState.normal,
    this.forceState,
    
    // Loading properties
    this.isLoading = false,
    this.loadingWidget,
    
    // Styling properties
    this.size = ComponentSize.md,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    
    // State-specific styling
    this.hoverBackgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    this.hoverTextColor,
    this.focusTextColor,
    this.disabledTextColor,
    
    // Focus and accessibility
    this.focusRingColor,
    this.focusRingWidth = 3.0,
    this.semanticLabel,
    
    // Animation
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    
    // Layout
    this.gap = 8.0,
    this.minHeight,
    this.minWidth,
  }) : assert(text != null || icon != null, 'Either text or icon must be provided');

  // Content properties
  @override
  final String? text;
  
  @override
  final Widget? icon;
  
  @override
  final IconPosition iconPosition;

  // Interaction properties
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  // State properties
  final NewComponentState state;
  
  @override
  final NewComponentState? forceState;

  // Loading properties
  @override
  final bool isLoading;
  
  @override
  final Widget? loadingWidget;

  // Styling properties
  @override
  final ComponentSize size;
  
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  // State-specific styling
  final Color? hoverBackgroundColor;
  final Color? focusBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? hoverTextColor;
  final Color? focusTextColor;
  final Color? disabledTextColor;

  // Focus and accessibility
  @override
  final Color? focusRingColor;
  
  @override
  final double focusRingWidth;
  
  final String? semanticLabel;

  // Animation properties
  @override
  final Duration animationDuration;
  
  @override
  final Curve animationCurve;

  // Layout properties
  final double gap;
  final double? minHeight;
  final double? minWidth;

  // Interface implementations
  @override
  String get componentType => 'NewComponentTemplate';

  @override
  bool get isDisabled => onPressed == null && !isLoading;

  @override
  NewComponentState get currentState => state;

  @override
  List<NewComponentState> get availableStates => NewComponentState.values;

  @override
  Size get actualSize {
    final theme = const DefaultComponentTheme();
    return Size(
      minWidth ?? theme.getMinHeight(size),
      minHeight ?? theme.getMinHeight(size),
    );
  }

  @override
  ComponentTheme get theme => const DefaultComponentTheme();

  @override
  bool get animationsEnabled => true;

  @override
  ValueChanged<bool>? get onFocusChange => null; // Can be customized

  @override
  ValueChanged<bool>? get onHoverChange => null; // Can be customized

  @override
  String? get secondaryText => null; // Not used in this component

  @override
  TextStyle? get textStyle => null; // Will be resolved from theme

  @override
  TextStyle? get secondaryTextStyle => null; // Not used

  @override
  void validateProperties() {
    super.validateProperties();
    validateState();
    validateTextContent();
    
    ComponentValidation.validatePositiveDuration(animationDuration, 'animationDuration');
    ComponentValidation.validateRange(focusRingWidth, 0.0, 10.0, 'focusRingWidth');
    ComponentValidation.validateRange(gap, 0.0, 50.0, 'gap');
    
    if (minHeight != null) {
      ComponentValidation.validateRange(minHeight!, 0.0, 200.0, 'minHeight');
    }
    if (minWidth != null) {
      ComponentValidation.validateRange(minWidth!, 0.0, 500.0, 'minWidth');
    }
  }

  @override
  Map<String, dynamic> getStateStyle(NewComponentState state) {
    final theme = this.theme;
    
    switch (state) {
      case NewComponentState.normal:
        return {
          'backgroundColor': backgroundColor ?? theme.colors.primary,
          'textColor': textColor ?? theme.colors.text,
          'borderColor': borderColor ?? theme.colors.border,
        };
      case NewComponentState.hovered:
        return {
          'backgroundColor': hoverBackgroundColor ?? backgroundColor?.withOpacity(0.8) ?? theme.colors.primary.withOpacity(0.8),
          'textColor': hoverTextColor ?? textColor ?? theme.colors.text,
          'borderColor': borderColor ?? theme.colors.border,
        };
      case NewComponentState.focused:
        return {
          'backgroundColor': focusBackgroundColor ?? backgroundColor ?? theme.colors.primary,
          'textColor': focusTextColor ?? textColor ?? theme.colors.text,
          'borderColor': borderColor ?? theme.colors.border,
        };
      case NewComponentState.disabled:
        return {
          'backgroundColor': disabledBackgroundColor ?? backgroundColor?.withOpacity(0.4) ?? theme.colors.disabled,
          'textColor': disabledTextColor ?? textColor?.withOpacity(0.4) ?? theme.colors.disabled,
          'borderColor': borderColor?.withOpacity(0.4) ?? theme.colors.border.withOpacity(0.4),
        };
    }
  }

  @override
  ComponentTheme resolveTheme(BuildContext context) {
    return UnpingUITheme.maybeOf(context) ?? theme;
  }

  @override
  Widget buildDefaultLoadingIndicator() {
    final resolvedTheme = theme;
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _LoadingIndicatorPainter(
          color: textColor ?? resolvedTheme.colors.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    validateProperties();
    
    final resolvedTheme = resolveTheme(context);
    final currentStateStyle = getStateStyle(effectiveState);
    
    return UnpingUIThemeBuilder(
      builder: (context, theme) => _NewComponentTemplateWidget(
        component: this,
        theme: theme,
        stateStyle: currentStateStyle,
      ),
    );
  }

  @override
  State<NewComponentTemplate> createState() => _NewComponentTemplateState();
}

/// State class for the component
class _NewComponentTemplateState extends State<NewComponentTemplate>
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

  NewComponentState get _effectiveState {
    if (widget.hasForceState) return widget.effectiveState;
    if (widget.isDisabled) return NewComponentState.disabled;
    if (_isFocused) return NewComponentState.focused;
    if (_isHovered) return NewComponentState.hovered;
    return NewComponentState.normal;
  }

  void _handleTap() {
    if (widget.isDisabled || widget.isLoading) return;
    widget.onPressed?.call();
  }

  void _handleLongPress() {
    if (widget.isDisabled || widget.isLoading) return;
    widget.onLongPress?.call();
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
        widget.buildTextWidget(text: widget.text ?? ''),
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
        minHeight: widget.minHeight ?? theme.getMinHeight(widget.size),
        minWidth: widget.minWidth ?? theme.getMinHeight(widget.size),
      ),
      decoration: theme.createDecoration(
        backgroundColor: stateStyle['backgroundColor'] as Color,
        borderColor: stateStyle['borderColor'] as Color,
        size: widget.size,
        boxShadow: _isFocused && widget.focusRingColor != null
            ? [theme.createFocusRing(color: widget.focusRingColor)]
            : null,
      ),
      padding: widget.padding ?? theme.getPadding(widget.size),
      child: content,
    );

    if (!widget.isDisabled) {
      child = Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
          widget.onFocusChange?.call(focused);
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            widget.onHoverChange?.call(true);
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            widget.onHoverChange?.call(false);
          },
          child: GestureDetector(
            onTap: _handleTap,
            onLongPress: _handleLongPress,
            child: child,
          ),
        ),
      );
    }

    if (widget.semanticLabel != null) {
      child = AccessibilityUtils.wrapWithSemantics(
        label: widget.semanticLabel!,
        enabled: !widget.isDisabled,
        onTap: widget.isDisabled ? null : _handleTap,
        child: child,
      );
    }

    return child;
  }
}

/// Widget implementation (if needed for complex layout)
class _NewComponentTemplateWidget extends StatelessWidget {
  const _NewComponentTemplateWidget({
    required this.component,
    required this.theme,
    required this.stateStyle,
  });

  final NewComponentTemplate component;
  final ComponentTheme theme;
  final Map<String, dynamic> stateStyle;

  @override
  Widget build(BuildContext context) {
    // Alternative implementation approach if StatefulWidget becomes too complex
    return Container(
      child: Text('Alternative widget implementation'),
    );
  }
}

/// Custom painter for loading indicator
class _LoadingIndicatorPainter extends CustomPainter {
  const _LoadingIndicatorPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Implement custom loading indicator painting
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Component-specific state enum
enum NewComponentState {
  normal,
  hovered,
  focused,
  disabled,
}

/// Factory class for creating component variants
class NewComponents {
  NewComponents._(); // Private constructor

  /// Create a primary variant
  static NewComponentTemplate primary({
    String? text,
    Widget? icon,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    return NewComponentTemplate(
      text: text,
      icon: icon,
      onPressed: onPressed,
      size: size,
      backgroundColor: const Color(0xFF3B4554),
      textColor: const Color(0xFFFFFFFF),
    );
  }

  /// Create a secondary variant
  static NewComponentTemplate secondary({
    String? text,
    Widget? icon,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    return NewComponentTemplate(
      text: text,
      icon: icon,
      onPressed: onPressed,
      size: size,
      backgroundColor: const Color(0xFFFFFFFF),
      textColor: const Color(0xFF2A313C),
      borderColor: const Color(0xFFD0D5DD),
    );
  }
}