import 'package:flutter/material.dart';

/// Unping-UI color palette
/// These colors form the foundation of the Unping design system
/// Based on the Figma design system with consistent scales
class UiColors {
  // Primary brand colors (using sophisticated blues)
  static const Color primary25 = Color(0xFFFAFCFF);
  static const Color primary50 = Color(0xFFF0F9FF);
  static const Color primary100 = Color(0xFFE0F2FE);
  static const Color primary200 = Color(0xFFBAE6FD);
  static const Color primary300 = Color(0xFF7DD3FC);
  static const Color primary400 = Color(0xFF38BDF8);
  static const Color primary500 = Color(0xFF0EA5E9);
  static const Color primary600 = Color(0xFF0284C7);
  static const Color primary700 = Color(0xFF0369A1);
  static const Color primary800 = Color(0xFF075985);
  static const Color primary900 = Color(0xFF0C4A6E);
  static const Color primary950 = Color(0xFF082F49);

  // Neutral colors (refined gray scale matching Figma)
  static const Color neutral25 = Color(0xFFFCFCFD);
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF2F4F7);
  static const Color neutral200 = Color(0xFFE4E7EC);
  static const Color neutral300 = Color(0xFFD0D5DD);
  static const Color neutral400 = Color(0xFF98A2B3);
  static const Color neutral500 = Color(0xFF667085);
  static const Color neutral600 = Color(0xFF475467);
  static const Color neutral700 = Color(0xFF344054);
  static const Color neutral800 = Color(0xFF1D2939);
  static const Color neutral900 = Color(0xFF101828);
  static const Color neutral950 = Color(0xFF0C111D);

  // Success colors (refined green palette)
  static const Color success25 = Color(0xFFF6FEF9);
  static const Color success50 = Color(0xFFECFDF3);
  static const Color success100 = Color(0xFFD1FAE5);
  static const Color success200 = Color(0xFFA7F3D0);
  static const Color success300 = Color(0xFF6EE7B7);
  static const Color success400 = Color(0xFF34D399);
  static const Color success500 = Color(0xFF10B981);
  static const Color success600 = Color(0xFF059669);
  static const Color success700 = Color(0xFF047857);
  static const Color success800 = Color(0xFF065F46);
  static const Color success900 = Color(0xFF064E3B);
  static const Color success950 = Color(0xFF022C22);

  // Warning colors (refined orange/amber palette)
  static const Color warning25 = Color(0xFFFEFCF0);
  static const Color warning50 = Color(0xFFFEF7C0);
  static const Color warning100 = Color(0xFFFEEE95);
  static const Color warning200 = Color(0xFFFEE25A);
  static const Color warning300 = Color(0xFFFED52D);
  static const Color warning400 = Color(0xFFEAB308);
  static const Color warning500 = Color(0xFFCA8A04);
  static const Color warning600 = Color(0xFFA16207);
  static const Color warning700 = Color(0xFF854D0E);
  static const Color warning800 = Color(0xFF713F12);
  static const Color warning900 = Color(0xFF5A2E0A);
  static const Color warning950 = Color(0xFF4C1D05);

  // Error colors (refined red palette)
  static const Color error25 = Color(0xFFFEF3F2);
  static const Color error50 = Color(0xFFFEE4E2);
  static const Color error100 = Color(0xFFFECDCA);
  static const Color error200 = Color(0xFFFDA29B);
  static const Color error300 = Color(0xFFF97066);
  static const Color error400 = Color(0xFFF04438);
  static const Color error500 = Color(0xFFE53E3E);
  static const Color error600 = Color(0xFFD92D20);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);
  static const Color error950 = Color(0xFF5F1212);

  // Commonly used semantic colors
  static const Color primary = primary600;
  static const Color secondary = neutral600;
  static const Color surface = neutral25;
  static const Color background = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = neutral900;
  static const Color onBackground = neutral900;
  static const Color success = success600;
  static const Color warning = warning500;
  static const Color error = error600;

  // Border and divider colors (updated for new palette)
  static const Color border = neutral200;
  static const Color divider = neutral100;
  static const Color outline = neutral300;

  // Text colors (updated for new palette)
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral600;
  static const Color textTertiary = neutral500;
  static const Color textDisabled = neutral400;

  // Toggle colors
  static const Color toggleActive = Color(0xFF647690);

  /// Get human-readable name for a color
  /// Used in UI development tools like Widgetbook for better UX
  static String getColorName(Color color) {
    if (color == neutral800) return 'Neutral 800';
    if (color == onPrimary) return 'On Primary';
    if (color == primary600) return 'Primary 600';
    if (color == success600) return 'Success 600';
    if (color == warning600) return 'Warning 600';
    if (color == error600) return 'Error 600';
    if (color == background) return 'Background';
    if (color == neutral100) return 'Neutral 100';
    if (color == neutral300) return 'Neutral 300';
    if (color == neutral400) return 'Neutral 400';
    if (color == primary500) return 'Primary 500';
    if (color == primary400) return 'Primary 400';
    if (color == primary300) return 'Primary 300';
    if (color == success500) return 'Success 500';
    if (color == success400) return 'Success 400';
    if (color == success300) return 'Success 300';
    if (color == warning500) return 'Warning 500';
    if (color == warning400) return 'Warning 400';
    if (color == warning300) return 'Warning 300';
    if (color == error500) return 'Error 500';
    if (color == error400) return 'Error 400';
    if (color == error300) return 'Error 300';
    return 'Custom Color';
  }
}

