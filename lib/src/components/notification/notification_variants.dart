import 'package:flutter/material.dart';
import 'notification_manager.dart';
import 'notification_types.dart';

/// Public API for the notification system with predefined variants.
/// This class provides easy-to-use static methods for showing different types of notifications.
class Notifications {
  Notifications._();

  static final NotificationManager _manager = NotificationManager();

  /// Initialize the notification system with the given context.
  /// This should be called once in your app's main widget.
  static void initialize(BuildContext context) {
    _manager.initialize(context);
  }

  // Toast Notifications

  /// Show a success toast notification
  static String toast({
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
    Duration? duration,
    bool showProgress = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    final timing = NotificationTiming(
      duration: duration ?? const Duration(seconds: 4),
      showProgress: showProgress,
    );

    return _manager.showToast(
      type: type,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: iconColor,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: _getFeedbackForType(type),
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  /// Show a success toast notification
  static String success({
    required String message,
    String? title,
    Widget? icon,
    List<NotificationAction> actions = const [],
    ToastPosition position = ToastPosition.topCenter,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth = 400,
    Duration? duration,
    bool showProgress = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    return toast(
      type: NotificationType.success,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      duration: duration,
      showProgress: showProgress,
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  /// Show an error toast notification
  static String error({
    required String message,
    String? title,
    Widget? icon,
    List<NotificationAction> actions = const [],
    ToastPosition position = ToastPosition.topCenter,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth = 400,
    Duration? duration,
    bool showProgress = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.high,
  }) {
    return toast(
      type: NotificationType.error,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      duration: duration,
      showProgress: showProgress,
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  /// Show a warning toast notification
  static String warning({
    required String message,
    String? title,
    Widget? icon,
    List<NotificationAction> actions = const [],
    ToastPosition position = ToastPosition.topCenter,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth = 400,
    Duration? duration,
    bool showProgress = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    return toast(
      type: NotificationType.warning,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      duration: duration,
      showProgress: showProgress,
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  /// Show an info toast notification
  static String info({
    required String message,
    String? title,
    Widget? icon,
    List<NotificationAction> actions = const [],
    ToastPosition position = ToastPosition.topCenter,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth = 400,
    Duration? duration,
    bool showProgress = true,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    return toast(
      type: NotificationType.info,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      duration: duration,
      showProgress: showProgress,
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  // Snackbar Notifications

  /// Show a snackbar notification
  static String snackbar({
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
    Duration? duration,
    bool allowSwipeToDismiss = true,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    final timing = NotificationTiming(
      duration: duration ?? const Duration(seconds: 6),
      showProgress: false,
    );

    final swipeConfig = allowSwipeToDismiss
        ? NotificationSwipeConfig.defaultConfig
        : NotificationSwipeConfig.disabled;

    return _manager.showSnackbar(
      type: type,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: _getFeedbackForType(type),
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  // Alert Notifications (persistent toasts)

  /// Show an alert notification (persistent toast)
  static String alert({
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
    double? maxWidth = 500,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
    NotificationPriority priority = NotificationPriority.high,
  }) {
    const timing = NotificationTiming.alert; // No auto-dismiss

    return _manager.showToast(
      type: type,
      message: message,
      title: title,
      icon: icon,
      actions: actions,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: iconColor,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: _getFeedbackForType(type),
      showCloseButton: showCloseButton,
      margin: margin,
      priority: priority,
    );
  }

  // Custom Notifications

  /// Show a custom notification with complete control
  static String show({
    required Widget content,
    NotificationPriority priority = NotificationPriority.normal,
    Duration? duration,
    VoidCallback? onDismiss,
  }) {
    return _manager.show(
      notification: content,
      priority: priority,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  // Notification Management

  /// Dismiss a specific notification by ID
  static void dismiss(String id) {
    _manager.dismiss(id);
  }

  /// Dismiss all notifications
  static void dismissAll() {
    _manager.dismissAll();
  }

  /// Clear notifications of a specific type
  static void clearType(NotificationType type) {
    _manager.clearType(type);
  }

  /// Get the count of visible notifications
  static int get visibleCount => _manager.visibleCount;

  /// Get the count of queued notifications
  static int get queuedCount => _manager.queuedCount;

  /// Check if a notification is visible
  static bool isVisible(String id) => _manager.isVisible(id);

  /// Configure notification behavior
  static void configure({
    int? maxSimultaneous,
    double? stackSpacing,
  }) {
    if (maxSimultaneous != null) {
      _manager.maxSimultaneous = maxSimultaneous;
    }
    if (stackSpacing != null) {
      _manager.stackSpacing = stackSpacing;
    }
  }

  // Convenience Methods with Common Configurations

  /// Show an undo snackbar with action
  static String undo({
    required String message,
    required VoidCallback onUndo,
    String undoLabel = 'Undo',
    Duration? duration,
    SnackbarPosition position = SnackbarPosition.bottom,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    return snackbar(
      type: NotificationType.info,
      message: message,
      action: NotificationAction(
        label: undoLabel,
        onPressed: onUndo,
        dismissOnTap: true,
      ),
      duration: duration ?? const Duration(seconds: 6),
      position: position,
      priority: priority,
    );
  }

  /// Show a loading notification
  static String loading({
    String message = 'Loading...',
    Widget? icon,
    ToastPosition position = ToastPosition.topCenter,
    NotificationPriority priority = NotificationPriority.normal,
  }) {
    return alert(
      type: NotificationType.info,
      message: message,
      icon: icon ??
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
      position: position,
      dismissible: false,
      showCloseButton: false,
      priority: priority,
    );
  }

  /// Show a confirmation dialog as a notification
  static String confirm({
    required String message,
    String? title,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    ToastPosition position = ToastPosition.center,
    NotificationPriority priority = NotificationPriority.high,
  }) {
    return alert(
      type: NotificationType.warning,
      title: title,
      message: message,
      actions: [
        if (onCancel != null)
          NotificationAction(
            label: cancelLabel,
            onPressed: onCancel,
            style: NotificationActionStyle.outlined,
          ),
        NotificationAction(
          label: confirmLabel,
          onPressed: onConfirm,
          style: NotificationActionStyle.filled,
        ),
      ],
      position: position,
      dismissible: true,
      priority: priority,
    );
  }

  // Helper Methods

  /// Get appropriate feedback for notification type
  static NotificationFeedback _getFeedbackForType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return NotificationFeedback.success;
      case NotificationType.error:
        return NotificationFeedback.error;
      case NotificationType.warning:
        return NotificationFeedback.warning;
      case NotificationType.info:
        return NotificationFeedback.info;
    }
  }

  /// Dispose the notification system
  static void dispose() {
    _manager.dispose();
  }
}
