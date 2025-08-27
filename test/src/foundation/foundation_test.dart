import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// Test that all foundation exports are available
import 'package:unping_ui/src/foundation/foundation.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Disable font fallbacks to avoid network requests
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Foundation Library Exports', () {
    test('should export UiColors class', () {
      expect(UiColors.primary, isA<Color>());
      expect(UiColors.neutral900, isA<Color>());
      expect(UiColors.success600, isA<Color>());
      expect(UiColors.warning500, isA<Color>());
      expect(UiColors.error600, isA<Color>());
    });

    test('should export UiSpacing class', () {
      expect(UiSpacing.zero, 0.0);
      expect(UiSpacing.m, 16.0);
      expect(UiSpacing.xl, 32.0);
      expect(UiSpacing.spacing1, 4.0);
      expect(UiSpacing.spacing16, 64.0);
    });

    test('should export UiRadius class', () {
      expect(UiRadius.none, 0.0);
      expect(UiRadius.md, 12.0);
      expect(UiRadius.xl, 28.0);
      expect(UiRadius.allMd, isA<BorderRadius>());
      expect(UiRadius.topLg, isA<BorderRadius>());
    });

    test('should export UiTextStyles font weights', () {
      expect(UiTextStyles.regular, FontWeight.w400);
      expect(UiTextStyles.bold, FontWeight.w700);
      expect(UiTextStyles.medium, FontWeight.w500);
      expect(UiTextStyles.semiBold, FontWeight.w600);
    });

    test('should export UiTheme class methods', () {
      expect(UiTheme.lightTheme, isA<Function>());
      expect(UiTheme.darkTheme, isA<Function>());
    });

    test('should export theme extensions classes', () {
      expect(UnpingColorExtension.light, isA<UnpingColorExtension>());
      expect(UnpingColorExtension.dark, isA<UnpingColorExtension>());
      expect(UiSpacingExtension.light, isA<UiSpacingExtension>());
      expect(UiRadiusExtension.light, isA<UiRadiusExtension>());
      expect(
          UnpingTextStyleExtension.standard, isA<UnpingTextStyleExtension>());
    });
  });
}