/// Theme extension for Unping-UI specific colors
/// This integrates with Flutter's theme system while providing custom colors
class UnpingColorExtension extends ThemeExtension<UnpingColorExtension> {
  const UnpingColorExtension({
    required this.primary25,
    required this.primary50,
    required this.primary100,
    required this.primary200,
    required this.primary300,
    required this.primary400,
    required this.primary500,
    required this.primary600,
    required this.primary700,
    required this.primary800,
    required this.primary900,
    required this.primary950,
    required this.neutral25,
    required this.neutral50,
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.neutral400,
    required this.neutral500,
    required this.neutral600,
    required this.neutral700,
    required this.neutral800,
    required this.neutral900,
    required this.neutral950,
    required this.success25,
    required this.success50,
    required this.success100,
    required this.success200,
    required this.success300,
    required this.success400,
    required this.success500,
    required this.success600,
    required this.success700,
    required this.success800,
    required this.success900,
    required this.success950,
    required this.warning25,
    required this.warning50,
    required this.warning100,
    required this.warning200,
    required this.warning300,
    required this.warning400,
    required this.warning500,
    required this.warning600,
    required this.warning700,
    required this.warning800,
    required this.warning900,
    required this.warning950,
    required this.error25,
    required this.error50,
    required this.error100,
    required this.error200,
    required this.error300,
    required this.error400,
    required this.error500,
    required this.error600,
    required this.error700,
    required this.error800,
    required this.error900,
    required this.error950,
    required this.border,
    required this.divider,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
  });

  // Primary colors
  final Color primary25;
  final Color primary50;
  final Color primary100;
  final Color primary200;
  final Color primary300;
  final Color primary400;
  final Color primary500;
  final Color primary600;
  final Color primary700;
  final Color primary800;
  final Color primary900;
  final Color primary950;

  // Neutral colors
  final Color neutral25;
  final Color neutral50;
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;
  final Color neutral900;
  final Color neutral950;

  // Success colors
  final Color success25;
  final Color success50;
  final Color success100;
  final Color success200;
  final Color success300;
  final Color success400;
  final Color success500;
  final Color success600;
  final Color success700;
  final Color success800;
  final Color success900;
  final Color success950;

  // Warning colors
  final Color warning25;
  final Color warning50;
  final Color warning100;
  final Color warning200;
  final Color warning300;
  final Color warning400;
  final Color warning500;
  final Color warning600;
  final Color warning700;
  final Color warning800;
  final Color warning900;
  final Color warning950;

  // Error colors
  final Color error25;
  final Color error50;
  final Color error100;
  final Color error200;
  final Color error300;
  final Color error400;
  final Color error500;
  final Color error600;
  final Color error700;
  final Color error800;
  final Color error900;
  final Color error950;

  // UI colors
  final Color border;
  final Color divider;
  final Color outline;

  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;

  // Convenience getters for commonly used colors
  Color get primary => primary600;
  Color get secondary => neutral600;
  Color get surface => neutral25;
  Color get background => const Color(0xFFFFFFFF);
  Color get onPrimary => const Color(0xFFFFFFFF);
  Color get onSecondary => const Color(0xFFFFFFFF);
  Color get onSurface => neutral900;
  Color get onBackground => neutral900;
  Color get success => success600;
  Color get warning => warning500;
  Color get error => error600;

