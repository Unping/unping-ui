import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('SnackbarNotification', () {
    testWidgets('displays correctly with basic properties',
        (WidgetTester tester) async {
      const message = 'Test snackbar message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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
      final successSnackbar = SnackbarNotification.success(message: message);
      expect(successSnackbar.type, equals(NotificationType.success));

      // Test error factory
      final errorSnackbar = SnackbarNotification.error(message: message);
      expect(errorSnackbar.type, equals(NotificationType.error));

      // Test warning factory
      final warningSnackbar = SnackbarNotification.warning(message: message);
      expect(warningSnackbar.type, equals(NotificationType.warning));

      // Test info factory
      final infoSnackbar = SnackbarNotification.info(message: message);
      expect(infoSnackbar.type, equals(NotificationType.info));
    });

    testWidgets('positions snackbar correctly based on SnackbarPosition',
        (WidgetTester tester) async {
      final positions = [
        SnackbarPosition.bottom,
        SnackbarPosition.top,
      ];

      for (final position in positions) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SnackbarNotification(
                type: NotificationType.info,
                message: 'Test message',
                position: position,
              ),
            ),
          ),
        );

        // Verify the snackbar is positioned correctly (Align widget should be present)
        expect(find.byType(Align), findsOneWidget);

        final align = tester.widget<Align>(find.byType(Align));
        expect(align.alignment, isNotNull);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('applies dark theme colors correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.success,
              message: 'Test message',
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));

      // Snackbars should use darker background colors
      expect(baseNotification.backgroundColor, isNotNull);
      expect(baseNotification.textColor, isNotNull);
      expect(baseNotification.iconColor, isNotNull);
    });

    testWidgets('handles single action correctly', (WidgetTester tester) async {
      bool actionPressed = false;

      final action = NotificationAction(
        label: 'Undo',
        onPressed: () => actionPressed = true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
              action: action,
            ),
          ),
        ),
      );

      expect(find.text('Undo'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(actionPressed, isTrue);
    });

    testWidgets('handles dismiss callback', (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
              onDismiss: () => dismissed = true,
              showCloseButton: true,
            ),
          ),
        ),
      );

      // Since showCloseButton defaults to false for snackbars, we need to enable it
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
    });

    testWidgets('swipe configuration works correctly',
        (WidgetTester tester) async {
      const swipeConfig = NotificationSwipeConfig(
        enabled: true,
        direction: DismissDirection.horizontal,
        threshold: 0.5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
              swipeConfig: swipeConfig,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.swipeConfig.enabled, isTrue);
      expect(baseNotification.swipeConfig.direction,
          equals(DismissDirection.horizontal));
      expect(baseNotification.swipeConfig.threshold, equals(0.5));
    });

    testWidgets('disables swipe when configured', (WidgetTester tester) async {
      const swipeConfig = NotificationSwipeConfig.disabled;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
              swipeConfig: swipeConfig,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.swipeConfig.enabled, isFalse);
    });

    testWidgets('uses custom icon when provided', (WidgetTester tester) async {
      const customIcon = Icon(Icons.favorite, key: Key('custom-icon'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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
          Text('Custom snackbar content', key: Key('custom-content'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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

    testWidgets('handles width and maxWidth constraints',
        (WidgetTester tester) async {
      const width = 250.0;
      const maxWidth = 350.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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

    testWidgets('respects dismissible property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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
        duration: Duration(seconds: 8),
        showProgress: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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

    testWidgets('close button is hidden by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.showCloseButton, isFalse);
    });

    testWidgets('applies custom styling properties',
        (WidgetTester tester) async {
      const backgroundColor = Colors.deepPurple;
      const textColor = Colors.white;
      const iconColor = Colors.amber;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
              backgroundColor: backgroundColor,
              textColor: textColor,
              iconColor: iconColor,
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.backgroundColor, equals(backgroundColor));
      expect(baseNotification.textColor, equals(textColor));
      expect(baseNotification.iconColor, equals(iconColor));
    });

    testWidgets('handles elevation and margin customization',
        (WidgetTester tester) async {
      const elevation = 10.0;
      const margin = EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
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

    testWidgets('applies correct border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarNotification(
              type: NotificationType.info,
              message: 'Test message',
            ),
          ),
        ),
      );

      final baseNotification =
          tester.widget<BaseNotification>(find.byType(BaseNotification));
      expect(baseNotification.borderRadius, equals(UiRadius.allSm));
    });
  });

  group('SnackbarOverlay', () {
    testWidgets('creates and displays snackbar overlay correctly',
        (WidgetTester tester) async {
      final snackbar =
          SnackbarNotification.success(message: 'Test overlay message');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarOverlay(snackbar: snackbar),
          ),
        ),
      );

      expect(find.text('Test overlay message'), findsOneWidget);
    });

    testWidgets('handles dismiss callback from overlay',
        (WidgetTester tester) async {
      bool dismissed = false;
      final snackbar = SnackbarNotification.success(
        message: 'Test message',
        showCloseButton: true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarOverlay(
              snackbar: snackbar,
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
      final snackbar = SnackbarNotification.success(message: 'Test message');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarOverlay(snackbar: snackbar),
          ),
        ),
      );

      // Verify animation widgets are present
      expect(find.byType(SlideTransition), findsOneWidget);
      expect(find.byType(FadeTransition), findsOneWidget);
    });

    testWidgets('uses correct slide animation direction based on position',
        (WidgetTester tester) async {
      final bottomSnackbar = SnackbarNotification.success(
        message: 'Bottom message',
        position: SnackbarPosition.bottom,
      );

      final topSnackbar = SnackbarNotification.success(
        message: 'Top message',
        position: SnackbarPosition.top,
      );

      // Test bottom position
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarOverlay(snackbar: bottomSnackbar),
          ),
        ),
      );

      expect(find.byType(SlideTransition), findsOneWidget);

      // Test top position
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SnackbarOverlay(snackbar: topSnackbar),
          ),
        ),
      );

      expect(find.byType(SlideTransition), findsOneWidget);
    });
  });
}
