// test/src/components/input/input_types_test.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('InputSizeTokens.of', () {
    testWidgets('returns spec for sm', (tester) async {
      late InputSizeSpec spec;
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (context) {
            spec = InputSizeTokens.of(context, InputSize.sm);
            return Container();
          },
        ),
      ));
      expect(spec.minHeight, 36);
      expect(spec.padding,
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
    });

    testWidgets('returns spec for md', (tester) async {
      late InputSizeSpec spec;
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (context) {
            spec = InputSizeTokens.of(context, InputSize.md);
            return Container();
          },
        ),
      ));
      expect(spec.minHeight, 40);
    });

    testWidgets('returns spec for lg', (tester) async {
      late InputSizeSpec spec;
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (context) {
            spec = InputSizeTokens.of(context, InputSize.lg);
            return Container();
          },
        ),
      ));
      expect(spec.minHeight, 48);
    });
  });

  group('Enums', () {
    test('InputSize has 3 values', () {
      expect(InputSize.values.length, 3);
      expect(InputSize.sm, isNotNull);
      expect(InputSize.md, isNotNull);
      expect(InputSize.lg, isNotNull);
    });

    test('InputState has 4 values', () {
      expect(InputState.values.length, 4);
      expect(InputState.normal, isNotNull);
      expect(InputState.focused, isNotNull);
      expect(InputState.disabled, isNotNull);
      expect(InputState.error, isNotNull);
    });

    test('PasswordStrength has 3 values', () {
      expect(PasswordStrength.values.length, 3);
      expect(PasswordStrength.weak, isNotNull);
      expect(PasswordStrength.medium, isNotNull);
      expect(PasswordStrength.strong, isNotNull);
    });
  });

  group('PasswordStrengthColors', () {
    test('constructs with required colors', () {
      const colors = PasswordStrengthColors(
        weak: Color(0xFF0000FF),
        medium: Color(0xFF00FF00),
        strong: Color(0xFFFF0000),
      );
      expect(colors.weak, const Color(0xFF0000FF));
      expect(colors.medium, const Color(0xFF00FF00));
      expect(colors.strong, const Color(0xFFFF0000));
    });
  });
}
