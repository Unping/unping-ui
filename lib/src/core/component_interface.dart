import 'package:flutter/widgets.dart';

/// Base interface that all Unping UI components must implement.
/// This ensures consistency across the component library.
abstract class UnpingUIComponent {
  /// Unique key for the component
  Key? get key;

  /// Whether the component is interactive (can respond to user input)
  bool get isInteractive;

  /// Whether the component supports accessibility features
  bool get supportsAccessibility;

  /// Component type identifier for debugging and testing
  String get componentType;

  /// Validate component properties to ensure consistency
  void validateProperties();

  /// Get the widget representation of this component
  Widget build(BuildContext context);
}

/// Base interface for components that can be disabled
abstract class DisableableComponent {
  /// Whether the component is disabled
  bool get isDisabled;

  /// Opacity to apply when disabled
  double get disabledOpacity;
}

/// Base interface for components that support theming
abstract class ThemedComponent {
  /// Get the current component theme
  ComponentTheme get theme;

  /// Apply theme-based styling
  ComponentTheme resolveTheme(BuildContext context);
}

/// Base interface for components that support animation
abstract class AnimatedComponent {
  /// Duration of animations
  Duration get animationDuration;

  /// Animation curve to use
  Curve get animationCurve;

  /// Whether animations are enabled
  bool get animationsEnabled;
}

/// Base interface for components that support focus
abstract class FocusableComponent {
  /// Whether the component can receive focus
  bool get canFocus;

  /// Focus ring color
  Color? get focusRingColor;

  /// Focus ring width
  double get focusRingWidth;

  /// Callback when focus changes
  ValueChanged<bool>? get onFocusChange;
}

/// Base interface for components that support hover
abstract class HoverableComponent {
  /// Whether the component responds to hover
  bool get canHover;

  /// Callback when hover state changes
  ValueChanged<bool>? get onHoverChange;
}

/// Base interface for components with size variants
abstract class SizableComponent {
  /// Size variant of the component
  ComponentSize get size;

  /// Get actual dimensions based on size variant
  Size get actualSize;
}

/// Standard component sizes used across the library
enum ComponentSize {
  /// Small size variant
  sm,

  /// Medium size variant (default)
  md,

  /// Large size variant
  lg,
}

/// Standard visual states for interactive components
enum ComponentVisualState {
  /// Normal state - default appearance
  normal,

  /// Hovered state - when mouse is over the component
  hovered,

  /// Focused state - when component has keyboard focus
  focused,

  /// Pressed/Active state - when component is being interacted with
  pressed,

  /// Disabled state - when component is not interactive
  disabled,
}

/// Base theme configuration for components
abstract class ComponentTheme {
  /// Primary colors
  ComponentColors get colors;

  /// Typography settings
  ComponentTypography get typography;

  /// Spacing values
  ComponentSpacing get spacing;

  /// Border settings
  ComponentBorders get borders;

  /// Animation settings
  ComponentAnimations get animations;
}

/// Color scheme for components
class ComponentColors {
  /// Primary color
  final Color primary;

  /// Secondary color
  final Color secondary;

  /// Background color
  final Color background;

  /// Text color
  final Color text;

  /// Border color
  final Color border;

  /// Success color
  final Color success;

  /// Warning color
  final Color warning;

  /// Error color
  final Color error;

  /// Disabled color
  final Color disabled;

  const ComponentColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.border,
    required this.success,
    required this.warning,
    required this.error,
    required this.disabled,
  });
}

/// Typography settings for components
class ComponentTypography {
  /// Small font size
  final double fontSizeSmall;

  /// Medium font size (default)
  final double fontSizeMedium;

  /// Large font size
  final double fontSizeLarge;

  /// Normal font weight
  final FontWeight fontWeightNormal;

  /// Medium font weight
  final FontWeight fontWeightMedium;

  /// Bold font weight
  final FontWeight fontWeightBold;

  /// Default font family
  final String fontFamily;

  /// Line height multiplier
  final double lineHeight;

  const ComponentTypography({
    required this.fontSizeSmall,
    required this.fontSizeMedium,
    required this.fontSizeLarge,
    required this.fontWeightNormal,
    required this.fontWeightMedium,
    required this.fontWeightBold,
    required this.fontFamily,
    required this.lineHeight,
  });
}

/// Spacing values for components
class ComponentSpacing {
  /// Extra small spacing
  final double xs;

  /// Small spacing
  final double sm;

  /// Medium spacing (default)
  final double md;

  /// Large spacing
  final double lg;

  /// Extra large spacing
  final double xl;

  const ComponentSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
}

/// Border settings for components
class ComponentBorders {
  /// Default border width
  final double width;

  /// Small border radius
  final double radiusSmall;

  /// Medium border radius (default)
  final double radiusMedium;

  /// Large border radius
  final double radiusLarge;

  /// Circle border radius (for circular components)
  final double radiusCircle;

  const ComponentBorders({
    required this.width,
    required this.radiusSmall,
    required this.radiusMedium,
    required this.radiusLarge,
    required this.radiusCircle,
  });
}

/// Animation settings for components
class ComponentAnimations {
  /// Fast animation duration
  final Duration durationFast;

  /// Normal animation duration
  final Duration durationNormal;

  /// Slow animation duration
  final Duration durationSlow;

  /// Default animation curve
  final Curve curve;

  /// Ease in curve
  final Curve curveEaseIn;

  /// Ease out curve
  final Curve curveEaseOut;

  const ComponentAnimations({
    required this.durationFast,
    required this.durationNormal,
    required this.durationSlow,
    required this.curve,
    required this.curveEaseIn,
    required this.curveEaseOut,
  });
}