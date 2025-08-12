import 'package:flutter/widgets.dart';
import 'component_interface.dart';
import 'component_utils.dart';

/// Default theme implementation for Unping UI components
class DefaultComponentTheme implements ComponentTheme {
  const DefaultComponentTheme({
    ComponentColors? colors,
    ComponentTypography? typography,
    ComponentSpacing? spacing,
    ComponentBorders? borders,
    ComponentAnimations? animations,
  })  : _colors = colors,
        _typography = typography,
        _spacing = spacing,
        _borders = borders,
        _animations = animations;

  final ComponentColors? _colors;
  final ComponentTypography? _typography;
  final ComponentSpacing? _spacing;
  final ComponentBorders? _borders;
  final ComponentAnimations? _animations;

  @override
  ComponentColors get colors =>
      _colors ?? ComponentVariants.createPrimaryColors();

  @override
  ComponentTypography get typography =>
      _typography ?? ComponentVariants.createStandardTypography();

  @override
  ComponentSpacing get spacing =>
      _spacing ?? ComponentVariants.createStandardSpacing();

  @override
  ComponentBorders get borders =>
      _borders ?? ComponentVariants.createStandardBorders();

  @override
  ComponentAnimations get animations =>
      _animations ?? ComponentVariants.createStandardAnimations();

  /// Create a copy with overrides
  DefaultComponentTheme copyWith({
    ComponentColors? colors,
    ComponentTypography? typography,
    ComponentSpacing? spacing,
    ComponentBorders? borders,
    ComponentAnimations? animations,
  }) {
    return DefaultComponentTheme(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      borders: borders ?? this.borders,
      animations: animations ?? this.animations,
    );
  }
}

/// Dark theme implementation
class DarkComponentTheme extends DefaultComponentTheme {
  const DarkComponentTheme({
    ComponentTypography? typography,
    ComponentSpacing? spacing,
    ComponentBorders? borders,
    ComponentAnimations? animations,
  }) : super(
          colors: null, // Will use dark colors
          typography: typography,
          spacing: spacing,
          borders: borders,
          animations: animations,
        );

  @override
  ComponentColors get colors => ComponentVariants.createDarkColors();
}

/// Theme data that can be provided through InheritedWidget
class UnpingUITheme extends InheritedWidget {
  const UnpingUITheme({
    super.key,
    required this.theme,
    required super.child,
  });

  final ComponentTheme theme;

  /// Get the theme from the nearest UnpingUITheme ancestor
  static ComponentTheme of(BuildContext context) {
    final themeWidget = context.dependOnInheritedWidgetOfExactType<UnpingUITheme>();
    return themeWidget?.theme ?? const DefaultComponentTheme();
  }

  /// Get the theme from the nearest UnpingUITheme ancestor (nullable)
  static ComponentTheme? maybeOf(BuildContext context) {
    final themeWidget = context.dependOnInheritedWidgetOfExactType<UnpingUITheme>();
    return themeWidget?.theme;
  }

