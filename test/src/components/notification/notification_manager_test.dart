import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('NotificationManager', () {
    setUp(() {
      // Reset the manager for each test
      NotificationManager().dispose();
    });

    testWidgets('initializes correctly with context',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      expect(manager.visibleCount, equals(0));
      expect(manager.queuedCount, equals(0));
    });

    testWidgets('throws error when not initialized',
        (WidgetTester tester) async {
      final manager = NotificationManager();

      expect(
        () => manager.showToast(
          type: NotificationType.info,
          message: 'Test message',
        ),
        throwsStateError,
      );
    });

    testWidgets('shows toast notification correctly',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = manager.showToast(
        type: NotificationType.success,
        message: 'Test toast message',
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(manager.visibleCount, equals(1));
      expect(find.text('Test toast message'), findsOneWidget);
    });

    testWidgets('shows snackbar notification correctly',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = manager.showSnackbar(
        type: NotificationType.info,
        message: 'Test snackbar message',
      );

      await tester.pump();

      expect(id, isNotEmpty);
      expect(manager.visibleCount, equals(1));
      expect(find.text('Test snackbar message'), findsOneWidget);
    });

    testWidgets('dismisses notification by ID', (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = manager.showToast(
        type: NotificationType.info,
        message: 'Test message',
      );

      await tester.pump();
      expect(manager.visibleCount, equals(1));

      manager.dismiss(id);
      await tester.pump();

      expect(manager.visibleCount, equals(0));
    });

    testWidgets('dismisses all notifications', (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Show multiple notifications
      manager.showToast(type: NotificationType.info, message: 'Message 1');
      manager.showToast(type: NotificationType.success, message: 'Message 2');
      manager.showSnackbar(
          type: NotificationType.warning, message: 'Message 3');

      await tester.pump();
      expect(manager.visibleCount, greaterThan(0));

      manager.dismissAll();
      await tester.pump();

      expect(manager.visibleCount, equals(0));
      expect(manager.queuedCount, equals(0));
    });

    testWidgets('clears notifications by type', (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Show notifications of different types
      manager.showToast(type: NotificationType.info, message: 'Info message');
      manager.showToast(
          type: NotificationType.success, message: 'Success message');
      manager.showToast(type: NotificationType.error, message: 'Error message');

      await tester.pump();
      expect(manager.visibleCount, equals(3));

      // Clear only info notifications
      manager.clearType(NotificationType.info);
      await tester.pump();

      expect(find.text('Info message'), findsNothing);
      expect(find.text('Success message'), findsOneWidget);
      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets('handles priority correctly', (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              manager.maxSimultaneous = 1; // Limit to 1 for testing queue
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Show low priority notification first
      manager.showToast(
        type: NotificationType.info,
        message: 'Low priority',
        priority: NotificationPriority.low,
      );

      await tester.pump();
      expect(find.text('Low priority'), findsOneWidget);

      // Show high priority notification - should be visible
      manager.showToast(
        type: NotificationType.error,
        message: 'High priority',
        priority: NotificationPriority.high,
      );

      await tester.pump();
      expect(manager.visibleCount, equals(1));
      expect(manager.queuedCount, equals(1));
    });

    testWidgets('critical priority notifications bypass queue',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              manager.maxSimultaneous = 1;
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Fill the available slot
      manager.showToast(
        type: NotificationType.info,
        message: 'Normal message',
        priority: NotificationPriority.normal,
      );

      await tester.pump();
      expect(manager.visibleCount, equals(1));

      // Critical notification should still show
      manager.showToast(
        type: NotificationType.error,
        message: 'Critical message',
        priority: NotificationPriority.critical,
      );

      await tester.pump();
      expect(manager.visibleCount, equals(2));
    });

    testWidgets('checks visibility of notifications',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      final id = manager.showToast(
        type: NotificationType.info,
        message: 'Test message',
      );

      await tester.pump();
      expect(manager.isVisible(id), isTrue);

      manager.dismiss(id);
      await tester.pump();
      expect(manager.isVisible(id), isFalse);
    });

    testWidgets('handles custom notification widget',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      const customWidget = Text('Custom notification', key: Key('custom'));

      final id = manager.show(
        notification: customWidget,
        priority: NotificationPriority.normal,
      );

      await tester.pump();
      expect(find.byKey(const Key('custom')), findsOneWidget);
      expect(manager.isVisible(id), isTrue);
    });

    testWidgets('processes queue when notifications are dismissed',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              manager.maxSimultaneous = 1;
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      // Fill queue
      final id1 =
          manager.showToast(type: NotificationType.info, message: 'Message 1');
      manager.showToast(type: NotificationType.info, message: 'Message 2');
      manager.showToast(type: NotificationType.info, message: 'Message 3');

      await tester.pump();
      expect(manager.visibleCount, equals(1));
      expect(manager.queuedCount, equals(2));

      // Dismiss first notification
      manager.dismiss(id1);
      await tester.pump();

      // Queue should process next notification
      expect(manager.visibleCount, equals(1));
      expect(manager.queuedCount, equals(1));
    });

    testWidgets('handles onDismiss callback', (WidgetTester tester) async {
      late NotificationManager manager;
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      manager.showToast(
        type: NotificationType.info,
        message: 'Test message',
        onDismiss: () => dismissed = true,
        showCloseButton: true,
      );

      await tester.pump();

      // Tap close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(dismissed, isTrue);
    });

    testWidgets('manager properties are accessible',
        (WidgetTester tester) async {
      final manager = NotificationManager();

      // Test that properties have default values
      expect(manager.maxSimultaneous, equals(3));
      expect(manager.stackSpacing, equals(60.0));
      
      // Test that properties can be modified
      manager.maxSimultaneous = 5;
      manager.stackSpacing = 80.0;
      
      expect(manager.maxSimultaneous, equals(5));
      expect(manager.stackSpacing, equals(80.0));
    });

    testWidgets('dispose cleans up resources', (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = NotificationManager();
              manager.initialize(context);
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      manager.showToast(type: NotificationType.info, message: 'Test');
      await tester.pump();
      expect(manager.visibleCount, equals(1));

      manager.dispose();
      expect(manager.visibleCount, equals(0));
      expect(manager.queuedCount, equals(0));
    });
  });

  group('BuildContext Extension', () {
    testWidgets('provides access to notification manager',
        (WidgetTester tester) async {
      late NotificationManager manager;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              manager = context.notifications;
              return const Scaffold(body: Text('Test'));
            },
          ),
        ),
      );

      expect(manager, isA<NotificationManager>());
    });
  });
}
