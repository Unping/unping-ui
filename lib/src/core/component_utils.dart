import 'package:flutter/widgets.dart';
import 'component_interface.dart';

/// Utility class for standard component configurations
class ComponentUtils {
  ComponentUtils._(); // Private constructor to prevent instantiation

  /// Get size-based font size
  static double getFontSizeForSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.sm:
        return 12.0;
      case ComponentSize.md:
        return 14.0;
      case ComponentSize.lg:
        return 16.0;
    }
  }

  /// Get size-based padding
  static EdgeInsetsGeometry getPaddingForSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.sm:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case ComponentSize.md:
        return const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
      case ComponentSize.lg:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
    }
  }

  /// Get size-based border radius
  static double getBorderRadiusForSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.sm:
        return 4.0;
      case ComponentSize.md:
        return 6.0;
      case ComponentSize.lg:
        return 8.0;
    }
  }

  /// Get size-based gap between elements
  static double getGapForSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.sm:
        return 4.0;
      case ComponentSize.md:
        return 6.0;
      case ComponentSize.lg:
        return 8.0;
    }
  }

  /// Get size-based minimum height
  static double getMinHeightForSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.sm:
        return 28.0;
      case ComponentSize.md:
        return 36.0;
      case ComponentSize.lg:
        return 44.0;
    }
  }

  /// Create a standard BoxDecoration for components
  static BoxDecoration createStandardDecoration({
    required Color backgroundColor,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 6.0,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
      boxShadow: boxShadow,
    );
  }

  /// Create focus ring shadow
  static BoxShadow createFocusRingShadow({
    required Color color,
    double width = 3.0,
  }) {
    return BoxShadow(
      color: color,
      offset: Offset.zero,
      blurRadius: 0,
      spreadRadius: width,
    );
  }

  /// Create a standard text style
  static TextStyle createStandardTextStyle({
    required Color color,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = 'Inter',
    double lineHeight = 1.4,
    TextDecoration? decoration,
    Color? decorationColor,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      height: lineHeight,
      decoration: decoration,
      decorationColor: decorationColor,
    );
  }

  /// Validate color contrast (basic implementation)
  static bool hasGoodContrast(Color foreground, Color background) {
    // Simplified contrast check - in a real implementation,
    // you'd use WCAG contrast ratio calculations
    final fgLuminance = foreground.computeLuminance();
    final bgLuminance = background.computeLuminance();
    final ratio = (fgLuminance + 0.05) / (bgLuminance + 0.05);
    return ratio >= 4.5; // WCAG AA standard
  }
}

/// Factory class for creating common component variants
class ComponentVariants {
  ComponentVariants._(); // Private constructor

  /// Create a primary color scheme
  static ComponentColors createPrimaryColors() {
    return const ComponentColors(
      primary: Color(0xFF3B4554),
      secondary: Color(0xFF989DB3),
      background: Color(0xFFFFFFFF),
      text: Color(0xFF2A313C),
      border: Color(0xFFD0D5DD),
      success: Color(0xFF17B26A),
      warning: Color(0xFFF79009),
      error: Color(0xFFD92D20),
      disabled: Color(0xFF647690),
    );
  }

  /// Create a dark color scheme
  static ComponentColors createDarkColors() {
    return const ComponentColors(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFABB5C4),
      background: Color(0xFF2A313C),
      text: Color(0xFFFFFFFF),
      border: Color(0xFF989DB3),
      success: Color(0xFF17B26A),
      warning: Color(0xFFF79009),
      error: Color(0xFFD92D20),
      disabled: Color(0xFF647690),
    );
  }

  /// Create standard typography
  static ComponentTypography createStandardTypography() {
    return const ComponentTypography(
      fontSizeSmall: 12.0,
      fontSizeMedium: 14.0,
      fontSizeLarge: 16.0,
      fontWeightNormal: FontWeight.w400,
      fontWeightMedium: FontWeight.w500,
      fontWeightBold: FontWeight.w700,
      fontFamily: 'Inter',
      lineHeight: 1.4,
    );
  }

  /// Create standard spacing
  static ComponentSpacing createStandardSpacing() {
    return const ComponentSpacing(
      xs: 2.0,
      sm: 4.0,
      md: 8.0,
      lg: 16.0,
      xl: 24.0,
    );
  }

  /// Create standard borders
  static ComponentBorders createStandardBorders() {
    return const ComponentBorders(
      width: 1.0,
      radiusSmall: 4.0,
      radiusMedium: 6.0,
      radiusLarge: 8.0,
      radiusCircle: 1000.0, // Large enough to ensure circular shape
    );
  }

  /// Create standard animations
  static ComponentAnimations createStandardAnimations() {
    return const ComponentAnimations(
      durationFast: Duration(milliseconds: 100),
      durationNormal: Duration(milliseconds: 200),
      durationSlow: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      curveEaseIn: Curves.easeIn,
      curveEaseOut: Curves.easeOut,
    );
  }
}

