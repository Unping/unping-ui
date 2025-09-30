import 'package:flutter/material.dart';
import 'ui_colors.dart';
import 'ui_spacing.dart';
import 'ui_radius.dart';
import 'ui_text_styles.dart';

/// Main theme configuration for Unping-UI
/// This class provides the complete theme system that integrates with Flutter's ThemeData
class UiTheme {
  // coverage:ignore-start
  // Private constructor to prevent instantiation
  const UiTheme._();
  // coverage:ignore-end

  /// Light theme configuration
  static ThemeData lightTheme({Color? primaryColor, Color? backgroundColor}) {
    final colorScheme = ColorScheme.light(
      primary: primaryColor ?? UiColors.primary500,
      secondary: UiColors.primary600,
      surface: backgroundColor ?? UiColors.neutral50,
      onSurface: UiColors.neutral900,
      error: UiColors.error500,
      onError: UiColors.neutral50,
      outline: UiColors.border,
    );

    return ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,

      // Typography with explicit colors and decorations
      textTheme: TextTheme(
        displayLarge: UiTextStyles.displayLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        displayMedium: UiTextStyles.displayMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        displaySmall: UiTextStyles.displaySmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineLarge: UiTextStyles.headlineLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineMedium: UiTextStyles.headlineMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineSmall: UiTextStyles.headlineSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleLarge: UiTextStyles.titleLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleMedium: UiTextStyles.titleMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleSmall: UiTextStyles.titleSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelLarge: UiTextStyles.labelLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelMedium: UiTextStyles.labelMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelSmall: UiTextStyles.labelSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodyLarge: UiTextStyles.bodyLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodyMedium: UiTextStyles.bodyMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodySmall: UiTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
      ),

      // Custom theme extensions
      extensions: [
        UnpingColorExtension.light,
        UiSpacingExtension.light,
        UiRadiusExtension.light,
        UnpingTextStyleExtension.standard,
      ],

      // Disable default Material styling
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: UiRadius.allMd),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: UiRadius.allMd),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UiColors.neutral50,
        border: OutlineInputBorder(borderRadius: UiRadius.allMd),
        enabledBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        focusedBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        errorBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        focusedErrorBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        contentPadding: UiSpacing.allM,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData darkTheme({Color? primaryColor, Color? backgroundColor}) {
    final colorScheme = ColorScheme.dark(
      primary: primaryColor ?? UiColors.primary400,
      secondary: UiColors.primary500,
      surface: backgroundColor ?? UiColors.neutral900,
      onSurface: UiColors.neutral50,
      error: UiColors.error500,
      onError: UiColors.neutral900,
      outline: UiColors.border,
    );

    return ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,

      // Typography with explicit colors and decorations
      textTheme: TextTheme(
        displayLarge: UiTextStyles.displayLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        displayMedium: UiTextStyles.displayMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        displaySmall: UiTextStyles.displaySmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineLarge: UiTextStyles.headlineLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineMedium: UiTextStyles.headlineMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        headlineSmall: UiTextStyles.headlineSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleLarge: UiTextStyles.titleLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleMedium: UiTextStyles.titleMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        titleSmall: UiTextStyles.titleSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelLarge: UiTextStyles.labelLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelMedium: UiTextStyles.labelMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        labelSmall: UiTextStyles.labelSmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodyLarge: UiTextStyles.bodyLarge.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodyMedium: UiTextStyles.bodyMedium.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
        bodySmall: UiTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurface,
          decoration: TextDecoration.none,
        ),
      ),

      // Custom theme extensions
      extensions: [
        UnpingColorExtension.dark,
        UiSpacingExtension.dark,
        UiRadiusExtension.dark,
        UnpingTextStyleExtension.standard,
      ],

      // Disable default Material styling
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: UiRadius.allMd),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: UiRadius.allMd),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UiColors.neutral800,
        border: OutlineInputBorder(borderRadius: UiRadius.allMd),
        enabledBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        focusedBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        errorBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        focusedErrorBorder: OutlineInputBorder(borderRadius: UiRadius.allMd),
        contentPadding: UiSpacing.allM,
      ),
    );
  }
}

/// Extension on BuildContext to easily access theme colors, spacing, and other design tokens
extension UiThemeContext on BuildContext {
  /// Get the current color extension from the theme
  UnpingColorExtension get UiColors =>
      Theme.of(this).extension<UnpingColorExtension>() ??
      UnpingColorExtension.light;

  /// Get the current spacing extension from the theme
  UiSpacingExtension get UiSpacing =>
      Theme.of(this).extension<UiSpacingExtension>() ??
      UiSpacingExtension.light;

  /// Get the current radius extension from the theme
  UiRadiusExtension get UiRadius =>
      Theme.of(this).extension<UiRadiusExtension>() ?? UiRadiusExtension.light;

  /// Get the current text style extension from the theme
  UnpingTextStyleExtension get UiTextStyles =>
      Theme.of(this).extension<UnpingTextStyleExtension>() ??
      UnpingTextStyleExtension.standard;

  /// Check if the current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if the current theme is light
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}
