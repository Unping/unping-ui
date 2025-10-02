import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Notifications API', () {
    setUp(() {
      NotificationManager().dispose();
    });

    testWidgets('initialize sets up notification system',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Should not throw when showing notifications after initialization
      expect(() => Notifications.info(message: 'Test'), returnsNormally);
    });

    testWidgets('success method creates success toast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.success(message: 'Success message');
      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('error method creates error toast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.error(message: 'Error message');
      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('warning method creates warning toast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.warning(message: 'Warning message');
      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('info method creates info toast', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.info(message: 'Info message');
      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('toast method with custom type works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.toast(
        type: NotificationType.success,
        message: 'Custom toast',
        title: 'Custom Title',
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Custom toast'), findsOneWidget);
      expect(find.text('Custom Title'), findsOneWidget);
    });

    testWidgets('snackbar method creates snackbar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      bool actionPressed = false;
      final action = NotificationAction(
        label: 'Action',
        onPressed: () => actionPressed = true,
      );

      final id = Notifications.snackbar(
        type: NotificationType.info,
        message: 'Snackbar message',
        action: action,
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Snackbar message'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);

      await tester.tap(find.text('Action'));
      await tester.pump();
      expect(actionPressed, isTrue);
    });

    testWidgets('alert method creates persistent notification',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.alert(
        type: NotificationType.warning,
        title: 'Alert Title',
        message: 'Alert message',
        actions: [
          NotificationAction(
            label: 'Dismiss',
            onPressed: () {},
          ),
        ],
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert message'), findsOneWidget);
      expect(find.text('Dismiss'), findsOneWidget);
    });

    testWidgets('show method displays custom widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      const customWidget = Text('Custom notification', key: Key('custom'));

      final id = Notifications.show(
        content: customWidget,
        duration: const Duration(seconds: 5),
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.byKey(const Key('custom')), findsOneWidget);
    });

    testWidgets('dismiss methods work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id1 = Notifications.info(message: 'Message 1');
      Notifications.success(message: 'Message 2');
      Notifications.error(message: 'Message 3');

      await tester.pump();
      expect(Notifications.visibleCount, equals(3));

      // Dismiss specific notification
      Notifications.dismiss(id1);
      await tester.pump();
      expect(Notifications.visibleCount, equals(2));

      // Dismiss all
      Notifications.dismissAll();
      await tester.pump();
      expect(Notifications.visibleCount, equals(0));
    });

    testWidgets('clearType removes notifications of specific type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      Notifications.info(message: 'Info 1');
      Notifications.info(message: 'Info 2');
      Notifications.success(message: 'Success 1');

      await tester.pump();
      expect(Notifications.visibleCount, equals(3));

      Notifications.clearType(NotificationType.info);
      await tester.pump();

      expect(find.text('Info 1'), findsNothing);
      expect(find.text('Info 2'), findsNothing);
      expect(find.text('Success 1'), findsOneWidget);
    });

    testWidgets('visibility check works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.info(message: 'Test message');
      await tester.pump();

      expect(Notifications.isVisible(id), isTrue);

      Notifications.dismiss(id);
      await tester.pump();

      expect(Notifications.isVisible(id), isFalse);
    });

    testWidgets('configuration updates manager settings',
        (WidgetTester tester) async {
      Notifications.configure(
        maxSimultaneous: 5,
        stackSpacing: 100.0,
      );

      final manager = NotificationManager();
      expect(manager.maxSimultaneous, equals(5));
      expect(manager.stackSpacing, equals(100.0));
    });

    testWidgets('undo convenience method works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      bool undoPressed = false;
      final id = Notifications.undo(
        message: 'Item deleted',
        onUndo: () => undoPressed = true,
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Item deleted'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pump();
      expect(undoPressed, isTrue);
    });

    testWidgets('loading convenience method works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.loading(message: 'Loading data...');
      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Loading data...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('confirm convenience method works',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      bool confirmed = false;
      bool cancelled = false;

      final id = Notifications.confirm(
        title: 'Confirm Action',
        message: 'Are you sure?',
        onConfirm: () => confirmed = true,
        onCancel: () => cancelled = true,
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Confirm Action'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);

      await tester.tap(find.text('Confirm'));
      await tester.pump();
      expect(confirmed, isTrue);

      // Create another confirmation for cancel test
      Notifications.confirm(
        message: 'Test cancel',
        onConfirm: () {},
        onCancel: () => cancelled = true,
      );

      await tester.pump();
      await tester.tap(find.text('Cancel'));
      await tester.pump();
      expect(cancelled, isTrue);
    });

    testWidgets('custom timing and options work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = Notifications.success(
        message: 'Custom options',
        title: 'Custom Title',
        duration: const Duration(seconds: 10),
        showProgress: false,
        showCloseButton: false,
        position: ToastPosition.bottomRight,
        width: 300,
        maxWidth: 400,
        priority: NotificationPriority.high,
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(find.text('Custom options'), findsOneWidget);
      expect(find.text('Custom Title'), findsOneWidget);
      // Close button should not be visible
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('dispose cleans up resources', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      Notifications.info(message: 'Test');
      await tester.pump();
      expect(Notifications.visibleCount, equals(1));

      Notifications.dispose();
      expect(Notifications.visibleCount, equals(0));
    });

    testWidgets('actions with different styles work',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final actions = [
        NotificationAction(
          label: 'Text Action',
          onPressed: () {},
          style: NotificationActionStyle.text,
        ),
        NotificationAction(
          label: 'Filled Action',
          onPressed: () {},
          style: NotificationActionStyle.filled,
        ),
        NotificationAction(
          label: 'Outlined Action',
          onPressed: () {},
          style: NotificationActionStyle.outlined,
        ),
      ];

      Notifications.alert(
        type: NotificationType.info,
        message: 'Test actions',
        actions: actions,
      );

      await tester.pump();

      expect(find.text('Text Action'), findsOneWidget);
      expect(find.text('Filled Action'), findsOneWidget);
      expect(find.text('Outlined Action'), findsOneWidget);
    });

    testWidgets('onDismiss callbacks work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              Notifications.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      bool dismissed = false;
      Notifications.success(
        message: 'Test dismiss',
        onDismiss: () => dismissed = true,
      );

      await tester.pump();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(dismissed, isTrue);
    });
  });
}
