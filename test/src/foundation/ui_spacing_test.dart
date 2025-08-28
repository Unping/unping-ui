import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/foundation/ui_spacing.dart';

void main() {
  group('UiSpacingExtension', () {
    test('should have default light and dark instances', () {
      expect(UiSpacingExtension.light, isA<UiSpacingExtension>());
      expect(UiSpacingExtension.dark, isA<UiSpacingExtension>());
    });

    test('copyWith should return new instance', () {
      const original = UiSpacingExtension();
      final copy = original.copyWith();

      expect(copy, isA<UiSpacingExtension>());
      // For const value objects, copyWith might return the same instance if no changes
      expect(copy, equals(original));
    });

    test('lerp should return UiSpacingExtension', () {
      const extension1 = UiSpacingExtension();
      const extension2 = UiSpacingExtension();

      final result = extension1.lerp(extension2, 0.5);
      expect(result, isA<UiSpacingExtension>());

      // Test lerp with null
      final resultWithNull = extension1.lerp(null, 0.5);
      expect(resultWithNull, isA<UiSpacingExtension>());
    });
  });

  group('UiSpacingContext extension', () {
    testWidgets(
        'should provide access to spacing extension through BuildContext',
        (WidgetTester tester) async {
      late UiSpacingExtension spacing;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [UiSpacingExtension.light],
          ),
          home: Builder(
            builder: (context) {
              spacing = context.UiSpacing;
              return Container();
            },
          ),
        ),
      );

      expect(spacing, isA<UiSpacingExtension>());
    });

    testWidgets('should fallback to light extension when not in theme',
        (WidgetTester tester) async {
      late UiSpacingExtension spacing;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              spacing = context.UiSpacing;
              return Container();
            },
          ),
        ),
      );

      expect(spacing, UiSpacingExtension.light);
    });
  });
}