/// Validation utilities for component properties
class ComponentValidation {
  ComponentValidation._(); // Private constructor

  /// Validate that a value is within a range
  static void validateRange<T extends num>(
    T value,
    T min,
    T max,
    String propertyName,
  ) {
    assert(
      value >= min && value <= max,
      '$propertyName must be between $min and $max, got $value',
    );
  }

  /// Validate that a duration is positive
  static void validatePositiveDuration(Duration duration, String propertyName) {
    assert(
      duration.inMicroseconds > 0,
      '$propertyName must be positive, got $duration',
    );
  }

  /// Validate that a color has sufficient opacity
  static void validateColorOpacity(Color color, String propertyName) {
    assert(
      color.opacity > 0.0,
      '$propertyName must have opacity > 0, got ${color.opacity}',
    );
  }

  /// Validate that required content is provided
  static void validateRequiredContent(
    List<Widget?> content,
    String componentName,
  ) {
    final nonNullContent = content.where((widget) => widget != null).toList();
    assert(
      nonNullContent.isNotEmpty,
      '$componentName must have at least one piece of content',
    );
  }

  /// Validate enum value
  static void validateEnumValue<T extends Enum>(
    T value,
    List<T> allowedValues,
    String propertyName,
  ) {
    assert(
      allowedValues.contains(value),
      '$propertyName must be one of $allowedValues, got $value',
    );
  }
}

/// Helper class for accessibility features
class AccessibilityUtils {
  AccessibilityUtils._(); // Private constructor

  /// Create semantic properties for interactive components
  static Map<String, dynamic> createInteractiveSemantics({
    required String label,
    String? hint,
    bool? enabled,
    bool? checked,
    bool? selected,
    VoidCallback? onTap,
  }) {
    return {
      'label': label,
      if (hint != null) 'hint': hint,
      if (enabled != null) 'enabled': enabled,
      if (checked != null) 'checked': checked,
      if (selected != null) 'selected': selected,
      if (onTap != null) 'onTap': onTap,
    };
  }

  /// Wrap widget with proper semantics
  static Widget wrapWithSemantics({
    required Widget child,
    required String label,
    String? hint,
    bool? enabled,
    bool? checked,
    bool? selected,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      enabled: enabled ?? true,
      checked: checked,
      selected: selected,
      onTap: onTap,
      child: child,
    );
  }

  /// Check if screen reader accessibility is needed
  static bool needsScreenReaderSupport(BuildContext context) {
    // In a real implementation, you'd check MediaQuery.accessibleNavigationOf
    // or use platform-specific accessibility APIs
    return true; // Assume always needed for now
  }
}

/// Helper for creating standard component documentation
class ComponentDocumentation {
  ComponentDocumentation._(); // Private constructor

  /// Template for component class documentation
  static String createClassDocTemplate({
    required String componentName,
    required String description,
    List<String>? features,
    List<String>? examples,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('/// $description');
    buffer.writeln('///');
    
    if (features != null && features.isNotEmpty) {
      buffer.writeln('/// Features:');
      for (final feature in features) {
        buffer.writeln('/// * $feature');
      }
      buffer.writeln('///');
    }

    if (examples != null && examples.isNotEmpty) {
      buffer.writeln('/// Examples:');
      for (final example in examples) {
        buffer.writeln('/// ```dart');
        buffer.writeln('/// $example');
        buffer.writeln('/// ```');
      }
      buffer.writeln('///');
    }

    buffer.writeln('/// See also:');
    buffer.writeln('/// * [UnpingUIComponent] for the base component interface');
    buffer.writeln('/// * [$componentName] for implementation details');

    return buffer.toString();
  }

  /// Template for property documentation
  static String createPropertyDocTemplate({
    required String description,
    String? defaultValue,
    List<String>? validValues,
    String? seeAlso,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('/// $description');
    
    if (defaultValue != null) {
      buffer.writeln('///');
      buffer.writeln('/// Defaults to `$defaultValue`.');
    }

    if (validValues != null && validValues.isNotEmpty) {
      buffer.writeln('///');
      buffer.writeln('/// Valid values: ${validValues.join(', ')}');
    }

    if (seeAlso != null) {
      buffer.writeln('///');
      buffer.writeln('/// See also: $seeAlso');
    }

    return buffer.toString();
  }
}