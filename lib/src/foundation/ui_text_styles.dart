import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unping-UI typography system
/// Provides consistent text styles throughout the design system
/// Based on the Figma design system with Outfit font family
class UiTextStyles {
  // Helper method to get Outfit font
  static TextStyle _outfitTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double lineHeight,
    double letterSpacing = 0,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  // Base font weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Display text styles (for large headings and hero text)
  /// Display 2xl: 72px | Line height: 90px | Weight: 400
  static final TextStyle display2xl = _outfitTextStyle(
    fontSize: 72,
    fontWeight: regular,
    lineHeight: 90,
  );

  /// Display 2xl: 72px | Line height: 90px | Weight: 500
  static final TextStyle display2xlMedium = _outfitTextStyle(
    fontSize: 72,
    fontWeight: medium,
    lineHeight: 90,
  );

  /// Display 2xl: 72px | Line height: 90px | Weight: 600
  static final TextStyle display2xlSemibold = _outfitTextStyle(
    fontSize: 72,
    fontWeight: semiBold,
    lineHeight: 90,
  );

  /// Display 2xl: 72px | Line height: 90px | Weight: 700
  static final TextStyle display2xlBold = _outfitTextStyle(
    fontSize: 72,
    fontWeight: bold,
    lineHeight: 90,
  );

  /// Display xl: 60px | Line height: 72px | Weight: 400
  static final TextStyle displayXl = _outfitTextStyle(
    fontSize: 60,
    fontWeight: regular,
    lineHeight: 72,
  );

  /// Display xl: 60px | Line height: 72px | Weight: 500
  static final TextStyle displayXlMedium = _outfitTextStyle(
    fontSize: 60,
    fontWeight: medium,
    lineHeight: 72,
  );

  /// Display xl: 60px | Line height: 72px | Weight: 600
  static final TextStyle displayXlSemibold = _outfitTextStyle(
    fontSize: 60,
    fontWeight: semiBold,
    lineHeight: 72,
  );

  /// Display xl: 60px | Line height: 72px | Weight: 700
  static final TextStyle displayXlBold = _outfitTextStyle(
    fontSize: 60,
    fontWeight: bold,
    lineHeight: 72,
  );

  /// Display lg: 48px | Line height: 60px | Weight: 400
  static final TextStyle displayLg = _outfitTextStyle(
    fontSize: 48,
    fontWeight: regular,
    lineHeight: 60,
  );

  /// Display lg: 48px | Line height: 60px | Weight: 500
  static final TextStyle displayLgMedium = _outfitTextStyle(
    fontSize: 48,
    fontWeight: medium,
    lineHeight: 60,
  );

  /// Display lg: 48px | Line height: 60px | Weight: 600
  static final TextStyle displayLgSemibold = _outfitTextStyle(
    fontSize: 48,
    fontWeight: semiBold,
    lineHeight: 60,
  );

  /// Display lg: 48px | Line height: 60px | Weight: 700
  static final TextStyle displayLgBold = _outfitTextStyle(
    fontSize: 48,
    fontWeight: bold,
    lineHeight: 60,
  );

  /// Display md: 36px | Line height: 44px | Weight: 400
  static final TextStyle displayMd = _outfitTextStyle(
    fontSize: 36,
    fontWeight: regular,
    lineHeight: 44,
  );

  /// Display md: 36px | Line height: 44px | Weight: 500
  static final TextStyle displayMdMedium = _outfitTextStyle(
    fontSize: 36,
    fontWeight: medium,
    lineHeight: 44,
  );

  /// Display md: 36px | Line height: 44px | Weight: 600
  static final TextStyle displayMdSemibold = _outfitTextStyle(
    fontSize: 36,
    fontWeight: semiBold,
    lineHeight: 44,
  );

  /// Display md: 36px | Line height: 44px | Weight: 700
  static final TextStyle displayMdBold = _outfitTextStyle(
    fontSize: 36,
    fontWeight: bold,
    lineHeight: 44,
  );

  /// Display sm: 30px | Line height: 38px | Weight: 400
  static final TextStyle displaySm = _outfitTextStyle(
    fontSize: 30,
    fontWeight: regular,
    lineHeight: 38,
  );

