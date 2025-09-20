import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unping_ui/src/foundation/ui_theme.dart';
import 'package:unping_ui/src/foundation/ui_colors.dart';
import 'package:unping_ui/src/foundation/ui_spacing.dart';
import 'package:unping_ui/src/foundation/ui_radius.dart';
import 'package:unping_ui/src/foundation/ui_text_styles.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Disable font fallbacks to avoid network requests
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('UiTheme', () {
    group('Light Theme', () {
      test('should create light theme with default colors', () {
        final theme = UiTheme.lightTheme();

        expect(theme.useMaterial3, false);
        expect(theme.colorScheme.brightness, Brightness.light);
        expect(theme.colorScheme.primary, UiColors.primary500);
        expect(theme.colorScheme.secondary, UiColors.primary600);
        expect(theme.colorScheme.surface, UiColors.neutral50);
        expect(theme.colorScheme.onSurface, UiColors.neutral900);
        expect(theme.colorScheme.error, UiColors.error500);
        expect(theme.colorScheme.onError, UiColors.neutral50);
        expect(theme.colorScheme.outline, UiColors.border);
      });

      test('should create light theme with custom primary color', () {
        const customPrimary = Color(0xFF123456);
        final theme = UiTheme.lightTheme(primaryColor: customPrimary);

        expect(theme.colorScheme.primary, customPrimary);
        expect(
          theme.colorScheme.secondary,
          UiColors.primary600,
        ); // should remain unchanged
      });

      test('should create light theme with custom background color', () {
        const customBackground = Color(0xFFFAFAFA);
        final theme = UiTheme.lightTheme(backgroundColor: customBackground);

        expect(theme.colorScheme.surface, customBackground);
        expect(
          theme.colorScheme.primary,
          UiColors.primary500,
        ); // should remain unchanged
      });

      test('should have correct text theme', () {
        final theme = UiTheme.lightTheme();

        // Compare the core properties instead of the entire TextStyle object
        // since theme text styles will have additional color and decoration properties
        expect(
          theme.textTheme.displayLarge?.fontSize,
          UiTextStyles.displayLarge.fontSize,
        );
        expect(
          theme.textTheme.displayLarge?.fontWeight,
          UiTextStyles.displayLarge.fontWeight,
        );
        expect(
          theme.textTheme.displayLarge?.fontFamily,
          UiTextStyles.displayLarge.fontFamily,
        );
        expect(
          theme.textTheme.displayLarge?.height,
          UiTextStyles.displayLarge.height,
        );
        expect(
          theme.textTheme.displayLarge?.letterSpacing,
          UiTextStyles.displayLarge.letterSpacing,
        );
        expect(theme.textTheme.displayLarge?.color, UiColors.neutral900);
        expect(theme.textTheme.displayLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.displayMedium?.fontSize,
          UiTextStyles.displayMedium.fontSize,
        );
        expect(
          theme.textTheme.displayMedium?.fontWeight,
          UiTextStyles.displayMedium.fontWeight,
        );
        expect(
          theme.textTheme.displayMedium?.fontFamily,
          UiTextStyles.displayMedium.fontFamily,
        );
        expect(theme.textTheme.displayMedium?.color, UiColors.neutral900);
        expect(theme.textTheme.displayMedium?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.displaySmall?.fontSize,
          UiTextStyles.displaySmall.fontSize,
        );
        expect(
          theme.textTheme.displaySmall?.fontWeight,
          UiTextStyles.displaySmall.fontWeight,
        );
        expect(
          theme.textTheme.displaySmall?.fontFamily,
          UiTextStyles.displaySmall.fontFamily,
        );
        expect(theme.textTheme.displaySmall?.color, UiColors.neutral900);
        expect(theme.textTheme.displaySmall?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.headlineLarge?.fontSize,
          UiTextStyles.headlineLarge.fontSize,
        );
        expect(
          theme.textTheme.headlineLarge?.fontWeight,
          UiTextStyles.headlineLarge.fontWeight,
        );
        expect(
          theme.textTheme.headlineLarge?.fontFamily,
          UiTextStyles.headlineLarge.fontFamily,
        );
        expect(theme.textTheme.headlineLarge?.color, UiColors.neutral900);
        expect(theme.textTheme.headlineLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.bodyLarge?.fontSize,
          UiTextStyles.bodyLarge.fontSize,
        );
        expect(
          theme.textTheme.bodyLarge?.fontWeight,
          UiTextStyles.bodyLarge.fontWeight,
        );
        expect(
          theme.textTheme.bodyLarge?.fontFamily,
          UiTextStyles.bodyLarge.fontFamily,
        );
        expect(theme.textTheme.bodyLarge?.color, UiColors.neutral900);
        expect(theme.textTheme.bodyLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.titleMedium?.fontSize,
          UiTextStyles.titleMedium.fontSize,
        );
        expect(
          theme.textTheme.titleMedium?.fontWeight,
          UiTextStyles.titleMedium.fontWeight,
        );
        expect(
          theme.textTheme.titleMedium?.fontFamily,
          UiTextStyles.titleMedium.fontFamily,
        );
        expect(theme.textTheme.titleMedium?.color, UiColors.neutral900);
        expect(theme.textTheme.titleMedium?.decoration, TextDecoration.none);
      });

      test('should have correct theme extensions', () {
        final theme = UiTheme.lightTheme();

        expect(
          theme.extension<UnpingColorExtension>(),
          isA<UnpingColorExtension>(),
        );
        expect(
          theme.extension<UiSpacingExtension>(),
          isA<UiSpacingExtension>(),
        );
        expect(theme.extension<UiRadiusExtension>(), isA<UiRadiusExtension>());
        expect(
          theme.extension<UnpingTextStyleExtension>(),
          isA<UnpingTextStyleExtension>(),
        );

        expect(
          theme.extension<UnpingColorExtension>(),
          UnpingColorExtension.light,
        );
        expect(theme.extension<UiSpacingExtension>(), UiSpacingExtension.light);
        expect(theme.extension<UiRadiusExtension>(), UiRadiusExtension.light);
        expect(
          theme.extension<UnpingTextStyleExtension>(),
          UnpingTextStyleExtension.standard,
        );
      });

      test('should have correct app bar theme', () {
        final theme = UiTheme.lightTheme();

        expect(theme.appBarTheme.elevation, 0);
        expect(theme.appBarTheme.backgroundColor, Colors.transparent);
      });

      test('should have correct elevated button theme', () {
        final theme = UiTheme.lightTheme();

        expect(theme.elevatedButtonTheme.style?.elevation?.resolve({}), 0);
        expect(
          theme.elevatedButtonTheme.style?.shape?.resolve({}),
          isA<RoundedRectangleBorder>(),
        );
      });

      test('should have correct outlined button theme', () {
        final theme = UiTheme.lightTheme();

        expect(
          theme.outlinedButtonTheme.style?.shape?.resolve({}),
          isA<RoundedRectangleBorder>(),
        );
      });

      test('should have correct input decoration theme', () {
        final theme = UiTheme.lightTheme();

        expect(theme.inputDecorationTheme.filled, true);
        expect(theme.inputDecorationTheme.fillColor, UiColors.neutral50);
        expect(theme.inputDecorationTheme.border, isA<OutlineInputBorder>());
        expect(
          theme.inputDecorationTheme.enabledBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.focusedBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.errorBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.focusedErrorBorder,
          isA<OutlineInputBorder>(),
        );
        expect(theme.inputDecorationTheme.contentPadding, UiSpacing.allM);
      });
    });

    group('Dark Theme', () {
      test('should create dark theme with default colors', () {
        final theme = UiTheme.darkTheme();

        expect(theme.useMaterial3, false);
        expect(theme.colorScheme.brightness, Brightness.dark);
        expect(theme.colorScheme.primary, UiColors.primary400);
        expect(theme.colorScheme.secondary, UiColors.primary500);
        expect(theme.colorScheme.surface, UiColors.neutral900);
        expect(theme.colorScheme.onSurface, UiColors.neutral50);
        expect(theme.colorScheme.error, UiColors.error500);
        expect(theme.colorScheme.onError, UiColors.neutral900);
        expect(theme.colorScheme.outline, UiColors.border);
      });

      test('should create dark theme with custom primary color', () {
        const customPrimary = Color(0xFF654321);
        final theme = UiTheme.darkTheme(primaryColor: customPrimary);

        expect(theme.colorScheme.primary, customPrimary);
        expect(
          theme.colorScheme.secondary,
          UiColors.primary500,
        ); // should remain unchanged
      });

      test('should create dark theme with custom background color', () {
        const customBackground = Color(0xFF111111);
        final theme = UiTheme.darkTheme(backgroundColor: customBackground);

        expect(theme.colorScheme.surface, customBackground);
        expect(
          theme.colorScheme.primary,
          UiColors.primary400,
        ); // should remain unchanged
      });

      test('should have correct text theme', () {
        final theme = UiTheme.darkTheme();

        // Compare the core properties instead of the entire TextStyle object
        // since theme text styles will have additional color and decoration properties
        expect(
          theme.textTheme.displayLarge?.fontSize,
          UiTextStyles.displayLarge.fontSize,
        );
        expect(
          theme.textTheme.displayLarge?.fontWeight,
          UiTextStyles.displayLarge.fontWeight,
        );
        expect(
          theme.textTheme.displayLarge?.fontFamily,
          UiTextStyles.displayLarge.fontFamily,
        );
        expect(
          theme.textTheme.displayLarge?.height,
          UiTextStyles.displayLarge.height,
        );
        expect(
          theme.textTheme.displayLarge?.letterSpacing,
          UiTextStyles.displayLarge.letterSpacing,
        );
        expect(theme.textTheme.displayLarge?.color, UiColors.neutral50);
        expect(theme.textTheme.displayLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.displayMedium?.fontSize,
          UiTextStyles.displayMedium.fontSize,
        );
        expect(
          theme.textTheme.displayMedium?.fontWeight,
          UiTextStyles.displayMedium.fontWeight,
        );
        expect(
          theme.textTheme.displayMedium?.fontFamily,
          UiTextStyles.displayMedium.fontFamily,
        );
        expect(theme.textTheme.displayMedium?.color, UiColors.neutral50);
        expect(theme.textTheme.displayMedium?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.displaySmall?.fontSize,
          UiTextStyles.displaySmall.fontSize,
        );
        expect(
          theme.textTheme.displaySmall?.fontWeight,
          UiTextStyles.displaySmall.fontWeight,
        );
        expect(
          theme.textTheme.displaySmall?.fontFamily,
          UiTextStyles.displaySmall.fontFamily,
        );
        expect(theme.textTheme.displaySmall?.color, UiColors.neutral50);
        expect(theme.textTheme.displaySmall?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.headlineLarge?.fontSize,
          UiTextStyles.headlineLarge.fontSize,
        );
        expect(
          theme.textTheme.headlineLarge?.fontWeight,
          UiTextStyles.headlineLarge.fontWeight,
        );
        expect(
          theme.textTheme.headlineLarge?.fontFamily,
          UiTextStyles.headlineLarge.fontFamily,
        );
        expect(theme.textTheme.headlineLarge?.color, UiColors.neutral50);
        expect(theme.textTheme.headlineLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.bodyLarge?.fontSize,
          UiTextStyles.bodyLarge.fontSize,
        );
        expect(
          theme.textTheme.bodyLarge?.fontWeight,
          UiTextStyles.bodyLarge.fontWeight,
        );
        expect(
          theme.textTheme.bodyLarge?.fontFamily,
          UiTextStyles.bodyLarge.fontFamily,
        );
        expect(theme.textTheme.bodyLarge?.color, UiColors.neutral50);
        expect(theme.textTheme.bodyLarge?.decoration, TextDecoration.none);

        expect(
          theme.textTheme.titleMedium?.fontSize,
          UiTextStyles.titleMedium.fontSize,
        );
        expect(
          theme.textTheme.titleMedium?.fontWeight,
          UiTextStyles.titleMedium.fontWeight,
        );
        expect(
          theme.textTheme.titleMedium?.fontFamily,
          UiTextStyles.titleMedium.fontFamily,
        );
        expect(theme.textTheme.titleMedium?.color, UiColors.neutral50);
        expect(theme.textTheme.titleMedium?.decoration, TextDecoration.none);
      });

      test('should have correct theme extensions', () {
        final theme = UiTheme.darkTheme();

        expect(
          theme.extension<UnpingColorExtension>(),
          isA<UnpingColorExtension>(),
        );
        expect(
          theme.extension<UiSpacingExtension>(),
          isA<UiSpacingExtension>(),
        );
        expect(theme.extension<UiRadiusExtension>(), isA<UiRadiusExtension>());
        expect(
          theme.extension<UnpingTextStyleExtension>(),
          isA<UnpingTextStyleExtension>(),
        );

        expect(
          theme.extension<UnpingColorExtension>(),
          UnpingColorExtension.dark,
        );
        expect(theme.extension<UiSpacingExtension>(), UiSpacingExtension.dark);
        expect(theme.extension<UiRadiusExtension>(), UiRadiusExtension.dark);
        expect(
          theme.extension<UnpingTextStyleExtension>(),
          UnpingTextStyleExtension.standard,
        );
      });

      test('should have correct input decoration theme for dark mode', () {
        final theme = UiTheme.darkTheme();

        expect(theme.inputDecorationTheme.filled, true);
        expect(theme.inputDecorationTheme.fillColor, UiColors.neutral800);
        expect(theme.inputDecorationTheme.border, isA<OutlineInputBorder>());
        expect(
          theme.inputDecorationTheme.enabledBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.focusedBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.errorBorder,
          isA<OutlineInputBorder>(),
        );
        expect(
          theme.inputDecorationTheme.focusedErrorBorder,
          isA<OutlineInputBorder>(),
        );
        expect(theme.inputDecorationTheme.contentPadding, UiSpacing.allM);
      });
    });
  });

  group('UiThemeContext extension', () {
    testWidgets(
      'should provide access to color extension through BuildContext in light theme',
      (WidgetTester tester) async {
        late UnpingColorExtension colors;

        await tester.pumpWidget(
          MaterialApp(
            theme: UiTheme.lightTheme(),
            home: Builder(
              builder: (context) {
                colors = UiThemeContext(context).UiColors;
                return Container();
              },
            ),
          ),
        );

        expect(colors, isA<UnpingColorExtension>());
        expect(colors.primary, UiColors.primary600);
      },
    );

    testWidgets(
      'should provide access to spacing extension through BuildContext',
      (WidgetTester tester) async {
        late UiSpacingExtension spacing;

        await tester.pumpWidget(
          MaterialApp(
            theme: UiTheme.lightTheme(),
            home: Builder(
              builder: (context) {
                spacing = UiThemeContext(context).UiSpacing;
                return Container();
              },
            ),
          ),
        );

        expect(spacing, isA<UiSpacingExtension>());
      },
    );

    testWidgets(
      'should provide access to radius extension through BuildContext',
      (WidgetTester tester) async {
        late UiRadiusExtension radius;

        await tester.pumpWidget(
          MaterialApp(
            theme: UiTheme.lightTheme(),
            home: Builder(
              builder: (context) {
                radius = UiThemeContext(context).UiRadius;
                return Container();
              },
            ),
          ),
        );

        expect(radius, isA<UiRadiusExtension>());
        expect(radius.md, 12.0);
      },
    );

    testWidgets(
      'should provide access to text style extension through BuildContext',
      (WidgetTester tester) async {
        late UnpingTextStyleExtension textStyles;

        await tester.pumpWidget(
          MaterialApp(
            theme: UiTheme.lightTheme(),
            home: Builder(
              builder: (context) {
                textStyles = UiThemeContext(context).UiTextStyles;
                return Container();
              },
            ),
          ),
        );

        expect(textStyles, isA<UnpingTextStyleExtension>());
        expect(textStyles.textMd.fontSize, 16);
      },
    );

    testWidgets('should correctly identify dark mode', (
      WidgetTester tester,
    ) async {
      bool? isDark;
      bool? isLight;

      await tester.pumpWidget(
        MaterialApp(
          theme: UiTheme.darkTheme(),
          home: Builder(
            builder: (context) {
              isDark = context.isDarkMode;
              isLight = context.isLightMode;
              return Container();
            },
          ),
        ),
      );

      expect(isDark, true);
      expect(isLight, false);
    });

    testWidgets('should correctly identify light mode', (
      WidgetTester tester,
    ) async {
      bool? isDark;
      bool? isLight;

      await tester.pumpWidget(
        MaterialApp(
          theme: UiTheme.lightTheme(),
          home: Builder(
            builder: (context) {
              isDark = context.isDarkMode;
              isLight = context.isLightMode;
              return Container();
            },
          ),
        ),
      );

      expect(isDark, false);
      expect(isLight, true);
    });

    testWidgets('should fallback to default extensions when not in theme', (
      WidgetTester tester,
    ) async {
      late UnpingColorExtension colors;
      late UiSpacingExtension spacing;
      late UiRadiusExtension radius;
      late UnpingTextStyleExtension textStyles;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              colors = UiThemeContext(context).UiColors;
              spacing = UiThemeContext(context).UiSpacing;
              radius = UiThemeContext(context).UiRadius;
              textStyles = UiThemeContext(context).UiTextStyles;
              return Container();
            },
          ),
        ),
      );

      expect(colors, UnpingColorExtension.light);
      expect(spacing, UiSpacingExtension.light);
      expect(radius, UiRadiusExtension.light);
      expect(textStyles, UnpingTextStyleExtension.standard);
    });
  });
}
