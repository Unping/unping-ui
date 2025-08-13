import 'package:flutter/material.dart';
import 'unping_colors.dart';
import 'unping_spacing.dart';
import 'unping_radius.dart';
import 'unping_text_styles.dart';

/// Main theme configuration for Unping-UI
/// This class provides the complete theme system that integrates with Flutter's ThemeData
class UnpingTheme {
  // Private constructor to prevent instantiation
  const UnpingTheme._();

  /// Light theme configuration
  static ThemeData lightTheme({
    Color? primaryColor,
    Color? backgroundColor,
  }) {
    return ThemeData(
      useMaterial3: false,

      // Color scheme integration
      colorScheme: ColorScheme.light(
        primary: primaryColor ?? UnpingColors.primary500,
        secondary: UnpingColors.primary600,
        surface: backgroundColor ?? UnpingColors.neutral50,
        onSurface: UnpingColors.neutral900,
        error: UnpingColors.error500,
        onError: UnpingColors.neutral50,
        outline: UnpingColors.border,
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: UnpingTextStyles.displayLarge,
        displayMedium: UnpingTextStyles.displayMedium,
        displaySmall: UnpingTextStyles.displaySmall,
        headlineLarge: UnpingTextStyles.headlineLarge,
        headlineMedium: UnpingTextStyles.headlineMedium,
        headlineSmall: UnpingTextStyles.headlineSmall,
        titleLarge: UnpingTextStyles.titleLarge,
        titleMedium: UnpingTextStyles.titleMedium,
        titleSmall: UnpingTextStyles.titleSmall,
        labelLarge: UnpingTextStyles.labelLarge,
        labelMedium: UnpingTextStyles.labelMedium,
        labelSmall: UnpingTextStyles.labelSmall,
        bodyLarge: UnpingTextStyles.bodyLarge,
        bodyMedium: UnpingTextStyles.bodyMedium,
        bodySmall: UnpingTextStyles.bodySmall,
      ),

      // Custom theme extensions
      extensions: [
        UnpingColorExtension.light,
        UnpingSpacingExtension.light,
        UnpingRadiusExtension.light,
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
          shape: RoundedRectangleBorder(
            borderRadius: UnpingRadius.allMd,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: UnpingRadius.allMd,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UnpingColors.neutral50,
        border: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        contentPadding: UnpingSpacing.allM,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData darkTheme({
    Color? primaryColor,
    Color? backgroundColor,
  }) {
    return ThemeData(
      useMaterial3: false,

      // Color scheme integration
      colorScheme: ColorScheme.dark(
        primary: primaryColor ?? UnpingColors.primary400,
        secondary: UnpingColors.primary500,
        surface: backgroundColor ?? UnpingColors.neutral900,
        onSurface: UnpingColors.neutral50,
        error: UnpingColors.error500,
        onError: UnpingColors.neutral900,
        outline: UnpingColors.border,
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: UnpingTextStyles.displayLarge,
        displayMedium: UnpingTextStyles.displayMedium,
        displaySmall: UnpingTextStyles.displaySmall,
        headlineLarge: UnpingTextStyles.headlineLarge,
        headlineMedium: UnpingTextStyles.headlineMedium,
        headlineSmall: UnpingTextStyles.headlineSmall,
        titleLarge: UnpingTextStyles.titleLarge,
        titleMedium: UnpingTextStyles.titleMedium,
        titleSmall: UnpingTextStyles.titleSmall,
        labelLarge: UnpingTextStyles.labelLarge,
        labelMedium: UnpingTextStyles.labelMedium,
        labelSmall: UnpingTextStyles.labelSmall,
        bodyLarge: UnpingTextStyles.bodyLarge,
        bodyMedium: UnpingTextStyles.bodyMedium,
        bodySmall: UnpingTextStyles.bodySmall,
      ),

      // Custom theme extensions
      extensions: [
        UnpingColorExtension.dark,
        UnpingSpacingExtension.dark,
        UnpingRadiusExtension.dark,
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
          shape: RoundedRectangleBorder(
            borderRadius: UnpingRadius.allMd,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: UnpingRadius.allMd,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UnpingColors.neutral800,
        border: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: UnpingRadius.allMd,
        ),
        contentPadding: UnpingSpacing.allM,
      ),
    );
  }
}

/// Extension on BuildContext to easily access theme colors, spacing, and other design tokens
extension UnpingThemeContext on BuildContext {
  /// Get the current color extension from the theme
  UnpingColorExtension get unpingColors =>
      Theme.of(this).extension<UnpingColorExtension>() ??
      UnpingColorExtension.light;

  /// Get the current spacing extension from the theme
  UnpingSpacingExtension get unpingSpacing =>
      Theme.of(this).extension<UnpingSpacingExtension>() ??
      UnpingSpacingExtension.light;

  /// Get the current radius extension from the theme
  UnpingRadiusExtension get unpingRadius =>
      Theme.of(this).extension<UnpingRadiusExtension>() ??
      UnpingRadiusExtension.light;

  /// Get the current text style extension from the theme
  UnpingTextStyleExtension get unpingTextStyles =>
      Theme.of(this).extension<UnpingTextStyleExtension>() ??
      UnpingTextStyleExtension.standard;

  /// Check if the current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if the current theme is light
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}