  /// Display sm: 30px | Line height: 38px | Weight: 500
  static final TextStyle displaySmMedium = _outfitTextStyle(
    fontSize: 30,
    fontWeight: medium,
    lineHeight: 38,
  );

  /// Display sm: 30px | Line height: 38px | Weight: 600
  static final TextStyle displaySmSemibold = _outfitTextStyle(
    fontSize: 30,
    fontWeight: semiBold,
    lineHeight: 38,
  );

  /// Display sm: 30px | Line height: 38px | Weight: 700
  static final TextStyle displaySmBold = _outfitTextStyle(
    fontSize: 30,
    fontWeight: bold,
    lineHeight: 38,
  );

  /// Display xs: 24px | Line height: 32px | Weight: 400
  static final TextStyle displayXs = _outfitTextStyle(
    fontSize: 24,
    fontWeight: regular,
    lineHeight: 32,
  );

  /// Display xs: 24px | Line height: 32px | Weight: 500
  static final TextStyle displayXsMedium = _outfitTextStyle(
    fontSize: 24,
    fontWeight: medium,
    lineHeight: 32,
  );

  /// Display xs: 24px | Line height: 32px | Weight: 600
  static final TextStyle displayXsSemibold = _outfitTextStyle(
    fontSize: 24,
    fontWeight: semiBold,
    lineHeight: 32,
  );

  /// Display xs: 24px | Line height: 32px | Weight: 700
  static final TextStyle displayXsBold = _outfitTextStyle(
    fontSize: 24,
    fontWeight: bold,
    lineHeight: 32,
  );

  /// Text xl: 20px | Line height: 30px | Weight: 400
  static final TextStyle textXl = _outfitTextStyle(
    fontSize: 20,
    fontWeight: regular,
    lineHeight: 30,
  );

  /// Text xl: 20px | Line height: 30px | Weight: 500
  static final TextStyle textXlMedium = _outfitTextStyle(
    fontSize: 20,
    fontWeight: medium,
    lineHeight: 30,
  );

  /// Text xl: 20px | Line height: 30px | Weight: 600
  static final TextStyle textXlSemibold = _outfitTextStyle(
    fontSize: 20,
    fontWeight: semiBold,
    lineHeight: 30,
  );

  /// Text xl: 20px | Line height: 30px | Weight: 700
  static final TextStyle textXlBold = _outfitTextStyle(
    fontSize: 20,
    fontWeight: bold,
    lineHeight: 30,
  );

  /// Text lg: 18px | Line height: 28px | Weight: 400
  static final TextStyle textLg = _outfitTextStyle(
    fontSize: 18,
    fontWeight: regular,
    lineHeight: 28,
  );

  /// Text lg: 18px | Line height: 28px | Weight: 500
  static final TextStyle textLgMedium = _outfitTextStyle(
    fontSize: 18,
    fontWeight: medium,
    lineHeight: 28,
  );

  /// Text lg: 18px | Line height: 28px | Weight: 600
  static final TextStyle textLgSemibold = _outfitTextStyle(
    fontSize: 18,
    fontWeight: semiBold,
    lineHeight: 28,
  );

  /// Text lg: 18px | Line height: 28px | Weight: 700
  static final TextStyle textLgBold = _outfitTextStyle(
    fontSize: 18,
    fontWeight: bold,
    lineHeight: 28,
  );

  /// Text md: 16px | Line height: 24px | Weight: 400
  static final TextStyle textMd = _outfitTextStyle(
    fontSize: 16,
    fontWeight: regular,
    lineHeight: 24,
  );

  /// Text md: 16px | Line height: 24px | Weight: 500
  static final TextStyle textMdMedium = _outfitTextStyle(
    fontSize: 16,
    fontWeight: medium,
    lineHeight: 24,
  );

