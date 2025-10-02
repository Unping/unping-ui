import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('ToastNotification', () {
    testWidgets('displays correctly with basic properties',
        (WidgetTester tester) async {
      const message = 'Test toast message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.success,
              message: message,
            ),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('factory methods create correct notification types',
        (WidgetTester tester) async {
      const message = 'Test message';

      // Test success factory
      final successToast = ToastNotification.success(message: message);
      expect(successToast.type, equals(NotificationType.success));

      // Test error factory
      final errorToast = ToastNotification.error(message: message);
      expect(errorToast.type, equals(NotificationType.error));

      // Test warning factory
      final warningToast = ToastNotification.warning(message: message);
      expect(warningToast.type, equals(NotificationType.warning));

      // Test info factory
      final infoToast = ToastNotification.info(message: message);
      expect(infoToast.type, equals(NotificationType.info));
    });

    testWidgets('positions toast correctly based on ToastPosition',
        (WidgetTester tester) async {
      final positions = [
        ToastPosition.topCenter,
        ToastPosition.topLeft,
        ToastPosition.topRight,
        ToastPosition.bottomCenter,
        ToastPosition.bottomLeft,
        ToastPosition.bottomRight,
        ToastPosition.center,
      ];

      for (final position in positions) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ToastNotification(
                type: NotificationType.info,
                message: 'Test message',
                position: position,
              ),
            ),
          ),
        );

        // Verify the toast is positioned correctly (Align widget should be present)
        expect(find.byType(Align), findsOneWidget);

        final align = tester.widget<Align>(find.byType(Align));
        expect(align.alignment, isNotNull);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('applies correct margins based on position',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              position: ToastPosition.topCenter,
            ),
          ),
        ),
      );

      // The toast should have margin applied
      final baseNotification = find.byType(BaseNotification);
      expect(baseNotification, findsOneWidget);
    });

    testWidgets('handles custom width and maxWidth',
        (WidgetTester tester) async {
      const width = 300.0;
      const maxWidth = 500.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              width: width,
              maxWidth: maxWidth,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.width, equals(width));
      expect(baseNotification.maxWidth, equals(maxWidth));
    });

    testWidgets('passes through custom styling properties',
        (WidgetTester tester) async {
      const backgroundColor = Colors.purple;
      const borderColor = Colors.orange;
      const textColor = Colors.white;
      const iconColor = Colors.yellow;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              textColor: textColor,
              iconColor: iconColor,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.backgroundColor, equals(backgroundColor));
      expect(baseNotification.borderColor, equals(borderColor));
      expect(baseNotification.textColor, equals(textColor));
      expect(baseNotification.iconColor, equals(iconColor));
    });

    testWidgets('handles actions correctly', (WidgetTester tester) async {
      bool action1Pressed = false;
      bool action2Pressed = false;

      final actions = [
        NotificationAction(
          label: 'Action 1',
          onPressed: () => action1Pressed = true,
        ),
        NotificationAction(
          label: 'Action 2',
          onPressed: () => action2Pressed = true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              actions: actions,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Action 1'));
      await tester.pumpAndSettle();
      expect(action1Pressed, isTrue);

      await tester.tap(find.text('Action 2'));
      await tester.pumpAndSettle();
      expect(action2Pressed, isTrue);
    });

    testWidgets('handles dismiss callback', (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              onDismiss: () => dismissed = true,
            ),
          ),
        ),
      );

      // Tap close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
    });

    testWidgets('swipe config is disabled for toasts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.swipeConfig.enabled, isFalse);
    });

    testWidgets('uses custom icon when provided', (WidgetTester tester) async {
      const customIcon = Icon(Icons.star, key: Key('custom-icon'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              icon: customIcon,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom-icon')), findsOneWidget);
    });

    testWidgets('uses custom content when provided',
        (WidgetTester tester) async {
      const customContent =
          Text('Custom toast content', key: Key('custom-content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'This should not appear',
              content: customContent,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom-content')), findsOneWidget);
      expect(find.text('This should not appear'), findsNothing);
    });

    testWidgets('respects dismissible property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              dismissible: false,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.dismissible, isFalse);
    });

    testWidgets('handles timing configuration', (WidgetTester tester) async {
      const customTiming = NotificationTiming(
        duration: Duration(seconds: 10),
        showProgress: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              timing: customTiming,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.timing, equals(customTiming));
    });

    testWidgets('handles elevation and margin customization',
        (WidgetTester tester) async {
      const elevation = 12.0;
      const margin = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastNotification(
              type: NotificationType.info,
              message: 'Test message',
              elevation: elevation,
              margin: margin,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.elevation, equals(elevation));
      expect(baseNotification.margin, equals(margin));
    });
  });

  group('ToastOverlay', () {
    testWidgets('creates and displays toast overlay correctly',
        (WidgetTester tester) async {
      final toast = ToastNotification.success(message: 'Test overlay message');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastOverlay(toast: toast),
          ),
        ),
      );

      expect(find.text('Test overlay message'), findsOneWidget);
    });

    testWidgets('handles dismiss callback from overlay',
        (WidgetTester tester) async {
      bool dismissed = false;
      final toast = ToastNotification.success(message: 'Test message');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastOverlay(
              toast: toast,
              onDismiss: () => dismissed = true,
            ),
          ),
        ),
      );

      // Trigger dismiss by tapping close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
    });

    testWidgets('animation works correctly in overlay',
        (WidgetTester tester) async {
      final toast = ToastNotification.success(message: 'Test message');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ToastOverlay(toast: toast),
          ),
        ),
      );

      // Verify animation widgets are present
      expect(find.byType(SlideTransition), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);
    });
  });
}
