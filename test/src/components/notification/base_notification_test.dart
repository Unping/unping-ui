import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('BaseNotification', () {
    testWidgets('displays message correctly', (WidgetTester tester) async {
      const message = 'Test notification message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: message,
            ),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
    });

    testWidgets('displays title and message when both provided',
        (WidgetTester tester) async {
      const title = 'Test Title';
      const message = 'Test notification message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              title: title,
              message: message,
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(message), findsOneWidget);
    });

    testWidgets('shows default icon for each notification type',
        (WidgetTester tester) async {
      final types = [
        NotificationType.success,
        NotificationType.error,
        NotificationType.warning,
        NotificationType.info,
      ];

      for (final type in types) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseNotification(
                type: type,
                message: 'Test message',
              ),
            ),
          ),
        );

        // Verify an icon is present
        expect(find.byType(Icon), findsOneWidget);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('shows custom icon when provided', (WidgetTester tester) async {
      const customIcon = Icon(Icons.star, key: Key('custom-icon'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              icon: customIcon,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom-icon')), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('displays action buttons correctly',
        (WidgetTester tester) async {
      bool actionPressed = false;

      final actions = [
        NotificationAction(
          label: 'Action 1',
          onPressed: () => actionPressed = true,
        ),
        NotificationAction(
          label: 'Action 2',
          onPressed: () {},
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              actions: actions,
            ),
          ),
        ),
      );

      expect(find.text('Action 1'), findsOneWidget);
      expect(find.text('Action 2'), findsOneWidget);

      // Test action callback
      await tester.tap(find.text('Action 1'));
      await tester.pumpAndSettle();

      expect(actionPressed, isTrue);
    });

    testWidgets(
        'shows close button when dismissible and showCloseButton is true',
        (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              dismissible: true,
              showCloseButton: true,
              onDismiss: () => dismissed = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
    });

    testWidgets('hides close button when showCloseButton is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              dismissible: true,
              showCloseButton: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('applies correct colors for each notification type',
        (WidgetTester tester) async {
      final types = [
        NotificationType.success,
        NotificationType.error,
        NotificationType.warning,
        NotificationType.info,
      ];

      for (final type in types) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseNotification(
                type: type,
                message: 'Test message',
              ),
            ),
          ),
        );

        // Find the container with decoration
        final container =
            tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;

        // Verify that the background color is set
        expect(decoration.color, isNotNull);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('uses custom colors when provided',
        (WidgetTester tester) async {
      const customBackground = Colors.purple;
      const customBorder = Colors.orange;
      const customText = Colors.green;
      const customIcon = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              backgroundColor: customBackground,
              borderColor: customBorder,
              textColor: customText,
              iconColor: customIcon,
            ),
          ),
        ),
      );

      // Find the container with decoration
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, equals(customBackground));
      expect((decoration.border as Border).top.color, equals(customBorder));
    });

    testWidgets('handles custom content correctly',
        (WidgetTester tester) async {
      const customContent = Text('Custom content', key: Key('custom-content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'This should not appear',
              content: customContent,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom-content')), findsOneWidget);
      expect(find.text('Custom content'), findsOneWidget);
      expect(find.text('This should not appear'), findsNothing);
    });

    testWidgets('respects dismissible property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              dismissible: false,
              showCloseButton: true,
            ),
          ),
        ),
      );

      // Close button should not be shown when dismissible is false
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('applies elevation correctly', (WidgetTester tester) async {
      const elevation = 8.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              elevation: elevation,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.isNotEmpty, isTrue);
    });

    testWidgets('handles width and maxWidth constraints',
        (WidgetTester tester) async {
      const width = 300.0;
      const maxWidth = 400.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              width: width,
              maxWidth: maxWidth,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      // Check that the container has the expected constraints
      expect(container.constraints?.maxWidth, equals(maxWidth));
    });

    testWidgets('shows progress indicator when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              showProgress: true,
              timing: NotificationTiming(
                duration: const Duration(seconds: 2),
                showProgress: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('animation controller works correctly',
        (WidgetTester tester) async {
      late AnimationController controller;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return TickerMode(
                enabled: true,
                child: Builder(
                  builder: (context) {
                    controller = AnimationController(
                      duration: const Duration(milliseconds: 300),
                      vsync: tester,
                    );
                    return BaseNotification(
                      type: NotificationType.info,
                      message: 'Test message',
                      animationController: controller,
                    );
                  },
                ),
              );
            },
          ),
        ),
      );

      // Pump initial frame
      await tester.pump();

      // Start animation
      controller.forward();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));

      // Verify animation is in progress
      expect(controller.value, greaterThan(0.0));
      expect(controller.value, lessThan(1.0));

      // Complete animation
      await tester.pump(const Duration(milliseconds: 200));
      expect(controller.value, equals(1.0));

      controller.dispose();
    });
  });

  group('NotificationAction', () {
    testWidgets('different action styles work correctly',
        (WidgetTester tester) async {
      bool textPressed = false;
      bool filledPressed = false;
      bool outlinedPressed = false;

      final actions = [
        NotificationAction(
          label: 'Text Action',
          onPressed: () => textPressed = true,
          style: NotificationActionStyle.text,
        ),
        NotificationAction(
          label: 'Filled Action',
          onPressed: () => filledPressed = true,
          style: NotificationActionStyle.filled,
        ),
        NotificationAction(
          label: 'Outlined Action',
          onPressed: () => outlinedPressed = true,
          style: NotificationActionStyle.outlined,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseNotification(
              type: NotificationType.info,
              message: 'Test message',
              actions: actions,
            ),
          ),
        ),
      );

      // Test text button
      await tester.tap(find.text('Text Action'));
      await tester.pumpAndSettle();
      expect(textPressed, isTrue);

      // Test filled button
      await tester.tap(find.text('Filled Action'));
      await tester.pumpAndSettle();
      expect(filledPressed, isTrue);

      // Test outlined button
      await tester.tap(find.text('Outlined Action'));
      await tester.pumpAndSettle();
      expect(outlinedPressed, isTrue);
    });
  });

  group('NotificationTiming', () {
    test('has correct default values', () {
      const timing = NotificationTiming.toast;
      expect(timing.duration, equals(const Duration(seconds: 4)));
      expect(timing.showProgress, isTrue);

      const snackbarTiming = NotificationTiming.snackbar;
      expect(snackbarTiming.duration, equals(const Duration(seconds: 6)));
      expect(snackbarTiming.showProgress, isFalse);

      const alertTiming = NotificationTiming.alert;
      expect(alertTiming.duration, isNull);
      expect(alertTiming.showProgress, isFalse);
    });
  });

  group('NotificationTypes', () {
    test('notification types enum has correct values', () {
      expect(NotificationType.values.length, equals(4));
      expect(
          NotificationType.values.contains(NotificationType.success), isTrue);
      expect(NotificationType.values.contains(NotificationType.error), isTrue);
      expect(
          NotificationType.values.contains(NotificationType.warning), isTrue);
      expect(NotificationType.values.contains(NotificationType.info), isTrue);
    });

    test('toast position enum has correct values', () {
      expect(ToastPosition.values.length, equals(7));
      expect(ToastPosition.values.contains(ToastPosition.topCenter), isTrue);
      expect(ToastPosition.values.contains(ToastPosition.bottomCenter), isTrue);
      expect(ToastPosition.values.contains(ToastPosition.center), isTrue);
    });

    test('notification priority enum has correct values', () {
      expect(NotificationPriority.values.length, equals(4));
      expect(NotificationPriority.values.contains(NotificationPriority.low),
          isTrue);
      expect(NotificationPriority.values.contains(NotificationPriority.normal),
          isTrue);
      expect(NotificationPriority.values.contains(NotificationPriority.high),
          isTrue);
      expect(
          NotificationPriority.values.contains(NotificationPriority.critical),
          isTrue);
    });
  });
}
