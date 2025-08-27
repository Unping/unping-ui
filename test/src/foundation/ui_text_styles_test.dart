import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unping_ui/src/foundation/ui_text_styles.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Disable font fallbacks to avoid network requests
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('UiTextStyles', () {
    group('Legacy Compatibility Styles', () {
      test('should have correct legacy aliases', () {
        expect(UiTextStyles.displayLarge, UiTextStyles.display2xl);
        expect(UiTextStyles.displayMedium, UiTextStyles.displayXl);
        expect(UiTextStyles.displaySmall, UiTextStyles.displayLg);
        expect(UiTextStyles.headlineLarge, UiTextStyles.displayMd);
        expect(UiTextStyles.headlineMedium, UiTextStyles.displaySm);
        expect(UiTextStyles.headlineSmall, UiTextStyles.displayXs);
        expect(UiTextStyles.titleLarge, UiTextStyles.textXl);
        expect(UiTextStyles.titleMedium, UiTextStyles.textMd);
        expect(UiTextStyles.titleSmall, UiTextStyles.textSm);
        expect(UiTextStyles.bodyLarge, UiTextStyles.textMd);
        expect(UiTextStyles.bodyMedium, UiTextStyles.textSm);
        expect(UiTextStyles.bodySmall, UiTextStyles.textXs);
        expect(UiTextStyles.labelLarge, UiTextStyles.textSm);
        expect(UiTextStyles.labelMedium, UiTextStyles.textXs);
        expect(UiTextStyles.labelSmall, UiTextStyles.textXs);
      });
    });
  });

  group('UnpingTextStyleExtension', () {
    test('should create extension with all text styles', () {
      final extension = UnpingTextStyleExtension();

      expect(extension.display2xl, UiTextStyles.display2xl);
      expect(extension.display2xlMedium, UiTextStyles.display2xlMedium);
      expect(extension.display2xlSemibold, UiTextStyles.display2xlSemibold);
      expect(extension.display2xlBold, UiTextStyles.display2xlBold);

      expect(extension.displayXl, UiTextStyles.displayXl);
      expect(extension.displayXlMedium, UiTextStyles.displayXlMedium);
      expect(extension.displayXlSemibold, UiTextStyles.displayXlSemibold);
      expect(extension.displayXlBold, UiTextStyles.displayXlBold);

      expect(extension.displayLg, UiTextStyles.displayLg);
      expect(extension.displayLgMedium, UiTextStyles.displayLgMedium);
      expect(extension.displayLgSemibold, UiTextStyles.displayLgSemibold);
      expect(extension.displayLgBold, UiTextStyles.displayLgBold);

      expect(extension.displayMd, UiTextStyles.displayMd);
      expect(extension.displayMdMedium, UiTextStyles.displayMdMedium);
      expect(extension.displayMdSemibold, UiTextStyles.displayMdSemibold);
      expect(extension.displayMdBold, UiTextStyles.displayMdBold);

      expect(extension.displaySm, UiTextStyles.displaySm);
      expect(extension.displaySmMedium, UiTextStyles.displaySmMedium);
      expect(extension.displaySmSemibold, UiTextStyles.displaySmSemibold);
      expect(extension.displaySmBold, UiTextStyles.displaySmBold);

      expect(extension.displayXs, UiTextStyles.displayXs);
      expect(extension.displayXsMedium, UiTextStyles.displayXsMedium);
      expect(extension.displayXsSemibold, UiTextStyles.displayXsSemibold);
      expect(extension.displayXsBold, UiTextStyles.displayXsBold);

      expect(extension.textXl, UiTextStyles.textXl);
      expect(extension.textXlMedium, UiTextStyles.textXlMedium);
      expect(extension.textXlSemibold, UiTextStyles.textXlSemibold);
      expect(extension.textXlBold, UiTextStyles.textXlBold);

      expect(extension.textLg, UiTextStyles.textLg);
      expect(extension.textLgMedium, UiTextStyles.textLgMedium);
      expect(extension.textLgSemibold, UiTextStyles.textLgSemibold);
      expect(extension.textLgBold, UiTextStyles.textLgBold);

      expect(extension.textMd, UiTextStyles.textMd);
      expect(extension.textMdMedium, UiTextStyles.textMdMedium);
      expect(extension.textMdSemibold, UiTextStyles.textMdSemibold);
      expect(extension.textMdBold, UiTextStyles.textMdBold);

      expect(extension.textSm, UiTextStyles.textSm);
      expect(extension.textSmMedium, UiTextStyles.textSmMedium);
      expect(extension.textSmSemibold, UiTextStyles.textSmSemibold);
      expect(extension.textSmBold, UiTextStyles.textSmBold);
      expect(extension.textSmUnderline, UiTextStyles.textSmUnderline);

      expect(extension.textXs, UiTextStyles.textXs);
      expect(extension.textXsMedium, UiTextStyles.textXsMedium);
      expect(extension.textXsSemibold, UiTextStyles.textXsSemibold);
      expect(extension.textXsBold, UiTextStyles.textXsBold);
    });

    test('should have standard static instance', () {
      expect(
          UnpingTextStyleExtension.standard, isA<UnpingTextStyleExtension>());
    });

    test('should support custom text styles in constructor', () {
      final customStyle = UiTextStyles.textMd.copyWith(color: Colors.red);
      final extension = UnpingTextStyleExtension(
        textMd: customStyle,
      );

      expect(extension.textMd, customStyle);
      expect(extension.textSm, UiTextStyles.textSm); // should use default
    });

    test('copyWith should work correctly', () {
      final original = UnpingTextStyleExtension();
      final customStyle = UiTextStyles.textMd.copyWith(color: Colors.blue);
      final modified = original.copyWith(textMd: customStyle);

      expect(modified.textMd, customStyle);
      expect(modified.textSm, original.textSm); // unchanged
    });

    test('copyWith should handle all textMd parameters including textMdBold',
        () {
      final original = UnpingTextStyleExtension();
      final customTextMd = UiTextStyles.textMd.copyWith(color: Colors.red);
      final customTextMdMedium =
          UiTextStyles.textMdMedium.copyWith(color: Colors.green);
      final customTextMdSemibold =
          UiTextStyles.textMdSemibold.copyWith(color: Colors.blue);
      final customTextMdBold =
          UiTextStyles.textMdBold.copyWith(color: Colors.yellow);

      final modified = original.copyWith(
        textMd: customTextMd,
        textMdMedium: customTextMdMedium,
        textMdSemibold: customTextMdSemibold,
        textMdBold: customTextMdBold,
      );

      expect(modified.textMd, customTextMd);
      expect(modified.textMdMedium, customTextMdMedium);
      expect(modified.textMdSemibold, customTextMdSemibold);
      expect(modified.textMdBold, customTextMdBold);
      expect(modified.textSm, original.textSm); // unchanged
    });

    test('lerp should work correctly', () {
      final extension1 = UnpingTextStyleExtension();
      final extension2 = UnpingTextStyleExtension();

      final result = extension1.lerp(extension2, 0.5);
      expect(result, isA<UnpingTextStyleExtension>());

      // Test lerp with null
      final resultWithNull = extension1.lerp(null, 0.5);
      expect(resultWithNull, extension1);
    });
  });

  group('UnpingTextStyleContext extension', () {
    testWidgets(
        'should provide access to text style extension through BuildContext',
        (WidgetTester tester) async {
      late UnpingTextStyleExtension textStyles;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [UnpingTextStyleExtension.standard],
          ),
          home: Builder(
            builder: (context) {
              textStyles = context.UiTextStyles;
              return Container();
            },
          ),
        ),
      );

      expect(textStyles, isA<UnpingTextStyleExtension>());
      expect(textStyles.textMd.fontSize, 16);
    });

    testWidgets('should fallback to standard extension when not in theme',
        (WidgetTester tester) async {
      late UnpingTextStyleExtension textStyles;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              textStyles = context.UiTextStyles;
              return Container();
            },
          ),
        ),
      );

      expect(textStyles, UnpingTextStyleExtension.standard);
    });
  });
}
