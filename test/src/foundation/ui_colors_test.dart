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
    testWidgets('should provide light theme colors', (
      WidgetTester tester,
    ) async {
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
      final modified = original.copyWith(textDisabled: const Color(0xFF123456));

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
    testWidgets(
      'should provide access to color extension through BuildContext',
      (WidgetTester tester) async {
        late UnpingColorExtension colors;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(extensions: [UnpingColorExtension.light]),
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
      },
    );
  });

  group('getColorName function', () {
    test('should return correct names for neutral colors', () {
      expect(UiColors.getColorName(UiColors.neutral800), 'Neutral 800');
      expect(UiColors.getColorName(UiColors.neutral100), 'Neutral 100');
      expect(UiColors.getColorName(UiColors.neutral300), 'Neutral 300');
      expect(UiColors.getColorName(UiColors.neutral400), 'Neutral 400');
    });

    test('should return correct names for primary colors', () {
      expect(UiColors.getColorName(UiColors.primary600), 'Primary 600');
      expect(UiColors.getColorName(UiColors.primary500), 'Primary 500');
      expect(UiColors.getColorName(UiColors.primary400), 'Primary 400');
      expect(UiColors.getColorName(UiColors.primary300), 'Primary 300');
    });

    test('should return correct names for success colors', () {
      expect(UiColors.getColorName(UiColors.success600), 'Success 600');
      expect(UiColors.getColorName(UiColors.success500), 'Success 500');
      expect(UiColors.getColorName(UiColors.success400), 'Success 400');
      expect(UiColors.getColorName(UiColors.success300), 'Success 300');
    });

    test('should return correct names for warning colors', () {
      expect(UiColors.getColorName(UiColors.warning600), 'Warning 600');
      expect(UiColors.getColorName(UiColors.warning500), 'Warning 500');
      expect(UiColors.getColorName(UiColors.warning400), 'Warning 400');
      expect(UiColors.getColorName(UiColors.warning300), 'Warning 300');
    });

    test('should return correct names for error colors', () {
      expect(UiColors.getColorName(UiColors.error600), 'Error 600');
      expect(UiColors.getColorName(UiColors.error500), 'Error 500');
      expect(UiColors.getColorName(UiColors.error400), 'Error 400');
      expect(UiColors.getColorName(UiColors.error300), 'Error 300');
    });

    test('should return correct names for semantic colors', () {
      expect(UiColors.getColorName(UiColors.onPrimary), 'On Primary');
      // Note: background is the same color as onPrimary (both white),
      // so it will return 'On Primary' since that's checked first
      expect(UiColors.getColorName(UiColors.background), 'On Primary');
    });

    test('should return "Custom Color" for unknown colors', () {
      const customColor = Color(0xFF123456);
      expect(UiColors.getColorName(customColor), 'Custom Color');
    });

    test('should handle semantic color aliases correctly', () {
      // Since UiColors.primary points to primary600, it should return 'Primary 600'
      expect(UiColors.getColorName(UiColors.primary), 'Primary 600');

      // Since UiColors.warning points to warning500, it should return 'Warning 500'
      expect(UiColors.getColorName(UiColors.warning), 'Warning 500');

      // Since UiColors.error points to error600, it should return 'Error 600'
      expect(UiColors.getColorName(UiColors.error), 'Error 600');

      // Since UiColors.success points to success600, it should return 'Success 600'
      expect(UiColors.getColorName(UiColors.success), 'Success 600');
    });
    test('should be case-sensitive and exact match', () {
      // Test that it returns exact string matches
      expect(UiColors.getColorName(UiColors.primary600), equals('Primary 600'));
      expect(UiColors.getColorName(UiColors.neutral800), equals('Neutral 800'));

      // Ensure the function doesn't return partial matches or variations
      expect(UiColors.getColorName(UiColors.primary600), isNot('primary 600'));
      expect(UiColors.getColorName(UiColors.primary600), isNot('Primary600'));
    });
  });
}
