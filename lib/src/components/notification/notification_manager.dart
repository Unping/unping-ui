import 'dart:collection';
import 'package:flutter/material.dart';
import 'base_notification.dart';
import 'notification_types.dart';
import 'toast_notification.dart';
import 'snackbar_notification.dart';

/// A notification entry in the queue
class NotificationEntry {
  /// Unique identifier for the notification
  final String id;

  /// The notification widget
  final Widget notification;

  /// Priority of the notification
  final NotificationPriority priority;

  /// Whether the notification is currently visible
  bool isVisible;

  /// Overlay entry for the notification
  OverlayEntry? overlayEntry;

  /// Animation controller for the notification
  AnimationController? animationController;

  /// Timestamp when the notification was created
  final DateTime createdAt;

  /// Duration before auto-dismiss
  final Duration? duration;

  /// Callback when the notification is dismissed
  final VoidCallback? onDismiss;

  NotificationEntry({
    required this.id,
    required this.notification,
    required this.priority,
    required this.createdAt,
    this.duration,
    this.onDismiss,
    this.isVisible = false,
  });
}

/// Global notification manager for handling notification display and queue
class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();

  /// Singleton access
  factory NotificationManager() => _instance;

  NotificationManager._internal();

  /// Queue of notifications
  final Queue<NotificationEntry> _queue = Queue<NotificationEntry>();

  /// Currently visible notifications by position
  final Map<String, NotificationEntry> _visibleNotifications = {};

  /// Maximum number of notifications to show simultaneously
  int maxSimultaneous = 3;

  /// Default spacing between stacked notifications
  double stackSpacing = 60.0;

  /// Whether the notification system is initialized
  bool _initialized = false;

  /// Overlay context for showing notifications
  BuildContext? _overlayContext;

  /// Initialize the notification manager with overlay context
  void initialize(BuildContext context) {
    _overlayContext = context;
    _initialized = true;
  }

  /// Show a toast notification
  String showToast({
    required NotificationType type,
    required String message,
    String? title,
    Widget? icon,
    List<NotificationAction> actions = const [],
    ToastPosition position = ToastPosition.topCenter,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    double? width,
    double? maxWidth = 400,
    NotificationTiming timing = NotificationTiming.toast,
    NotificationFeedback feedback = const NotificationFeedback(),
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    if (!_initialized) {
      throw StateError(
          'NotificationManager not initialized. Call initialize() first.');
    }

    final id = _generateId();
    final toast = ToastNotification(
      type: type,
      title: title,
      message: message,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: () => dismiss(id),
      content: content,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: iconColor,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: feedback,
      showCloseButton: showCloseButton,
      margin: margin,
    );

    final entry = NotificationEntry(
      id: id,
      notification: toast,
      priority: priority,
      createdAt: DateTime.now(),
      duration: timing.duration,
      onDismiss: onDismiss,
    );

    _queueNotification(entry);
    return id;
  }

  /// Show a snackbar notification
  String showSnackbar({
    required NotificationType type,
    required String message,
    Widget? icon,
    NotificationAction? action,
    SnackbarPosition position = SnackbarPosition.bottom,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? width,
    double? maxWidth,
    NotificationTiming timing = NotificationTiming.snackbar,
    NotificationFeedback feedback = const NotificationFeedback(),
    NotificationSwipeConfig swipeConfig = NotificationSwipeConfig.defaultConfig,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    if (!_initialized) {
      throw StateError(
          'NotificationManager not initialized. Call initialize() first.');
    }

    final id = _generateId();
    final snackbar = SnackbarNotification(
      type: type,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: () => dismiss(id),
      content: content,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: feedback,
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
    );

    final entry = NotificationEntry(
      id: id,
      notification: snackbar,
      priority: priority,
      createdAt: DateTime.now(),
      duration: timing.duration,
      onDismiss: onDismiss,
    );

    _queueNotification(entry);
    return id;
  }

  /// Show a custom notification
  String show({
    required Widget notification,
    NotificationPriority priority = NotificationPriority.normal,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    if (!_initialized) {
      throw StateError(
          'NotificationManager not initialized. Call initialize() first.');
    }

    final id = _generateId();
    final entry = NotificationEntry(
      id: id,
      notification: notification,
      priority: priority,
      createdAt: DateTime.now(),
      duration: duration,
      onDismiss: onDismiss,
    );

    _queueNotification(entry);
    return id;
  }

  /// Dismiss a specific notification
  void dismiss(String id) {
    final entry = _visibleNotifications[id];
    if (entry != null) {
      _hideNotification(entry);
    } else {
      // Remove from queue if not yet visible
      _queue.removeWhere((e) => e.id == id);
    }
  }

  /// Dismiss all notifications
  void dismissAll() {
    // Hide all visible notifications
    final entries = List<NotificationEntry>.from(_visibleNotifications.values);
    for (final entry in entries) {
      _hideNotification(entry);
    }

    // Clear the queue
    _queue.clear();
  }

  /// Clear notifications of a specific type
  void clearType(NotificationType type) {
    // Hide visible notifications of this type
    final toHide = _visibleNotifications.values
        .where((entry) => _getNotificationType(entry.notification) == type)
        .toList();

    for (final entry in toHide) {
      _hideNotification(entry);
    }

    // Remove from queue
    _queue.removeWhere(
        (entry) => _getNotificationType(entry.notification) == type);
  }

  /// Get the count of visible notifications
  int get visibleCount => _visibleNotifications.length;

  /// Get the count of queued notifications
  int get queuedCount => _queue.length;

  /// Check if a notification is visible
  bool isVisible(String id) => _visibleNotifications.containsKey(id);

  /// Queue a notification for display
  void _queueNotification(NotificationEntry entry) {
    // Handle priority - critical notifications bypass queue
    if (entry.priority == NotificationPriority.critical) {
      _showNotification(entry);
      return;
    }

    // Add to queue based on priority
    if (entry.priority == NotificationPriority.high) {
      // Insert high priority at the front of normal/low priority items
      int insertIndex = 0;
      for (int i = 0; i < _queue.length; i++) {
        if (_queue.elementAt(i).priority == NotificationPriority.critical) {
          insertIndex = i + 1;
        } else {
          break;
        }
      }
      final list = _queue.toList();
      list.insert(insertIndex, entry);
      _queue.clear();
      _queue.addAll(list);
    } else {
      _queue.add(entry);
    }

    _processQueue();
  }

  /// Process the notification queue
  void _processQueue() {
    while (
        _queue.isNotEmpty && _visibleNotifications.length < maxSimultaneous) {
      final entry = _queue.removeFirst();
      _showNotification(entry);
    }
  }

  /// Show a notification
  void _showNotification(NotificationEntry entry) {
    if (_overlayContext == null) return;

    final overlay = Overlay.of(_overlayContext!);

    // Create overlay entry
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _buildNotificationWrapper(entry),
    );

    entry.overlayEntry = overlayEntry;
    entry.isVisible = true;
    _visibleNotifications[entry.id] = entry;

    // Insert the overlay
    overlay.insert(overlayEntry);

    // Set up auto-dismiss timer
    if (entry.duration != null) {
      Future.delayed(entry.duration!, () {
        if (_visibleNotifications.containsKey(entry.id)) {
          dismiss(entry.id);
        }
      });
    }
  }

  /// Hide a notification
  void _hideNotification(NotificationEntry entry) {
    entry.overlayEntry?.remove();
    entry.overlayEntry = null;
    entry.isVisible = false;
    _visibleNotifications.remove(entry.id);

    // Call dismiss callback
    if (entry.onDismiss != null) {
      entry.onDismiss!();
    }

    // Process queue to show next notification
    _processQueue();
  }

  /// Build wrapper for positioning and stacking notifications
  Widget _buildNotificationWrapper(NotificationEntry entry) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Material(
          type: MaterialType.transparency,
          child: entry.notification,
        ),
      ),
    );
  }

  /// Generate unique ID for notifications
  String _generateId() {
    return 'notification_${DateTime.now().millisecondsSinceEpoch}_${_queue.length}';
  }

  /// Get notification type from widget
  NotificationType? _getNotificationType(Widget notification) {
    if (notification is ToastNotification) {
      return notification.type;
    } else if (notification is SnackbarNotification) {
      return notification.type;
    } else if (notification is BaseNotification) {
      return notification.type;
    }
    return null;
  }

  /// Dispose the manager and clean up resources
  void dispose() {
    dismissAll();
    _initialized = false;
    _overlayContext = null;
  }
}

/// Extension to make NotificationManager easily accessible
extension BuildContextNotifications on BuildContext {
  /// Get the notification manager instance
  NotificationManager get notifications => NotificationManager();
}
