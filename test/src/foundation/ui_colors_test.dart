import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/foundation/ui_colors.dart';

void main() {
  group('UiColors', () {
    group('Primary Colors', () {
      test('should have primary color alias pointing to primary600', () {
        expect(UiColors.primary, UiColors.primary600);
      });
    });

    group('Warning Colors', () {
      test('should have warning color alias pointing to warning500', () {
        expect(UiColors.warning, UiColors.warning500);
      });
    });

    group('Error Colors', () {
      test('should have error color alias pointing to error600', () {
        expect(UiColors.error, UiColors.error600);
      });
    });

    group('Semantic Colors', () {
      test('should have correct semantic color values', () {
        expect(UiColors.secondary, UiColors.neutral600);
        expect(UiColors.surface, UiColors.neutral25);
        expect(UiColors.background, const Color(0xFFFFFFFF));
        expect(UiColors.onPrimary, const Color(0xFFFFFFFF));
        expect(UiColors.onSecondary, const Color(0xFFFFFFFF));
        expect(UiColors.onSurface, UiColors.neutral900);
        expect(UiColors.onBackground, UiColors.neutral900);
      });
    });

    group('Border and UI Colors', () {
      test('should have correct border and UI color values', () {
        expect(UiColors.border, UiColors.neutral200);
        expect(UiColors.divider, UiColors.neutral100);
        expect(UiColors.outline, UiColors.neutral300);
      });
    });

    group('Text Colors', () {
      test('should have correct text color values', () {
        expect(UiColors.textPrimary, UiColors.neutral900);
        expect(UiColors.textSecondary, UiColors.neutral600);
        expect(UiColors.textTertiary, UiColors.neutral500);
        expect(UiColors.textDisabled, UiColors.neutral400);
      });
    });
  });

  group('UnpingColorExtension', () {
    testWidgets('should provide light theme colors',
        (WidgetTester tester) async {
      const colorExtension = UnpingColorExtension.light;

      expect(colorExtension.primary25, UiColors.primary25);
      expect(colorExtension.primary50, UiColors.primary50);
      expect(colorExtension.neutral25, UiColors.neutral25);
      expect(colorExtension.success25, UiColors.success25);
      expect(colorExtension.warning25, UiColors.warning25);
      expect(colorExtension.error25, UiColors.error25);
    });

    test('should have convenience getters', () {
      const colorExtension = UnpingColorExtension.light;

      expect(colorExtension.primary, colorExtension.primary600);
      expect(colorExtension.secondary, colorExtension.neutral600);
      expect(colorExtension.surface, colorExtension.neutral25);
      expect(colorExtension.background, const Color(0xFFFFFFFF));
      expect(colorExtension.onPrimary, const Color(0xFFFFFFFF));
      expect(colorExtension.onSecondary, const Color(0xFFFFFFFF));
      expect(colorExtension.onSurface, colorExtension.neutral900);
      expect(colorExtension.onBackground, colorExtension.neutral900);
      expect(colorExtension.success, colorExtension.success600);
      expect(colorExtension.warning, colorExtension.warning500);
      expect(colorExtension.error, colorExtension.error600);
    });

    test('copyWith should work correctly', () {
      const original = UnpingColorExtension.light;
      final modified = original.copyWith(
        textDisabled: const Color(0xFF123456),
      );

      expect(modified.textDisabled, const Color(0xFF123456));
      expect(modified.textPrimary, original.textPrimary);
    });

    test('lerp should work correctly', () {
      const colorExtension = UnpingColorExtension.light;
      final result = colorExtension.lerp(colorExtension, 0.5);

      expect(result, isA<UnpingColorExtension>());
    });
  });

  group('UnpingColorContext extension', () {
    testWidgets('should provide access to color extension through BuildContext',
        (WidgetTester tester) async {
      late UnpingColorExtension colors;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [UnpingColorExtension.light],
          ),
          home: Builder(
            builder: (context) {
              colors = context.UiColors;
              return Container();
            },
          ),
        ),
      );

      expect(colors, isA<UnpingColorExtension>());
      expect(colors.primary, UiColors.primary600);
    });
  });
}
