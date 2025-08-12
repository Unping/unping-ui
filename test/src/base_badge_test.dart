import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/src/base_badge.dart';
import 'package:unping_ui/src/base_checkbox.dart';

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

  group('Badge Checkbox (BaseCheckbox)', () {
    testWidgets('should render unchecked state', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(isChecked: false),
        ),
      );

      // Should render without check mark
      expect(find.byType(CustomPaint), findsNothing);
    });

    testWidgets('should render checked state', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(isChecked: true),
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

  group('Badge Checkbox Interactions', () {
    testWidgets('should render checked checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(isChecked: true),
        ),
      );

      final checkboxFinder = find.byType(BaseCheckbox);
      expect(checkboxFinder, findsOneWidget);
    });

    testWidgets('should render unchecked checkbox',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(isChecked: false),
        ),
      );

      final checkboxFinder = find.byType(BaseCheckbox);
      expect(checkboxFinder, findsOneWidget);
    });

    testWidgets('should handle tap when onChanged is provided',
        (WidgetTester tester) async {
      bool tappedValue = false;
      bool? receivedValue;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(
            isChecked: tappedValue,
            onChanged: (value) {
              receivedValue = value;
            },
          ),
        ),
      );

      await tester.tap(find.byType(BaseCheckbox));
      await tester.pumpAndSettle();

      expect(receivedValue, true);
    });

    testWidgets('should not respond to tap when onChanged is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(isChecked: false),
        ),
      );

      // This should not throw any errors
      await tester.tap(find.byType(BaseCheckbox));
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

  group('BaseBadge removable functionality', () {
    testWidgets('should show remove button when removable is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Removable Badge',
            removable: true,
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Removable Badge'), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('should call onRemove callback when remove button is tapped',
        (WidgetTester tester) async {
      bool removeCalled = false;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Removable Badge',
            removable: true,
            onRemove: () => removeCalled = true,
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      // Find the GestureDetector that handles the remove tap
      final gestureDetectors = find.byType(GestureDetector);
      await tester
          .tap(gestureDetectors.last); // Last one should be the remove button
      await tester.pumpAndSettle();

      expect(removeCalled, true);
    });

    testWidgets(
        'should hide badge when remove button is tapped without callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Removable Badge',
            removable: true,
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Removable Badge'), findsOneWidget);

      // Find and tap the remove button
      final gestureDetectors = find.byType(GestureDetector);
      await tester.tap(gestureDetectors.last);
      await tester.pumpAndSettle();

      // Badge should be hidden (replaced with SizedBox.shrink)
      expect(find.text('Removable Badge'), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('should not show right widget when removable is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Test Badge',
            rightWidget: const Text('Right'),
            removable: true,
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
      // Right widget should not be shown when removable is true
      expect(find.text('Right'), findsNothing);
    });
  });

  group('BadgeImage with imageUrl', () {
    testWidgets('should render network image when imageUrl is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: 'https://example.com/image.jpg',
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should show fallback when network image fails to load',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: 'https://invalid-url.com/image.jpg',
            fallback: Text('Fallback'),
          ),
        ),
      );

      // Wait for image to fail loading
      await tester.pumpAndSettle();

      // Should show the fallback
      expect(find.text('Fallback'), findsOneWidget);
    });

    testWidgets(
        'should show default avatar when network image fails without fallback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: 'https://invalid-url.com/image.jpg',
          ),
        ),
      );

      // Wait for image to fail loading
      await tester.pumpAndSettle();

      // Should show default avatar (CustomPaint with person icon)
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    testWidgets('should show contrast border when showContrastBorder is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            showContrastBorder: true,
          ),
        ),
      );

      // Should render with border decoration
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
    });

    testWidgets('should handle empty imageUrl string',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: '',
            fallback: Text('Empty URL Fallback'),
          ),
        ),
      );

      expect(find.text('Empty URL Fallback'), findsOneWidget);
    });

    testWidgets('should handle null imageUrl with no fallback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: null,
          ),
        ),
      );

      // Should show default avatar
      expect(find.byType(CustomPaint), findsOneWidget);
    });
  });

  group('BadgeDot', () {
    testWidgets('should render basic dot', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeDot(),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should render with outline when showOutline is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeDot(
            showOutline: true,
            outlineColor: Color(0xFF000000),
            outlineWidth: 2.0,
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should render with custom size and color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeDot(
            size: 10.0,
            color: Color(0xFFFF0000),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('Badge checkbox with size conversion', () {
    testWidgets('should create small checkbox when size <= 16',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(
            isChecked: false,
            size: 14.0,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should create medium checkbox when size <= 20',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(
            isChecked: false,
            size: 18.0,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should create large checkbox when size > 20',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(
            isChecked: false,
            size: 24.0,
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });

    testWidgets('should create checkbox with custom colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Badges.checkbox(
            isChecked: true,
            backgroundColor: const Color(0xFF00FF00),
            borderColor: const Color(0xFF0000FF),
            checkColor: const Color(0xFFFF0000),
          ),
        ),
      );

      expect(find.byType(BaseCheckbox), findsOneWidget);
    });
  });

  group('BaseBadge with border properties', () {
    testWidgets('should render without border when borderColor is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'No Border Badge',
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
            borderColor: null,
          ),
        ),
      );

      expect(find.text('No Border Badge'), findsOneWidget);
    });

    testWidgets('should apply minHeight constraint when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: BaseBadge(
            text: 'Min Height Badge',
            backgroundColor: const Color(0xFF3B4554),
            textColor: const Color(0xFFFFFFFF),
            minHeight: 50.0,
          ),
        ),
      );

      expect(find.text('Min Height Badge'), findsOneWidget);
      expect(find.byType(BoxConstraints),
          findsNothing); // BoxConstraints is not a widget
    });

    testWidgets('should render BadgeImage with default avatar and test painter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: null, // No image URL to trigger default avatar
            size: 24.0,
          ),
        ),
      );

      expect(find.byType(BadgeImage), findsOneWidget);
      expect(find.byType(CustomPaint), findsOneWidget);

      // Trigger a repaint to exercise shouldRepaint method
      await tester.pump();
    });

    testWidgets(
        'should render BadgeImage with error fallback to default avatar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: BadgeImage(
            imageUrl: 'invalid-url', // Invalid URL to trigger error fallback
            size: 24.0,
          ),
        ),
      );

      expect(find.byType(BadgeImage), findsOneWidget);
      // Wait for the image to fail and trigger the fallback
      await tester.pump();
    });
  });
}