  /// Text md: 16px | Line height: 24px | Weight: 600
  static final TextStyle textMdSemibold = _outfitTextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    lineHeight: 24,
  );

  /// Text md: 16px | Line height: 24px | Weight: 700
  static final TextStyle textMdBold = _outfitTextStyle(
    fontSize: 16,
    fontWeight: bold,
    lineHeight: 24,
  );

  /// Text sm: 14px | Line height: 20px | Weight: 400
  static final TextStyle textSm = _outfitTextStyle(
    fontSize: 14,
    fontWeight: regular,
    lineHeight: 20,
  );

  /// Text sm: 14px | Line height: 20px | Weight: 500
  static final TextStyle textSmMedium = _outfitTextStyle(
    fontSize: 14,
    fontWeight: medium,
    lineHeight: 20,
  );

  /// Text sm: 14px | Line height: 20px | Weight: 600
  static final TextStyle textSmSemibold = _outfitTextStyle(
    fontSize: 14,
    fontWeight: semiBold,
    lineHeight: 20,
  );

  /// Text sm: 14px | Line height: 20px | Weight: 700
  static final TextStyle textSmBold = _outfitTextStyle(
    fontSize: 14,
    fontWeight: bold,
    lineHeight: 20,
  );

  /// Text sm: 14px | Line height: 20px | Weight: 400 | Underlined
  static final TextStyle textSmUnderline = _outfitTextStyle(
    fontSize: 14,
    fontWeight: regular,
    lineHeight: 20,
    decoration: TextDecoration.underline,
  );

  /// Text xs: 12px | Line height: 18px | Weight: 400
  static final TextStyle textXs = _outfitTextStyle(
    fontSize: 12,
    fontWeight: regular,
    lineHeight: 18,
  );

  /// Text xs: 12px | Line height: 18px | Weight: 500
  static final TextStyle textXsMedium = _outfitTextStyle(
    fontSize: 12,
    fontWeight: medium,
    lineHeight: 18,
  );

  /// Text xs: 12px | Line height: 18px | Weight: 600
  static final TextStyle textXsSemibold = _outfitTextStyle(
    fontSize: 12,
    fontWeight: semiBold,
    lineHeight: 18,
  );

  /// Text xs: 12px | Line height: 18px | Weight: 700
  static final TextStyle textXsBold = _outfitTextStyle(
    fontSize: 12,
    fontWeight: bold,
    lineHeight: 18,
  );

  // Legacy aliases for backward compatibility
  static final TextStyle displayLarge = display2xl;
  static final TextStyle displayMedium = displayXl;
  static final TextStyle displaySmall = displayLg;
  static final TextStyle headlineLarge = displayMd;
  static final TextStyle headlineMedium = displaySm;
  static final TextStyle headlineSmall = displayXs;
  static final TextStyle titleLarge = textXl;
  static final TextStyle titleMedium = textMd;
  static final TextStyle titleSmall = textSm;
  static final TextStyle bodyLarge = textMd;
  static final TextStyle bodyMedium = textSm;
  static final TextStyle bodySmall = textXs;
  static final TextStyle labelLarge = textSm;
  static final TextStyle labelMedium = textXs;
  static final TextStyle labelSmall = textXs;

  // Code text styles (for monospace text)
  static final TextStyle codeLarge = GoogleFonts.courierPrime(
    fontSize: 16,
    fontWeight: regular,
    height: 1.50,
    letterSpacing: 0,
  );

  static final TextStyle codeMedium = GoogleFonts.courierPrime(
    fontSize: 14,
    fontWeight: regular,
    height: 1.43,
    letterSpacing: 0,
  );

  static final TextStyle codeSmall = GoogleFonts.courierPrime(
    fontSize: 12,
    fontWeight: regular,
    height: 1.33,
    letterSpacing: 0,
  );

  // Custom utility styles
  static final TextStyle caption = _outfitTextStyle(
    fontSize: 12,
    fontWeight: regular,
    lineHeight: 16,
    letterSpacing: 0.4,
  );

  static final TextStyle overline = _outfitTextStyle(
    fontSize: 10,
    fontWeight: medium,
    lineHeight: 16,
    letterSpacing: 1.5,
  );

  /// Get human-readable name for a text style
  /// Used in UI development tools like Widgetbook for better UX
  static String getTextStyleName(TextStyle style) {
    if (style == textXs) return 'Text XS';
    if (style == textSm) return 'Text SM';
    if (style == textMd) return 'Text MD';
    if (style == textLg) return 'Text LG';
    if (style == textXl) return 'Text XL';
    return 'Custom Style';
  }
}