  static const light = UnpingColorExtension(
    primary25: UiColors.primary25,
    primary50: UiColors.primary50,
    primary100: UiColors.primary100,
    primary200: UiColors.primary200,
    primary300: UiColors.primary300,
    primary400: UiColors.primary400,
    primary500: UiColors.primary500,
    primary600: UiColors.primary600,
    primary700: UiColors.primary700,
    primary800: UiColors.primary800,
    primary900: UiColors.primary900,
    primary950: UiColors.primary950,
    neutral25: UiColors.neutral25,
    neutral50: UiColors.neutral50,
    neutral100: UiColors.neutral100,
    neutral200: UiColors.neutral200,
    neutral300: UiColors.neutral300,
    neutral400: UiColors.neutral400,
    neutral500: UiColors.neutral500,
    neutral600: UiColors.neutral600,
    neutral700: UiColors.neutral700,
    neutral800: UiColors.neutral800,
    neutral900: UiColors.neutral900,
    neutral950: UiColors.neutral950,
    success25: UiColors.success25,
    success50: UiColors.success50,
    success100: UiColors.success100,
    success200: UiColors.success200,
    success300: UiColors.success300,
    success400: UiColors.success400,
    success500: UiColors.success500,
    success600: UiColors.success600,
    success700: UiColors.success700,
    success800: UiColors.success800,
    success900: UiColors.success900,
    success950: UiColors.success950,
    warning25: UiColors.warning25,
    warning50: UiColors.warning50,
    warning100: UiColors.warning100,
    warning200: UiColors.warning200,
    warning300: UiColors.warning300,
    warning400: UiColors.warning400,
    warning500: UiColors.warning500,
    warning600: UiColors.warning600,
    warning700: UiColors.warning700,
    warning800: UiColors.warning800,
    warning900: UiColors.warning900,
    warning950: UiColors.warning950,
    error25: UiColors.error25,
    error50: UiColors.error50,
    error100: UiColors.error100,
    error200: UiColors.error200,
    error300: UiColors.error300,
    error400: UiColors.error400,
    error500: UiColors.error500,
    error600: UiColors.error600,
    error700: UiColors.error700,
    error800: UiColors.error800,
    error900: UiColors.error900,
    error950: UiColors.error950,
    border: UiColors.border,
    divider: UiColors.divider,
    outline: UiColors.outline,
    textPrimary: UiColors.textPrimary,
    textSecondary: UiColors.textSecondary,
    textTertiary: UiColors.textTertiary,
    textDisabled: UiColors.textDisabled,
  );

  static const dark = UnpingColorExtension(
    primary25: UiColors.primary950,
    primary50: UiColors.primary950,
    primary100: UiColors.primary900,
    primary200: UiColors.primary800,
    primary300: UiColors.primary700,
    primary400: UiColors.primary600,
    primary500: UiColors.primary500,
    primary600: UiColors.primary400,
    primary700: UiColors.primary300,
    primary800: UiColors.primary200,
    primary900: UiColors.primary100,
    primary950: UiColors.primary50,
    neutral25: UiColors.neutral950,
    neutral50: UiColors.neutral950,
    neutral100: UiColors.neutral900,
    neutral200: UiColors.neutral800,
    neutral300: UiColors.neutral700,
    neutral400: UiColors.neutral600,
    neutral500: UiColors.neutral500,
    neutral600: UiColors.neutral400,
    neutral700: UiColors.neutral300,
    neutral800: UiColors.neutral200,
    neutral900: UiColors.neutral100,
    neutral950: UiColors.neutral50,
    success25: UiColors.success950,
    success50: UiColors.success950,
    success100: UiColors.success900,
    success200: UiColors.success800,
    success300: UiColors.success700,
    success400: UiColors.success600,
    success500: UiColors.success500,
    success600: UiColors.success400,
    success700: UiColors.success300,
    success800: UiColors.success200,
    success900: UiColors.success100,
    success950: UiColors.success50,
    warning25: UiColors.warning950,
    warning50: UiColors.warning950,
    warning100: UiColors.warning900,
    warning200: UiColors.warning800,
    warning300: UiColors.warning700,
    warning400: UiColors.warning600,
    warning500: UiColors.warning500,
    warning600: UiColors.warning400,
    warning700: UiColors.warning300,
    warning800: UiColors.warning200,
    warning900: UiColors.warning100,
    warning950: UiColors.warning50,
    error25: UiColors.error950,
    error50: UiColors.error950,
    error100: UiColors.error900,
    error200: UiColors.error800,
    error300: UiColors.error700,
    error400: UiColors.error600,
    error500: UiColors.error500,
    error600: UiColors.error400,
    error700: UiColors.error300,
    error800: UiColors.error200,
    error900: UiColors.error100,
    error950: UiColors.error50,
    border: UiColors.neutral800,
    divider: UiColors.neutral900,
    outline: UiColors.neutral700,
    textPrimary: UiColors.neutral50,
    textSecondary: UiColors.neutral400,
    textTertiary: UiColors.neutral600,
    textDisabled: UiColors.neutral700,
  );