  @override
  bool updateShouldNotify(UnpingUITheme oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Extension on ComponentTheme for convenience methods
extension ComponentThemeExtension on ComponentTheme {
  /// Get text style for a specific size and weight
  TextStyle getTextStyle({
    ComponentSize size = ComponentSize.md,
    FontWeight? weight,
    Color? color,
    TextDecoration? decoration,
  }) {
    double fontSize;
    switch (size) {
      case ComponentSize.sm:
        fontSize = typography.fontSizeSmall;
        break;
      case ComponentSize.md:
        fontSize = typography.fontSizeMedium;
        break;
      case ComponentSize.lg:
        fontSize = typography.fontSizeLarge;
        break;
    }

    return ComponentUtils.createStandardTextStyle(
      color: color ?? colors.text,
      fontSize: fontSize,
      fontWeight: weight ?? typography.fontWeightNormal,
      fontFamily: typography.fontFamily,
      lineHeight: typography.lineHeight,
      decoration: decoration,
      decorationColor: color ?? colors.text,
    );
  }

  /// Get padding for a specific size
  EdgeInsetsGeometry getPadding(ComponentSize size) {
    return ComponentUtils.getPaddingForSize(size);
  }

  /// Get border radius for a specific size
  double getBorderRadius(ComponentSize size) {
    return ComponentUtils.getBorderRadiusForSize(size);
  }

  /// Get gap for a specific size
  double getGap(ComponentSize size) {
    return ComponentUtils.getGapForSize(size);
  }

  /// Get minimum height for a specific size
  double getMinHeight(ComponentSize size) {
    return ComponentUtils.getMinHeightForSize(size);
  }

  /// Create a standard decoration with theme values
  BoxDecoration createDecoration({
    Color? backgroundColor,
    Color? borderColor,
    ComponentSize size = ComponentSize.md,
    List<BoxShadow>? boxShadow,
  }) {
    return ComponentUtils.createStandardDecoration(
      backgroundColor: backgroundColor ?? colors.background,
      borderColor: borderColor ?? colors.border,
      borderWidth: borders.width,
      borderRadius: getBorderRadius(size),
      boxShadow: boxShadow,
    );
  }

  /// Create a focus ring shadow with theme values
  BoxShadow createFocusRing({Color? color, double? width}) {
    return ComponentUtils.createFocusRingShadow(
      color: color ?? colors.primary.withOpacity(0.5),
      width: width ?? 3.0,
    );
  }

  /// Get color for a specific visual state
  Color getStateColor({
    required ComponentVisualState state,
    Color? normalColor,
    Color? hoverColor,
    Color? focusColor,
    Color? pressedColor,
    Color? disabledColor,
  }) {
    switch (state) {
      case ComponentVisualState.normal:
        return normalColor ?? colors.primary;
      case ComponentVisualState.hovered:
        return hoverColor ?? normalColor?.withOpacity(0.8) ?? colors.primary.withOpacity(0.8);
      case ComponentVisualState.focused:
        return focusColor ?? normalColor ?? colors.primary;
      case ComponentVisualState.pressed:
        return pressedColor ?? normalColor?.withOpacity(0.9) ?? colors.primary.withOpacity(0.9);
      case ComponentVisualState.disabled:
        return disabledColor ?? colors.disabled;
    }
  }

  /// Get animation duration for a specific speed
  Duration getAnimationDuration({bool fast = false, bool slow = false}) {
    if (fast) return animations.durationFast;
    if (slow) return animations.durationSlow;
    return animations.durationNormal;
  }

  /// Check if colors have good contrast
  bool hasGoodContrast(Color foreground, Color background) {
    return ComponentUtils.hasGoodContrast(foreground, background);
  }
}

/// Builder widget that provides access to theme
class UnpingUIThemeBuilder extends StatelessWidget {
  const UnpingUIThemeBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, ComponentTheme theme) builder;

  @override
  Widget build(BuildContext context) {
    final theme = UnpingUITheme.of(context);
    return builder(context, theme);
  }
}

/// Predefined themes for quick setup
class UnpingUIThemes {
  UnpingUIThemes._(); // Private constructor

  /// Standard light theme
  static const ComponentTheme light = DefaultComponentTheme();

  /// Standard dark theme
  static const ComponentTheme dark = DarkComponentTheme();

  /// High contrast light theme
  static ComponentTheme get highContrastLight {
    return DefaultComponentTheme(
      colors: ComponentColors(
        primary: const Color(0xFF000000),
        secondary: const Color(0xFF333333),
        background: const Color(0xFFFFFFFF),
        text: const Color(0xFF000000),
        border: const Color(0xFF000000),
        success: const Color(0xFF006600),
        warning: const Color(0xFF996600),
        error: const Color(0xFF990000),
        disabled: const Color(0xFF666666),
      ),
    );
  }

  /// High contrast dark theme
  static ComponentTheme get highContrastDark {
    return DarkComponentTheme(
      colors: ComponentColors(
        primary: const Color(0xFFFFFFFF),
        secondary: const Color(0xFFCCCCCC),
        background: const Color(0xFF000000),
        text: const Color(0xFFFFFFFF),
        border: const Color(0xFFFFFFFF),
        success: const Color(0xFF00FF00),
        warning: const Color(0xFFFFFF00),
        error: const Color(0xFFFF0000),
        disabled: const Color(0xFF999999),
      ),
    );
  }

  /// Colorful theme for demos/testing
  static ComponentTheme get colorful {
    return DefaultComponentTheme(
      colors: ComponentColors(
        primary: const Color(0xFF6366F1), // Indigo
        secondary: const Color(0xFF8B5CF6), // Purple
        background: const Color(0xFFF8FAFC), // Slate 50
        text: const Color(0xFF1E293B), // Slate 800
        border: const Color(0xFFCBD5E1), // Slate 300
        success: const Color(0xFF10B981), // Emerald
        warning: const Color(0xFFF59E0B), // Amber
        error: const Color(0xFFEF4444), // Red
        disabled: const Color(0xFF94A3B8), // Slate 400
      ),
    );
  }
}