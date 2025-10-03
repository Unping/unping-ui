import 'package:flutter/material.dart';
import '../../foundation/ui_spacing.dart';

/// Shared default margin for notifications (toast/snackbar)
const kNotificationDefaultMargin = UiSpacing.spacing4;

/// Returns the margin for a notification based on position and optional override.
EdgeInsetsGeometry getNotificationMargin(
  ToastPosition position,
  EdgeInsetsGeometry? margin,
) {
  const defaultMargin = kNotificationDefaultMargin;
  if (margin != null) return margin;
  switch (position) {
    case ToastPosition.topCenter:
      return EdgeInsets.only(
        top: defaultMargin,
        left: defaultMargin,
        right: defaultMargin,
      );
    case ToastPosition.topLeft:
      return EdgeInsets.only(
        top: defaultMargin,
        left: defaultMargin,
      );
    case ToastPosition.topRight:
      return EdgeInsets.only(
        top: defaultMargin,
        right: defaultMargin,
      );
    case ToastPosition.bottomCenter:
      return EdgeInsets.only(
        bottom: defaultMargin,
        left: defaultMargin,
        right: defaultMargin,
      );
    case ToastPosition.bottomLeft:
      return EdgeInsets.only(
        bottom: defaultMargin,
        left: defaultMargin,
      );
    case ToastPosition.bottomRight:
      return EdgeInsets.only(
        bottom: defaultMargin,
        right: defaultMargin,
      );
    case ToastPosition.center:
      return EdgeInsets.all(defaultMargin);
  }
}

/// Type of notification for semantic meaning and styling
enum NotificationType {
  /// Success notification - for positive outcomes and confirmations
  success,

  /// Error notification - for errors and failures
  error,

  /// Warning notification - for warnings and cautions
  warning,

  /// Info notification - for general information
  info,
}

/// Position of toast notifications on screen
enum ToastPosition {
  /// Top of the screen, centered
  topCenter,

  /// Top-left corner of the screen
  topLeft,

  /// Top-right corner of the screen
  topRight,

  /// Bottom of the screen, centered
  bottomCenter,

  /// Bottom-left corner of the screen
  bottomLeft,

  /// Bottom-right corner of the screen
  bottomRight,

  /// Center of the screen
  center,
}

/// Position of snackbar notifications
enum SnackbarPosition {
  /// Bottom of the screen (default)
  bottom,

  /// Top of the screen
  top,
}

/// Configuration for notification timing and behavior
class NotificationTiming {
  /// Duration before auto-dismiss (null means no auto-dismiss)
  final Duration? duration;

  /// Animation duration for show/hide transitions
  final Duration animationDuration;

  /// Animation curve for transitions
  final Curve animationCurve;

  /// Delay before showing the notification
  final Duration? showDelay;

  /// Whether to show a progress indicator for auto-dismiss
  final bool showProgress;

  const NotificationTiming({
    this.duration,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.showDelay,
    this.showProgress = false,
  });

  /// Default timing for toast notifications
  static const toast = NotificationTiming(
    duration: Duration(seconds: 4),
    showProgress: true,
  );

  /// Default timing for snackbar notifications
  static const snackbar = NotificationTiming(
    duration: Duration(seconds: 6),
    showProgress: false,
  );

  /// Default timing for alert notifications (no auto-dismiss)
  static const alert = NotificationTiming(
    duration: null,
    showProgress: false,
  );

  /// Default timing for persistent notifications
  static const persistent = NotificationTiming(
    duration: null,
    showProgress: false,
  );
}

/// Action button configuration for notifications
class NotificationAction {
  /// Label text for the action button
  final String label;

  /// Callback when action is pressed
  final VoidCallback onPressed;

  /// Whether this action dismisses the notification
  final bool dismissOnTap;

  /// Style of the action button
  final NotificationActionStyle style;

  const NotificationAction({
    required this.label,
    required this.onPressed,
    this.dismissOnTap = true,
    this.style = NotificationActionStyle.text,
  });
}

/// Style of notification action buttons
enum NotificationActionStyle {
  /// Text button style
  text,

  /// Filled button style
  filled,

  /// Outlined button style
  outlined,
}

/// Configuration for notification sounds and haptics
class NotificationFeedback {
  /// Whether to play a sound
  final bool playSound;

  /// Whether to provide haptic feedback
  final bool hapticFeedback;

  /// Type of haptic feedback
  final HapticFeedbackType hapticType;

  const NotificationFeedback({
    this.playSound = false,
    this.hapticFeedback = false,
    this.hapticType = HapticFeedbackType.lightImpact,
  });

  /// Default feedback for success notifications
  static const success = NotificationFeedback(
    hapticFeedback: true,
    hapticType: HapticFeedbackType.lightImpact,
  );

  /// Default feedback for error notifications
  static const error = NotificationFeedback(
    hapticFeedback: true,
    hapticType: HapticFeedbackType.mediumImpact,
  );

  /// Default feedback for warning notifications
  static const warning = NotificationFeedback(
    hapticFeedback: true,
    hapticType: HapticFeedbackType.lightImpact,
  );

  /// Default feedback for info notifications
  static const info = NotificationFeedback(
    hapticFeedback: false,
  );
}

/// Type of haptic feedback
enum HapticFeedbackType {
  /// Light haptic feedback
  lightImpact,

  /// Medium haptic feedback
  mediumImpact,

  /// Heavy haptic feedback
  heavyImpact,

  /// Selection haptic feedback
  selectionClick,
}

/// Priority of notifications for queue management
enum NotificationPriority {
  /// Low priority - can be replaced by higher priority notifications
  low,

  /// Normal priority - default priority
  normal,

  /// High priority - shown immediately, may interrupt other notifications
  high,

  /// Critical priority - always shown, cannot be interrupted
  critical,
}

/// Configuration for notification swipe gestures
class NotificationSwipeConfig {
  /// Whether swipe-to-dismiss is enabled
  final bool enabled;

  /// Direction of swipe gesture
  final DismissDirection direction;

  /// Threshold for triggering dismiss (0.0 to 1.0)
  final double threshold;

  /// Whether to show visual feedback during swipe
  final bool showBackground;

  /// Color of swipe background
  final Color? backgroundColor;

  /// Icon to show during swipe
  final IconData? icon;

  const NotificationSwipeConfig({
    this.enabled = true,
    this.direction = DismissDirection.horizontal,
    this.threshold = 0.4,
    this.showBackground = true,
    this.backgroundColor,
    this.icon,
  });

  /// Default swipe config for notifications
  static const defaultConfig = NotificationSwipeConfig();

  /// Disabled swipe config
  static const disabled = NotificationSwipeConfig(enabled: false);
}
