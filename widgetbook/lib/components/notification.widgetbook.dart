import 'dart:async';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:unping_ui/unping_ui.dart';

/// Notification components for the Unping-UI design system
@widgetbook.UseCase(
  name: 'Base Notification',
  type: BaseNotification,
)
Widget baseNotificationUseCase(BuildContext context) {
  return Center(
    child: BaseNotification(
      type: NotificationType.success,
      title: 'Notification Title',
      message: 'This is a sample notification message that demonstrates the component.',
      actions: [
        NotificationAction(
          label: 'Primary',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Primary action pressed')),
            );
          },
          style: NotificationActionStyle.filled,
        ),
        NotificationAction(
          label: 'Secondary',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Secondary action pressed')),
            );
          },
          style: NotificationActionStyle.outlined,
        ),
      ],
      dismissible: true,
      showCloseButton: true,
      showProgress: false,
      elevation: 4.0,
      onDismiss: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification dismissed')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Toast Notification',
  type: ToastNotification,
)
Widget toastNotificationUseCase(BuildContext context) {
  return ToastNotification(
    type: NotificationType.success,
    title: 'Toast Title',
    message: 'This is a toast notification message.',
    position: ToastPosition.topCenter,
    actions: [
      NotificationAction(
        label: 'Action',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Toast action pressed')),
          );
        },
      ),
    ],
    dismissible: true,
    showCloseButton: true,
    maxWidth: 400.0,
    elevation: 8.0,
    onDismiss: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Toast dismissed')),
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Snackbar Notification',
  type: SnackbarNotification,
)
Widget snackbarNotificationUseCase(BuildContext context) {
  return SnackbarNotification(
    type: NotificationType.info,
    message: 'This is a snackbar notification message.',
    position: SnackbarPosition.bottom,
    action: NotificationAction(
      label: 'Undo',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Undo action pressed')),
        );
      },
    ),
    dismissible: true,
    swipeConfig: NotificationSwipeConfig.defaultConfig,
    showCloseButton: false,
    elevation: 6.0,
    onDismiss: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Snackbar dismissed')),
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Notification Variants',
  type: Notifications,
)
Widget notificationVariantsUseCase(BuildContext context) {
  // Initialize the notification system
  Notifications.initialize(context);

  return Scaffold(
    appBar: AppBar(
      title: const Text('Notification Variants'),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: () => Notifications.dismissAll(),
          tooltip: 'Dismiss All',
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Toast Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.success(
                  message: 'Profile updated successfully!',
                  title: 'Success',
                ),
                child: const Text('Success Toast'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.error(
                  message: 'Failed to save changes. Please try again.',
                  title: 'Error',
                  actions: [
                    NotificationAction(
                      label: 'Retry',
                      onPressed: () => Notifications.info(message: 'Retrying...'),
                    ),
                  ],
                ),
                child: const Text('Error Toast'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.warning(
                  message: 'Your session will expire in 5 minutes.',
                  title: 'Warning',
                ),
                child: const Text('Warning Toast'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.info(
                  message: 'New features are available in version 2.0',
                  title: 'Info',
                ),
                child: const Text('Info Toast'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.success(
                  message: 'File uploaded successfully',
                  title: 'Upload Complete',
                  duration: const Duration(seconds: 2),
                ),
                child: const Text('Quick Success'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.error(
                  message: 'Network connection lost. Please check your internet connection and try again.',
                  title: 'Connection Error',
                  duration: const Duration(seconds: 8),
                ),
                child: const Text('Long Error'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.warning(
                  message: 'You have unsaved changes',
                  title: 'Unsaved Changes',
                  actions: [
                    NotificationAction(
                      label: 'Save',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.success(message: 'Changes saved'),
                    ),
                    NotificationAction(
                      label: 'Discard',
                      style: NotificationActionStyle.outlined,
                      onPressed: () => Notifications.info(message: 'Changes discarded'),
                    ),
                  ],
                ),
                child: const Text('Warning + Actions'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.info(
                  message: 'System maintenance scheduled for tonight at 2 AM',
                  title: 'Maintenance Notice',
                  actions: [
                    NotificationAction(
                      label: 'Learn More',
                      style: NotificationActionStyle.text,
                      onPressed: () => Notifications.info(message: 'Opening maintenance details...'),
                    ),
                  ],
                ),
                child: const Text('Info + Text Action'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Snackbar Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.success,
                  message: 'Item added to cart',
                  action: NotificationAction(
                    label: 'View Cart',
                    onPressed: () => Notifications.info(message: 'Opening cart...'),
                  ),
                ),
                child: const Text('Success Snackbar'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: 'Message deleted',
                  onUndo: () => Notifications.success(message: 'Message restored'),
                ),
                child: const Text('Undo Snackbar'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.error,
                  message: 'Connection failed',
                ),
                child: const Text('Error Snackbar'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.warning,
                  message: 'Storage almost full',
                  action: NotificationAction(
                    label: 'Manage',
                    onPressed: () => Notifications.info(message: 'Opening storage settings...'),
                  ),
                ),
                child: const Text('Warning Snackbar'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.info,
                  message: 'New update available',
                  action: NotificationAction(
                    label: 'Update',
                    onPressed: () => Notifications.success(message: 'Update started'),
                  ),
                  duration: const Duration(seconds: 6),
                ),
                child: const Text('Info + Long Duration'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.success,
                  message: 'Email sent successfully',
                ),
                child: const Text('Swipeable Success'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Alert Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.alert(
                  type: NotificationType.warning,
                  title: 'Maintenance Scheduled',
                  message: 'System will be down for maintenance tomorrow at 2 AM',
                  actions: [
                    NotificationAction(
                      label: 'Learn More',
                      onPressed: () => Notifications.info(message: 'Opening details...'),
                    ),
                  ],
                ),
                child: const Text('Maintenance Alert'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.confirm(
                  title: 'Delete Item',
                  message: 'Are you sure you want to delete this item? This action cannot be undone.',
                  onConfirm: () => Notifications.success(message: 'Item deleted'),
                  onCancel: () => Notifications.info(message: 'Action cancelled'),
                ),
                child: const Text('Confirmation Alert'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.error,
                  message: 'A critical error has occurred. Please contact support if this persists.',
                  title: 'Critical Error',
                  position: ToastPosition.center,
                  actions: [
                    NotificationAction(
                      label: 'Contact Support',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.info(message: 'Opening support...'),
                    ),
                    NotificationAction(
                      label: 'Retry',
                      style: NotificationActionStyle.outlined,
                      onPressed: () => Notifications.info(message: 'Retrying...'),
                    ),
                  ],
                ),
                child: const Text('Critical Alert'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Would you like to take a quick tour of the new features?',
                  title: 'Welcome Tour',
                  position: ToastPosition.topCenter,
                  duration: const Duration(seconds: 10),
                  actions: [
                    NotificationAction(
                      label: 'Start Tour',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.success(message: 'Starting tour...'),
                    ),
                    NotificationAction(
                      label: 'Maybe Later',
                      style: NotificationActionStyle.text,
                      onPressed: () => Notifications.info(message: 'Tour skipped'),
                    ),
                  ],
                ),
                child: const Text('Welcome Tour'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Special Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  final loadingId = Notifications.loading(
                    message: 'Uploading file...',
                  );
                  
                  // Simulate loading completion
                  Future.delayed(const Duration(seconds: 3), () {
                    Notifications.dismiss(loadingId);
                    Notifications.success(message: 'File uploaded successfully!');
                  });
                },
                child: const Text('Loading'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.show(
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.celebration, size: 48, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          'Congratulations!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'You\'ve completed all tasks for today',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  duration: const Duration(seconds: 5),
                ),
                child: const Text('Custom Rich'),
              ),
              ElevatedButton(
                onPressed: () {
                  final progressId = Notifications.loading(
                    message: 'Processing data...',
                  );
                  
                  // Simulate progress updates
                  int progress = 0;
                  Timer.periodic(const Duration(milliseconds: 500), (timer) {
                    progress += 20;
                    if (progress > 100) {
                      timer.cancel();
                      Notifications.dismiss(progressId);
                      Notifications.success(
                        message: 'Data processing completed!',
                      );
                    }
                  });
                },
                child: const Text('Progress Update'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.show(
                  content: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.wifi_off, color: Colors.orange),
                              const SizedBox(width: 8),
                              const Text(
                                'Connection Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('You\'re currently offline. Some features may not be available.'),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Notifications.dismissAll(),
                                child: const Text('Dismiss'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Notifications.dismissAll();
                                  Notifications.info(message: 'Checking connection...');
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  duration: const Duration(seconds: 8),
                ),
                child: const Text('Offline Status'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Position Tests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Top Left',
                  position: ToastPosition.topLeft,
                ),
                child: const Text('Top Left'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Top Center',
                  position: ToastPosition.topCenter,
                ),
                child: const Text('Top Center'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Top Right',
                  position: ToastPosition.topRight,
                ),
                child: const Text('Top Right'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: 'Message deleted',
                  onUndo: () => Notifications.success(message: 'Message restored'),
                ),
                child: const Text('Undo Snackbar'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Queue Management',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Visible: ${Notifications.visibleCount}'),
                  Text('Queued: ${Notifications.queuedCount}'),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Show multiple notifications to test queue
                          for (int i = 1; i <= 5; i++) {
                            Notifications.info(
                              message: 'Notification $i',
                              duration: const Duration(seconds: 2),
                            );
                          }
                        },
                        child: const Text('Show 5 Notifications'),
                      ),
                      ElevatedButton(
                        onPressed: () => Notifications.dismissAll(),
                        child: const Text('Dismiss All'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Styled Notifications',
  type: BaseNotification,
)
Widget customStyledNotificationsUseCase(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Custom Styled Notifications')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Dark theme notification
          BaseNotification(
            type: NotificationType.success,
            title: 'Dark Theme',
            message: 'This notification uses a dark theme style',
            backgroundColor: Colors.grey[900],
            borderColor: Colors.green,
            textColor: Colors.white,
            iconColor: Colors.green,
            actions: [
              NotificationAction(
                label: 'Action',
                onPressed: () {},
                style: NotificationActionStyle.outlined,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Gradient notification (using custom content)
          BaseNotification(
            type: NotificationType.info,
            message: '',
            content: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hot Deal!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '50% off all items today only',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            borderColor: Colors.transparent,
            elevation: 0,
          ),
          const SizedBox(height: 20),
          // Minimal notification
          BaseNotification(
            type: NotificationType.info,
            message: 'Minimal style notification',
            backgroundColor: Colors.grey[50],
            borderColor: Colors.grey[300],
            textColor: Colors.grey[800],
            iconColor: Colors.grey[600],
            elevation: 1,
            showCloseButton: false,
          ),
          const SizedBox(height: 20),
          // High contrast notification
          BaseNotification(
            type: NotificationType.warning,
            title: 'High Contrast',
            message: 'This notification is designed for high contrast',
            backgroundColor: Colors.yellow[100],
            borderColor: Colors.orange[800],
            textColor: Colors.orange[900],
            iconColor: Colors.orange[800],
            actions: [
              NotificationAction(
                label: 'Dismiss',
                onPressed: () {},
                style: NotificationActionStyle.filled,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Toast Notification Variants',
  type: ToastNotification,
)
Widget toastNotificationVariantsUseCase(BuildContext context) {
  Notifications.initialize(context);

  return Scaffold(
    appBar: AppBar(title: const Text('Toast Notification Variants')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Position Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.success,
                  message: 'Top Left Position',
                  title: 'Success',
                  position: ToastPosition.topLeft,
                ),
                child: const Text('Top Left'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Top Center Position',
                  title: 'Information',
                  position: ToastPosition.topCenter,
                ),
                child: const Text('Top Center'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.warning,
                  message: 'Top Right Position',
                  title: 'Warning',
                  position: ToastPosition.topRight,
                ),
                child: const Text('Top Right'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.error,
                  message: 'Center Position',
                  title: 'Error',
                  position: ToastPosition.center,
                ),
                child: const Text('Center'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.success,
                  message: 'Bottom Left Position',
                  title: 'Success',
                  position: ToastPosition.bottomLeft,
                ),
                child: const Text('Bottom Left'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Bottom Center Position',
                  title: 'Information',
                  position: ToastPosition.bottomCenter,
                ),
                child: const Text('Bottom Center'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.warning,
                  message: 'Bottom Right Position',
                  title: 'Warning',
                  position: ToastPosition.bottomRight,
                ),
                child: const Text('Bottom Right'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Duration Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Quick toast (1 second)',
                  duration: const Duration(seconds: 1),
                ),
                child: const Text('Quick (1s)'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Normal toast (3 seconds)',
                  duration: const Duration(seconds: 3),
                ),
                child: const Text('Normal (3s)'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.warning,
                  message: 'Long toast (8 seconds)',
                  duration: const Duration(seconds: 8),
                ),
                child: const Text('Long (8s)'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.error,
                  message: 'Persistent toast (requires manual dismiss)',
                  duration: Duration.zero, // Persistent
                ),
                child: const Text('Persistent'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Action Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.success,
                  message: 'Payment processed successfully',
                  title: 'Payment Complete',
                  actions: [
                    NotificationAction(
                      label: 'View Receipt',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.info(message: 'Opening receipt...'),
                    ),
                  ],
                ),
                child: const Text('Single Action'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.warning,
                  message: 'Your subscription expires in 3 days',
                  title: 'Subscription Warning',
                  actions: [
                    NotificationAction(
                      label: 'Renew Now',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.success(message: 'Redirecting to billing...'),
                    ),
                    NotificationAction(
                      label: 'Remind Later',
                      style: NotificationActionStyle.outlined,
                      onPressed: () => Notifications.info(message: 'Reminder set'),
                    ),
                  ],
                ),
                child: const Text('Dual Actions'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'New features are available. Check out what\'s new!',
                  title: 'What\'s New',
                  actions: [
                    NotificationAction(
                      label: 'Explore',
                      style: NotificationActionStyle.filled,
                      onPressed: () => Notifications.success(message: 'Opening features tour...'),
                    ),
                    NotificationAction(
                      label: 'Later',
                      style: NotificationActionStyle.text,
                      onPressed: () => Notifications.info(message: 'Tour postponed'),
                    ),
                  ],
                ),
                child: const Text('Text + Primary'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Special Effects',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.success,
                  message: 'High elevation toast',
                  title: 'Elevated',
                ),
                child: const Text('High Elevation'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.info,
                  message: 'Flat design toast',
                  title: 'Flat',
                ),
                child: const Text('No Elevation'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.toast(
                  type: NotificationType.warning,
                  message: 'Toast without progress indicator',
                  title: 'No Progress',
                ),
                child: const Text('No Progress'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Snackbar Notification Variants',
  type: SnackbarNotification,
)
Widget snackbarNotificationVariantsUseCase(BuildContext context) {
  Notifications.initialize(context);

  return Scaffold(
    appBar: AppBar(title: const Text('Snackbar Notification Variants')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Basic Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.success,
                  message: 'Item successfully added to favorites',
                ),
                child: const Text('Success'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.error,
                  message: 'Failed to connect to server',
                ),
                child: const Text('Error'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.warning,
                  message: 'Low battery warning',
                ),
                child: const Text('Warning'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.info,
                  message: 'Download completed',
                ),
                child: const Text('Info'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Action Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.success,
                  message: 'Photo saved to gallery',
                  action: NotificationAction(
                    label: 'View',
                    onPressed: () => Notifications.info(message: 'Opening gallery...'),
                  ),
                ),
                child: const Text('Success + View Action'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.error,
                  message: 'Upload failed',
                  action: NotificationAction(
                    label: 'Retry',
                    onPressed: () => Notifications.info(message: 'Retrying upload...'),
                  ),
                ),
                child: const Text('Error + Retry Action'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.warning,
                  message: 'Storage space running low',
                  action: NotificationAction(
                    label: 'Manage',
                    onPressed: () => Notifications.info(message: 'Opening storage manager...'),
                  ),
                ),
                child: const Text('Warning + Manage Action'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.info,
                  message: 'App updated to version 2.1.0',
                  action: NotificationAction(
                    label: 'What\'s New',
                    onPressed: () => Notifications.success(message: 'Opening changelog...'),
                  ),
                ),
                child: const Text('Info + What\'s New'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Undo Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: 'Email moved to trash',
                  onUndo: () => Notifications.success(message: 'Email restored'),
                ),
                child: const Text('Delete Email'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: 'Contact removed from favorites',
                  onUndo: () => Notifications.success(message: 'Contact re-added to favorites'),
                  duration: const Duration(seconds: 8),
                ),
                child: const Text('Remove Favorite'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: '5 items archived',
                  onUndo: () => Notifications.success(message: 'Items unarchived'),
                  undoLabel: 'Restore',
                ),
                child: const Text('Archive Items'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.undo(
                  message: 'Task completed',
                  onUndo: () => Notifications.info(message: 'Task marked as incomplete'),
                  undoLabel: 'Undo',
                  duration: const Duration(seconds: 5),
                ),
                child: const Text('Complete Task'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Swipe Configuration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.success,
                  message: 'Easy swipe to dismiss',
                ),
                child: const Text('Easy Swipe'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.warning,
                  message: 'Harder swipe required',
                ),
                child: const Text('Hard Swipe'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.info,
                  message: 'Swipe with custom icon',
                ),
                child: const Text('Custom Icon'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.error,
                  message: 'Swipe disabled for important message',
                ),
                child: const Text('No Swipe'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Duration Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.info,
                  message: 'Quick message (2 seconds)',
                  duration: const Duration(seconds: 2),
                ),
                child: const Text('Quick (2s)'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.warning,
                  message: 'Standard message (4 seconds)',
                  duration: const Duration(seconds: 4),
                ),
                child: const Text('Standard (4s)'),
              ),
              ElevatedButton(
                onPressed: () => Notifications.snackbar(
                  type: NotificationType.error,
                  message: 'Important message (10 seconds)',
                  duration: const Duration(seconds: 10),
                ),
                child: const Text('Long (10s)'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}