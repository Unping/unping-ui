import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/base_badge.dart';

void main() {
  group('BaseBadge', () {
    testWidgets('should render with text only', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Test Badge',
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
    });

    testWidgets('should render with left widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Test Badge',
            leftWidget1: const Text('Left1'),
            leftWidget2: const Text('Left2'),
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
      expect(find.text('Left1'), findsOneWidget);
      expect(find.text('Left2'), findsOneWidget);
    });

    testWidgets('should render with right widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Test Badge',
            rightWidget: const Text('Right'),
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });

    testWidgets('should apply different sizes correctly',
        (WidgetTester tester) async {
      for (final size in BadgeSize.values) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: BaseBadge(
              text: 'Test Badge',
              size: size,
              backgroundColor: const Color(0xFF3B4554),
              textColor: const Color(0xFFFFFFFF),
            ),
          ),
        );

        expect(find.text('Test Badge'), findsOneWidget);
      }
    });

    testWidgets('should apply custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Test Badge',
            backgroundColor: const Color(0xFF10B981),
            textColor: const Color(0xFFFFFFFF),
            borderColor: const Color(0xFF000000),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
    });
  });

  group('BadgeCheckbox', () {
    testWidgets('should render unchecked state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(isChecked: false),
        ),
      );

      // Should render without check mark
      expect(find.byType(CustomPaint), findsNothing);
    });

    testWidgets('should render checked state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(isChecked: true),
        ),
      );

      // Should render with check mark
      expect(find.byType(CustomPaint), findsOneWidget);
    });
  });

  group('BadgeImage', () {
    testWidgets('should render with fallback when no image',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(),
        ),
      );

      // Should render the fallback container
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should render with custom fallback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            fallback: Text('FB'),
          ),
        ),
      );

      expect(find.text('FB'), findsOneWidget);
    });
  });

  group('BadgeCheckbox', () {
    testWidgets('should render checked checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(isChecked: true),
        ),
      );

      final checkboxFinder = find.byType(BadgeCheckbox);
      expect(checkboxFinder, findsOneWidget);
    });

    testWidgets('should render unchecked checkbox',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(isChecked: false),
        ),
      );

      final checkboxFinder = find.byType(BadgeCheckbox);
      expect(checkboxFinder, findsOneWidget);
    });

    testWidgets('should handle tap when onChanged is provided',
        (WidgetTester tester) async {
      bool tappedValue = false;
      bool? receivedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(
            isChecked: tappedValue,
            onChanged: (value) {
              receivedValue = value;
            },
          ),
        ),
      );

      await tester.tap(find.byType(BadgeCheckbox));
      await tester.pumpAndSettle();

      expect(receivedValue, true);
    });

    testWidgets('should not respond to tap when onChanged is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCheckbox(isChecked: false),
        ),
      );

      // This should not throw any errors
      await tester.tap(find.byType(BadgeCheckbox));
      await tester.pumpAndSettle();
    });
  });

  group('BadgeCount', () {
    testWidgets('should render count number', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCount(count: 5),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should render max count with plus sign',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeCount(count: 150, maxCount: 99),
        ),
      );

      expect(find.text('99+'), findsOneWidget);
    });
  });

  group('Badges factory methods', () {
    testWidgets('should create dark badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.badge(text: 'Dark Badge'),
        ),
      );

      expect(find.text('Dark Badge'), findsOneWidget);
    });
  });
}
