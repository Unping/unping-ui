import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/foundation/ui_radius.dart';

void main() {
  group('UiRadiusExtension', () {
    test('should have default values', () {
      const extension = UiRadiusExtension();

      expect(extension.none, UiRadius.none);
      expect(extension.xs, UiRadius.xs);
      expect(extension.sm, UiRadius.sm);
      expect(extension.md, UiRadius.md);
      expect(extension.lg, UiRadius.lg);
      expect(extension.xl, UiRadius.xl);
      expect(extension.xxl, UiRadius.xxl);
      expect(extension.full, UiRadius.full);
    });

    test('should have correct light and dark static instances', () {
      expect(UiRadiusExtension.light.none, 0.0);
      expect(UiRadiusExtension.dark.none, 0.0);
      expect(UiRadiusExtension.light.md, 12.0);
      expect(UiRadiusExtension.dark.md, 12.0);
    });

    test('copyWith should work correctly', () {
      const original = UiRadiusExtension();
      final modified = original.copyWith(
        xs: 10.0,
        md: 20.0,
      ) as UiRadiusExtension;

      expect(modified.xs, 10.0);
      expect(modified.md, 20.0);
      expect(modified.sm, original.sm); // unchanged
      expect(modified.lg, original.lg); // unchanged
    });

    test('lerp should return correct extension', () {
      const extension1 = UiRadiusExtension();
      const extension2 = UiRadiusExtension();

      final result = extension1.lerp(extension2, 0.5);
      expect(result, isA<UiRadiusExtension>());

      // Test lerp with different type
      final resultWithNull = extension1.lerp(null, 0.5);
      expect(resultWithNull, extension1);
    });
  });

  group('UiRadiusContext extension', () {
    testWidgets(
        'should provide access to radius extension through BuildContext',
        (WidgetTester tester) async {
      late UiRadiusExtension radius;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [UiRadiusExtension.light],
          ),
          home: Builder(
            builder: (context) {
              radius = context.UiRadius;
              return Container();
            },
          ),
        ),
      );

      expect(radius, isA<UiRadiusExtension>());
      expect(radius.md, 12.0);
    });

    testWidgets('should fallback to light extension when not in theme',
        (WidgetTester tester) async {
      late UiRadiusExtension radius;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              radius = context.UiRadius;
              return Container();
            },
          ),
        ),
      );

      expect(radius, UiRadiusExtension.light);
    });
  });
}