/// Theme extension for typography
/// Allows customization of text styles through the theme system
class UnpingTextStyleExtension
    extends ThemeExtension<UnpingTextStyleExtension> {
  UnpingTextStyleExtension({
    TextStyle? display2xl,
    TextStyle? display2xlMedium,
    TextStyle? display2xlSemibold,
    TextStyle? display2xlBold,
    TextStyle? displayXl,
    TextStyle? displayXlMedium,
    TextStyle? displayXlSemibold,
    TextStyle? displayXlBold,
    TextStyle? displayLg,
    TextStyle? displayLgMedium,
    TextStyle? displayLgSemibold,
    TextStyle? displayLgBold,
    TextStyle? displayMd,
    TextStyle? displayMdMedium,
    TextStyle? displayMdSemibold,
    TextStyle? displayMdBold,
    TextStyle? displaySm,
    TextStyle? displaySmMedium,
    TextStyle? displaySmSemibold,
    TextStyle? displaySmBold,
    TextStyle? displayXs,
    TextStyle? displayXsMedium,
    TextStyle? displayXsSemibold,
    TextStyle? displayXsBold,
    TextStyle? textXl,
    TextStyle? textXlMedium,
    TextStyle? textXlSemibold,
    TextStyle? textXlBold,
    TextStyle? textLg,
    TextStyle? textLgMedium,
    TextStyle? textLgSemibold,
    TextStyle? textLgBold,
    TextStyle? textMd,
    TextStyle? textMdMedium,
    TextStyle? textMdSemibold,
    TextStyle? textMdBold,
    TextStyle? textSm,
    TextStyle? textSmMedium,
    TextStyle? textSmSemibold,
    TextStyle? textSmBold,
    TextStyle? textSmUnderline,
    TextStyle? textXs,
    TextStyle? textXsMedium,
    TextStyle? textXsSemibold,
    TextStyle? textXsBold,
    // Legacy compatibility styles
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? codeLarge,
    TextStyle? codeMedium,
    TextStyle? codeSmall,
    TextStyle? caption,
    TextStyle? overline,
  })  : display2xl = display2xl ?? UiTextStyles.display2xl,
        display2xlMedium = display2xlMedium ?? UiTextStyles.display2xlMedium,
        display2xlSemibold =
            display2xlSemibold ?? UiTextStyles.display2xlSemibold,
        display2xlBold = display2xlBold ?? UiTextStyles.display2xlBold,
        displayXl = displayXl ?? UiTextStyles.displayXl,
        displayXlMedium = displayXlMedium ?? UiTextStyles.displayXlMedium,
        displayXlSemibold = displayXlSemibold ?? UiTextStyles.displayXlSemibold,
        displayXlBold = displayXlBold ?? UiTextStyles.displayXlBold,
        displayLg = displayLg ?? UiTextStyles.displayLg,
        displayLgMedium = displayLgMedium ?? UiTextStyles.displayLgMedium,
        displayLgSemibold = displayLgSemibold ?? UiTextStyles.displayLgSemibold,
        displayLgBold = displayLgBold ?? UiTextStyles.displayLgBold,
        displayMd = displayMd ?? UiTextStyles.displayMd,
        displayMdMedium = displayMdMedium ?? UiTextStyles.displayMdMedium,
        displayMdSemibold = displayMdSemibold ?? UiTextStyles.displayMdSemibold,
        displayMdBold = displayMdBold ?? UiTextStyles.displayMdBold,
        displaySm = displaySm ?? UiTextStyles.displaySm,
        displaySmMedium = displaySmMedium ?? UiTextStyles.displaySmMedium,
        displaySmSemibold = displaySmSemibold ?? UiTextStyles.displaySmSemibold,
        displaySmBold = displaySmBold ?? UiTextStyles.displaySmBold,
        displayXs = displayXs ?? UiTextStyles.displayXs,
        displayXsMedium = displayXsMedium ?? UiTextStyles.displayXsMedium,
        displayXsSemibold = displayXsSemibold ?? UiTextStyles.displayXsSemibold,
        displayXsBold = displayXsBold ?? UiTextStyles.displayXsBold,
        textXl = textXl ?? UiTextStyles.textXl,
        textXlMedium = textXlMedium ?? UiTextStyles.textXlMedium,
        textXlSemibold = textXlSemibold ?? UiTextStyles.textXlSemibold,
        textXlBold = textXlBold ?? UiTextStyles.textXlBold,
        textLg = textLg ?? UiTextStyles.textLg,
        textLgMedium = textLgMedium ?? UiTextStyles.textLgMedium,
        textLgSemibold = textLgSemibold ?? UiTextStyles.textLgSemibold,
        textLgBold = textLgBold ?? UiTextStyles.textLgBold,
        textMd = textMd ?? UiTextStyles.textMd,
        textMdMedium = textMdMedium ?? UiTextStyles.textMdMedium,
        textMdSemibold = textMdSemibold ?? UiTextStyles.textMdSemibold,
        textMdBold = textMdBold ?? UiTextStyles.textMdBold,
        textSm = textSm ?? UiTextStyles.textSm,
        textSmMedium = textSmMedium ?? UiTextStyles.textSmMedium,
        textSmSemibold = textSmSemibold ?? UiTextStyles.textSmSemibold,
        textSmBold = textSmBold ?? UiTextStyles.textSmBold,
        textSmUnderline = textSmUnderline ?? UiTextStyles.textSmUnderline,
        textXs = textXs ?? UiTextStyles.textXs,
        textXsMedium = textXsMedium ?? UiTextStyles.textXsMedium,
        textXsSemibold = textXsSemibold ?? UiTextStyles.textXsSemibold,
        textXsBold = textXsBold ?? UiTextStyles.textXsBold,
        // Legacy compatibility styles
        this.displayLarge = displayLarge ?? UiTextStyles.displayLarge,
        this.displayMedium = displayMedium ?? UiTextStyles.displayMedium,
        this.displaySmall = displaySmall ?? UiTextStyles.displaySmall,
        this.headlineLarge = headlineLarge ?? UiTextStyles.headlineLarge,
        this.headlineMedium = headlineMedium ?? UiTextStyles.headlineMedium,
        this.headlineSmall = headlineSmall ?? UiTextStyles.headlineSmall,
        this.titleLarge = titleLarge ?? UiTextStyles.titleLarge,
        this.titleMedium = titleMedium ?? UiTextStyles.titleMedium,
        this.titleSmall = titleSmall ?? UiTextStyles.titleSmall,
        this.labelLarge = labelLarge ?? UiTextStyles.labelLarge,
        this.labelMedium = labelMedium ?? UiTextStyles.labelMedium,
        this.labelSmall = labelSmall ?? UiTextStyles.labelSmall,
        this.bodyLarge = bodyLarge ?? UiTextStyles.bodyLarge,
        this.bodyMedium = bodyMedium ?? UiTextStyles.bodyMedium,
        this.bodySmall = bodySmall ?? UiTextStyles.bodySmall,
        this.codeLarge = codeLarge ?? UiTextStyles.codeLarge,
        this.codeMedium = codeMedium ?? UiTextStyles.codeMedium,
        this.codeSmall = codeSmall ?? UiTextStyles.codeSmall,
        this.caption = caption ?? UiTextStyles.caption,
        this.overline = overline ?? UiTextStyles.overline;

  // Figma-based styles
  final TextStyle display2xl;
  final TextStyle display2xlMedium;
  final TextStyle display2xlSemibold;
  final TextStyle display2xlBold;
  final TextStyle displayXl;
  final TextStyle displayXlMedium;
  final TextStyle displayXlSemibold;
  final TextStyle displayXlBold;
  final TextStyle displayLg;
  final TextStyle displayLgMedium;
  final TextStyle displayLgSemibold;
  final TextStyle displayLgBold;
  final TextStyle displayMd;
  final TextStyle displayMdMedium;
  final TextStyle displayMdSemibold;
  final TextStyle displayMdBold;
  final TextStyle displaySm;
  final TextStyle displaySmMedium;
  final TextStyle displaySmSemibold;
  final TextStyle displaySmBold;
  final TextStyle displayXs;
  final TextStyle displayXsMedium;
  final TextStyle displayXsSemibold;
  final TextStyle displayXsBold;
  final TextStyle textXl;
  final TextStyle textXlMedium;
  final TextStyle textXlSemibold;
  final TextStyle textXlBold;
  final TextStyle textLg;
  final TextStyle textLgMedium;
  final TextStyle textLgSemibold;
  final TextStyle textLgBold;
  final TextStyle textMd;
  final TextStyle textMdMedium;
  final TextStyle textMdSemibold;
  final TextStyle textMdBold;
  final TextStyle textSm;
  final TextStyle textSmMedium;
  final TextStyle textSmSemibold;
  final TextStyle textSmBold;
  final TextStyle textSmUnderline;
  final TextStyle textXs;
  final TextStyle textXsMedium;
  final TextStyle textXsSemibold;
  final TextStyle textXsBold;

  // Legacy compatibility styles
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle codeLarge;
  final TextStyle codeMedium;
  final TextStyle codeSmall;
  final TextStyle caption;
  final TextStyle overline;

  static final standard = UnpingTextStyleExtension();

  @override
  UnpingTextStyleExtension copyWith({
    // Figma-based styles
    TextStyle? display2xl,
    TextStyle? display2xlMedium,
    TextStyle? display2xlSemibold,
    TextStyle? display2xlBold,
    TextStyle? displayXl,
    TextStyle? displayXlMedium,
    TextStyle? displayXlSemibold,
    TextStyle? displayXlBold,
    TextStyle? displayLg,
    TextStyle? displayLgMedium,
    TextStyle? displayLgSemibold,
    TextStyle? displayLgBold,
    TextStyle? displayMd,
    TextStyle? displayMdMedium,
    TextStyle? displayMdSemibold,
    TextStyle? displayMdBold,
    TextStyle? displaySm,
    TextStyle? displaySmMedium,
    TextStyle? displaySmSemibold,
    TextStyle? displaySmBold,
    TextStyle? displayXs,
    TextStyle? displayXsMedium,
    TextStyle? displayXsSemibold,
    TextStyle? displayXsBold,
    TextStyle? textXl,
    TextStyle? textXlMedium,
    TextStyle? textXlSemibold,
    TextStyle? textXlBold,
    TextStyle? textLg,
    TextStyle? textLgMedium,
    TextStyle? textLgSemibold,
    TextStyle? textLgBold,
    TextStyle? textMd,
    TextStyle? textMdMedium,
    TextStyle? textMdSemibold,
    TextStyle? textMdBold,
    TextStyle? textSm,
    TextStyle? textSmMedium,
    TextStyle? textSmSemibold,
    TextStyle? textSmBold,
    TextStyle? textSmUnderline,
    TextStyle? textXs,
    TextStyle? textXsMedium,
    TextStyle? textXsSemibold,
    TextStyle? textXsBold,
    // Legacy compatibility styles
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? codeLarge,
    TextStyle? codeMedium,
    TextStyle? codeSmall,
    TextStyle? caption,
    TextStyle? overline,
  }) {
    return UnpingTextStyleExtension(
      // Figma-based styles
      display2xl: display2xl ?? this.display2xl,
      display2xlMedium: display2xlMedium ?? this.display2xlMedium,
      display2xlSemibold: display2xlSemibold ?? this.display2xlSemibold,
      display2xlBold: display2xlBold ?? this.display2xlBold,
      displayXl: displayXl ?? this.displayXl,
      displayXlMedium: displayXlMedium ?? this.displayXlMedium,
      displayXlSemibold: displayXlSemibold ?? this.displayXlSemibold,
      displayXlBold: displayXlBold ?? this.displayXlBold,
      displayLg: displayLg ?? this.displayLg,
      displayLgMedium: displayLgMedium ?? this.displayLgMedium,
      displayLgSemibold: displayLgSemibold ?? this.displayLgSemibold,
      displayLgBold: displayLgBold ?? this.displayLgBold,
      displayMd: displayMd ?? this.displayMd,
      displayMdMedium: displayMdMedium ?? this.displayMdMedium,
      displayMdSemibold: displayMdSemibold ?? this.displayMdSemibold,
      displayMdBold: displayMdBold ?? this.displayMdBold,
      displaySm: displaySm ?? this.displaySm,
      displaySmMedium: displaySmMedium ?? this.displaySmMedium,
      displaySmSemibold: displaySmSemibold ?? this.displaySmSemibold,
      displaySmBold: displaySmBold ?? this.displaySmBold,
      displayXs: displayXs ?? this.displayXs,
      displayXsMedium: displayXsMedium ?? this.displayXsMedium,
      displayXsSemibold: displayXsSemibold ?? this.displayXsSemibold,
      displayXsBold: displayXsBold ?? this.displayXsBold,
      textXl: textXl ?? this.textXl,
      textXlMedium: textXlMedium ?? this.textXlMedium,
      textXlSemibold: textXlSemibold ?? this.textXlSemibold,
      textXlBold: textXlBold ?? this.textXlBold,
      textLg: textLg ?? this.textLg,
      textLgMedium: textLgMedium ?? this.textLgMedium,
      textLgSemibold: textLgSemibold ?? this.textLgSemibold,
      textLgBold: textLgBold ?? this.textLgBold,
      // coverage:ignore-start
      textMd: textMd ?? this.textMd,
      // coverage:ignore-end
      textMdMedium: textMdMedium ?? this.textMdMedium,
      textMdSemibold: textMdSemibold ?? this.textMdSemibold,
      textMdBold: textMdBold ?? this.textMdBold,
      textSm: textSm ?? this.textSm,
      textSmMedium: textSmMedium ?? this.textSmMedium,
      textSmSemibold: textSmSemibold ?? this.textSmSemibold,
      textSmBold: textSmBold ?? this.textSmBold,
      textSmUnderline: textSmUnderline ?? this.textSmUnderline,
      textXs: textXs ?? this.textXs,
      textXsMedium: textXsMedium ?? this.textXsMedium,
      textXsSemibold: textXsSemibold ?? this.textXsSemibold,
      textXsBold: textXsBold ?? this.textXsBold,
      // Legacy compatibility styles
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      codeLarge: codeLarge ?? this.codeLarge,
      codeMedium: codeMedium ?? this.codeMedium,
      codeSmall: codeSmall ?? this.codeSmall,
      caption: caption ?? this.caption,
      overline: overline ?? this.overline,
    );
  }

  @override
  UnpingTextStyleExtension lerp(
    ThemeExtension<UnpingTextStyleExtension>? other,
    double t,
  ) {
    if (other is! UnpingTextStyleExtension) {
      return this;
    }
    return UnpingTextStyleExtension(
      // Figma-based styles
      display2xl: TextStyle.lerp(display2xl, other.display2xl, t)!,
      display2xlMedium: TextStyle.lerp(
        display2xlMedium,
        other.display2xlMedium,
        t,
      )!,
      display2xlSemibold: TextStyle.lerp(
        display2xlSemibold,
        other.display2xlSemibold,
        t,
      )!,
      display2xlBold: TextStyle.lerp(display2xlBold, other.display2xlBold, t)!,
      displayXl: TextStyle.lerp(displayXl, other.displayXl, t)!,
      displayXlMedium: TextStyle.lerp(
        displayXlMedium,
        other.displayXlMedium,
        t,
      )!,
      displayXlSemibold: TextStyle.lerp(
        displayXlSemibold,
        other.displayXlSemibold,
        t,
      )!,
      displayXlBold: TextStyle.lerp(displayXlBold, other.displayXlBold, t)!,
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayLgMedium: TextStyle.lerp(
        displayLgMedium,
        other.displayLgMedium,
        t,
      )!,
      displayLgSemibold: TextStyle.lerp(
        displayLgSemibold,
        other.displayLgSemibold,
        t,
      )!,
      displayLgBold: TextStyle.lerp(displayLgBold, other.displayLgBold, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      displayMdMedium: TextStyle.lerp(
        displayMdMedium,
        other.displayMdMedium,
        t,
      )!,
      displayMdSemibold: TextStyle.lerp(
        displayMdSemibold,
        other.displayMdSemibold,
        t,
      )!,
      displayMdBold: TextStyle.lerp(displayMdBold, other.displayMdBold, t)!,
      displaySm: TextStyle.lerp(displaySm, other.displaySm, t)!,
      displaySmMedium: TextStyle.lerp(
        displaySmMedium,
        other.displaySmMedium,
        t,
      )!,
      displaySmSemibold: TextStyle.lerp(
        displaySmSemibold,
        other.displaySmSemibold,
        t,
      )!,
      displaySmBold: TextStyle.lerp(displaySmBold, other.displaySmBold, t)!,
      displayXs: TextStyle.lerp(displayXs, other.displayXs, t)!,
      displayXsMedium: TextStyle.lerp(
        displayXsMedium,
        other.displayXsMedium,
        t,
      )!,
      displayXsSemibold: TextStyle.lerp(
        displayXsSemibold,
        other.displayXsSemibold,
        t,
      )!,
      displayXsBold: TextStyle.lerp(displayXsBold, other.displayXsBold, t)!,
      textXl: TextStyle.lerp(textXl, other.textXl, t)!,
      textXlMedium: TextStyle.lerp(textXlMedium, other.textXlMedium, t)!,
      textXlSemibold: TextStyle.lerp(textXlSemibold, other.textXlSemibold, t)!,
      textXlBold: TextStyle.lerp(textXlBold, other.textXlBold, t)!,
      textLg: TextStyle.lerp(textLg, other.textLg, t)!,
      textLgMedium: TextStyle.lerp(textLgMedium, other.textLgMedium, t)!,
      textLgSemibold: TextStyle.lerp(textLgSemibold, other.textLgSemibold, t)!,
      textLgBold: TextStyle.lerp(textLgBold, other.textLgBold, t)!,
      textMd: TextStyle.lerp(textMd, other.textMd, t)!,
      textMdMedium: TextStyle.lerp(textMdMedium, other.textMdMedium, t)!,
      textMdSemibold: TextStyle.lerp(textMdSemibold, other.textMdSemibold, t)!,
      textMdBold: TextStyle.lerp(textMdBold, other.textMdBold, t)!,
      textSm: TextStyle.lerp(textSm, other.textSm, t)!,
      textSmMedium: TextStyle.lerp(textSmMedium, other.textSmMedium, t)!,
      textSmSemibold: TextStyle.lerp(textSmSemibold, other.textSmSemibold, t)!,
      textSmBold: TextStyle.lerp(textSmBold, other.textSmBold, t)!,
      textSmUnderline: TextStyle.lerp(
        textSmUnderline,
        other.textSmUnderline,
        t,
      )!,
      textXs: TextStyle.lerp(textXs, other.textXs, t)!,
      textXsMedium: TextStyle.lerp(textXsMedium, other.textXsMedium, t)!,
      textXsSemibold: TextStyle.lerp(textXsSemibold, other.textXsSemibold, t)!,
      textXsBold: TextStyle.lerp(textXsBold, other.textXsBold, t)!,
      // Legacy compatibility styles
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      codeLarge: TextStyle.lerp(codeLarge, other.codeLarge, t)!,
      codeMedium: TextStyle.lerp(codeMedium, other.codeMedium, t)!,
      codeSmall: TextStyle.lerp(codeSmall, other.codeSmall, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
    );
  }
}

/// Extension on BuildContext to easily access text styles
extension UnpingTextStyleContext on BuildContext {
  UnpingTextStyleExtension get UiTextStyles =>
      Theme.of(this).extension<UnpingTextStyleExtension>() ??
      UnpingTextStyleExtension.standard;
}