  @override
  UnpingColorExtension copyWith({
    Color? primary25,
    Color? primary50,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primary500,
    Color? primary600,
    Color? primary700,
    Color? primary800,
    Color? primary900,
    Color? primary950,
    Color? neutral25,
    Color? neutral50,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? neutral400,
    Color? neutral500,
    Color? neutral600,
    Color? neutral700,
    Color? neutral800,
    Color? neutral900,
    Color? neutral950,
    Color? success25,
    Color? success50,
    Color? success100,
    Color? success200,
    Color? success300,
    Color? success400,
    Color? success500,
    Color? success600,
    Color? success700,
    Color? success800,
    Color? success900,
    Color? success950,
    Color? warning25,
    Color? warning50,
    Color? warning100,
    Color? warning200,
    Color? warning300,
    Color? warning400,
    Color? warning500,
    Color? warning600,
    Color? warning700,
    Color? warning800,
    Color? warning900,
    Color? warning950,
    Color? error25,
    Color? error50,
    Color? error100,
    Color? error200,
    Color? error300,
    Color? error400,
    Color? error500,
    Color? error600,
    Color? error700,
    Color? error800,
    Color? error900,
    Color? error950,
    Color? border,
    Color? divider,
    Color? outline,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
  }) {
    return UnpingColorExtension(
      primary25: primary25 ?? this.primary25,
      primary50: primary50 ?? this.primary50,
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      primary400: primary400 ?? this.primary400,
      primary500: primary500 ?? this.primary500,
      primary600: primary600 ?? this.primary600,
      primary700: primary700 ?? this.primary700,
      primary800: primary800 ?? this.primary800,
      primary900: primary900 ?? this.primary900,
      primary950: primary950 ?? this.primary950,
      neutral25: neutral25 ?? this.neutral25,
      neutral50: neutral50 ?? this.neutral50,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral300: neutral300 ?? this.neutral300,
      neutral400: neutral400 ?? this.neutral400,
      neutral500: neutral500 ?? this.neutral500,
      neutral600: neutral600 ?? this.neutral600,
      neutral700: neutral700 ?? this.neutral700,
      neutral800: neutral800 ?? this.neutral800,
      neutral900: neutral900 ?? this.neutral900,
      neutral950: neutral950 ?? this.neutral950,
      success25: success25 ?? this.success25,
      success50: success50 ?? this.success50,
      success100: success100 ?? this.success100,
      success200: success200 ?? this.success200,
      success300: success300 ?? this.success300,
      success400: success400 ?? this.success400,
      success500: success500 ?? this.success500,
      success600: success600 ?? this.success600,
      success700: success700 ?? this.success700,
      success800: success800 ?? this.success800,
      success900: success900 ?? this.success900,
      success950: success950 ?? this.success950,
      warning25: warning25 ?? this.warning25,
      warning50: warning50 ?? this.warning50,
      warning100: warning100 ?? this.warning100,
      warning200: warning200 ?? this.warning200,
      warning300: warning300 ?? this.warning300,
      warning400: warning400 ?? this.warning400,
      warning500: warning500 ?? this.warning500,
      warning600: warning600 ?? this.warning600,
      warning700: warning700 ?? this.warning700,
      warning800: warning800 ?? this.warning800,
      warning900: warning900 ?? this.warning900,
      warning950: warning950 ?? this.warning950,
      error25: error25 ?? this.error25,
      error50: error50 ?? this.error50,
      error100: error100 ?? this.error100,
      error200: error200 ?? this.error200,
      error300: error300 ?? this.error300,
      error400: error400 ?? this.error400,
      error500: error500 ?? this.error500,
      error600: error600 ?? this.error600,
      error700: error700 ?? this.error700,
      error800: error800 ?? this.error800,
      error900: error900 ?? this.error900,
      error950: error950 ?? this.error950,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      outline: outline ?? this.outline,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      // coverage:ignore-start
      textDisabled: textDisabled ?? this.textDisabled,
      // coverage:ignore-end
    );
  }

  @override
  UnpingColorExtension lerp(
    ThemeExtension<UnpingColorExtension>? other,
    double t,
  ) {
    if (other is! UnpingColorExtension) {
      return this;
    }
    return UnpingColorExtension(
      primary25: Color.lerp(primary25, other.primary25, t)!,
      primary50: Color.lerp(primary50, other.primary50, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      primary200: Color.lerp(primary200, other.primary200, t)!,
      primary300: Color.lerp(primary300, other.primary300, t)!,
      primary400: Color.lerp(primary400, other.primary400, t)!,
      primary500: Color.lerp(primary500, other.primary500, t)!,
      primary600: Color.lerp(primary600, other.primary600, t)!,
      primary700: Color.lerp(primary700, other.primary700, t)!,
      primary800: Color.lerp(primary800, other.primary800, t)!,
      primary900: Color.lerp(primary900, other.primary900, t)!,
      primary950: Color.lerp(primary950, other.primary950, t)!,
      neutral25: Color.lerp(neutral25, other.neutral25, t)!,
      neutral50: Color.lerp(neutral50, other.neutral50, t)!,
      neutral100: Color.lerp(neutral100, other.neutral100, t)!,
      neutral200: Color.lerp(neutral200, other.neutral200, t)!,
      neutral300: Color.lerp(neutral300, other.neutral300, t)!,
      neutral400: Color.lerp(neutral400, other.neutral400, t)!,
      neutral500: Color.lerp(neutral500, other.neutral500, t)!,
      neutral600: Color.lerp(neutral600, other.neutral600, t)!,
      neutral700: Color.lerp(neutral700, other.neutral700, t)!,
      neutral800: Color.lerp(neutral800, other.neutral800, t)!,
      neutral900: Color.lerp(neutral900, other.neutral900, t)!,
      neutral950: Color.lerp(neutral950, other.neutral950, t)!,
      success25: Color.lerp(success25, other.success25, t)!,
      success50: Color.lerp(success50, other.success50, t)!,
      success100: Color.lerp(success100, other.success100, t)!,
      success200: Color.lerp(success200, other.success200, t)!,
      success300: Color.lerp(success300, other.success300, t)!,
      success400: Color.lerp(success400, other.success400, t)!,
      success500: Color.lerp(success500, other.success500, t)!,
      success600: Color.lerp(success600, other.success600, t)!,
      success700: Color.lerp(success700, other.success700, t)!,
      success800: Color.lerp(success800, other.success800, t)!,
      success900: Color.lerp(success900, other.success900, t)!,
      success950: Color.lerp(success950, other.success950, t)!,
      warning25: Color.lerp(warning25, other.warning25, t)!,
      warning50: Color.lerp(warning50, other.warning50, t)!,
      warning100: Color.lerp(warning100, other.warning100, t)!,
      warning200: Color.lerp(warning200, other.warning200, t)!,
      warning300: Color.lerp(warning300, other.warning300, t)!,
      warning400: Color.lerp(warning400, other.warning400, t)!,
      warning500: Color.lerp(warning500, other.warning500, t)!,
      warning600: Color.lerp(warning600, other.warning600, t)!,
      warning700: Color.lerp(warning700, other.warning700, t)!,
      warning800: Color.lerp(warning800, other.warning800, t)!,
      warning900: Color.lerp(warning900, other.warning900, t)!,
      warning950: Color.lerp(warning950, other.warning950, t)!,
      error25: Color.lerp(error25, other.error25, t)!,
      error50: Color.lerp(error50, other.error50, t)!,
      error100: Color.lerp(error100, other.error100, t)!,
      error200: Color.lerp(error200, other.error200, t)!,
      error300: Color.lerp(error300, other.error300, t)!,
      error400: Color.lerp(error400, other.error400, t)!,
      error500: Color.lerp(error500, other.error500, t)!,
      error600: Color.lerp(error600, other.error600, t)!,
      error700: Color.lerp(error700, other.error700, t)!,
      error800: Color.lerp(error800, other.error800, t)!,
      error900: Color.lerp(error900, other.error900, t)!,
      error950: Color.lerp(error950, other.error950, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
    );
  }
}

/// Extension on BuildContext to easily access Unping-UI colors
extension UnpingColorContext on BuildContext {
  UnpingColorExtension get UiColors =>
      Theme.of(this).extension<UnpingColorExtension>() ??
      UnpingColorExtension.light;
}
