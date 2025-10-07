import 'package:flutter/material.dart';
import 'foundation_compat.dart';
import 'base_notification.dart';
import 'notification_types.dart';

/// A snackbar notification widget that appears at the bottom of the screen.
/// Snackbars are typically used for brief messages and can include action buttons.
/// They support swipe-to-dismiss functionality.
class SnackbarNotification extends StatelessWidget {
  /// The type of notification for semantic styling
  final NotificationType type;

  /// Main message content
  final String message;

  /// Optional custom icon widget
  final Widget? icon;

  /// Optional action button
  final NotificationAction? action;

  /// Position of the snackbar
  final SnackbarPosition position;

  /// Whether the notification can be dismissed manually
  final bool dismissible;

  /// Callback when notification is dismissed
  final VoidCallback? onDismiss;

  /// Custom content widget (overrides message)
  final Widget? content;

  /// Background color override
  final Color? backgroundColor;

  /// Text color override
  final Color? textColor;

  /// Icon color override
  final Color? iconColor;

  /// Width of the snackbar
  final double? width;

  /// Maximum width of the snackbar
  final double? maxWidth;

  /// Timing configuration
  final NotificationTiming timing;

  /// Feedback configuration
  final NotificationFeedback feedback;

  /// Swipe configuration
  final NotificationSwipeConfig swipeConfig;

  /// Whether to show close button
  final bool showCloseButton;

  /// Custom margin from screen edges
  final EdgeInsetsGeometry? margin;

  /// Custom elevation
  final double elevation;

  const SnackbarNotification({
    super.key,
    required this.type,
    required this.message,
    this.icon,
    this.action,
    this.position = SnackbarPosition.bottom,
    this.dismissible = true,
    this.onDismiss,
    this.content,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.width,
    this.maxWidth,
    this.timing = NotificationTiming.snackbar,
    this.feedback = const NotificationFeedback(),
    this.swipeConfig = NotificationSwipeConfig.defaultConfig,
    this.showCloseButton = false,
    this.margin,
    this.elevation = 6.0,
  });

  /// Creates a success snackbar notification
  static SnackbarNotification success({
    required String message,
    Widget? icon,
    NotificationAction? action,
    SnackbarPosition position = SnackbarPosition.bottom,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth,
    NotificationTiming timing = NotificationTiming.snackbar,
    NotificationSwipeConfig swipeConfig = NotificationSwipeConfig.defaultConfig,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
  }) {
    return SnackbarNotification(
      type: NotificationType.success,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: NotificationFeedback.success,
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates an error snackbar notification
  static SnackbarNotification error({
    required String message,
    Widget? icon,
    NotificationAction? action,
    SnackbarPosition position = SnackbarPosition.bottom,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth,
    NotificationTiming timing = NotificationTiming.snackbar,
    NotificationSwipeConfig swipeConfig = NotificationSwipeConfig.defaultConfig,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
  }) {
    return SnackbarNotification(
      type: NotificationType.error,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: NotificationFeedback.error,
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates a warning snackbar notification
  static SnackbarNotification warning({
    required String message,
    Widget? icon,
    NotificationAction? action,
    SnackbarPosition position = SnackbarPosition.bottom,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth,
    NotificationTiming timing = NotificationTiming.snackbar,
    NotificationSwipeConfig swipeConfig = NotificationSwipeConfig.defaultConfig,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
  }) {
    return SnackbarNotification(
      type: NotificationType.warning,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: NotificationFeedback.warning,
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates an info snackbar notification
  static SnackbarNotification info({
    required String message,
    Widget? icon,
    NotificationAction? action,
    SnackbarPosition position = SnackbarPosition.bottom,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? content,
    double? width,
    double? maxWidth,
    NotificationTiming timing = NotificationTiming.snackbar,
    NotificationSwipeConfig swipeConfig = NotificationSwipeConfig.defaultConfig,
    bool showCloseButton = false,
    EdgeInsetsGeometry? margin,
  }) {
    return SnackbarNotification(
      type: NotificationType.info,
      message: message,
      icon: icon,
      action: action,
      position: position,
      dismissible: dismissible,
      onDismiss: onDismiss,
      content: content,
      width: width,
      maxWidth: maxWidth,
      timing: timing,
      feedback: NotificationFeedback.info,
      swipeConfig: swipeConfig,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Get custom background color for snackbars (darker than toasts)
  Color _getSnackbarBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;

    switch (type) {
      case NotificationType.success:
        return UiColors.success700;
      case NotificationType.error:
        return UiColors.error700;
      case NotificationType.warning:
        return UiColors.warning600;
      case NotificationType.info:
        return UiColors.neutral800;
    }
  }

  /// Get custom text color for snackbars (light text on dark background)
  Color _getSnackbarTextColor() {
    if (textColor != null) return textColor!;

    switch (type) {
      case NotificationType.success:
        return UiColors.success50;
      case NotificationType.error:
        return UiColors.error50;
      case NotificationType.warning:
        return UiColors.warning50;
      case NotificationType.info:
        return UiColors.neutral50;
    }
  }

  /// Get custom icon color for snackbars
  Color _getSnackbarIconColor() {
    if (iconColor != null) return iconColor!;

    switch (type) {
      case NotificationType.success:
        return UiColors.success200;
      case NotificationType.error:
        return UiColors.error200;
      case NotificationType.warning:
        return UiColors.warning200;
      case NotificationType.info:
        return UiColors.neutral200;
    }
  }

  /// Get alignment based on position
  Alignment _getAlignment() {
    switch (position) {
      case SnackbarPosition.bottom:
        return Alignment.bottomCenter;
      case SnackbarPosition.top:
        return Alignment.topCenter;
    }
  }

  /// Get margin based on position
  EdgeInsetsGeometry _getPositionMargin() {
    const defaultMargin = UiSpacing.spacing4;

    if (margin != null) return margin!;

    switch (position) {
      case SnackbarPosition.bottom:
        return const EdgeInsets.only(
          bottom: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        );
      case SnackbarPosition.top:
        return const EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        );
    }
  }

  /// Get slide animation offset based on position
  Offset _getSlideOffset() {
    switch (position) {
      case SnackbarPosition.bottom:
        return const Offset(0, 1);
      case SnackbarPosition.top:
        return const Offset(0, -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _getAlignment(),
      child: BaseNotification(
        type: type,
        message: message,
        icon: icon,
        actions: action != null ? [action!] : [],
        dismissible: dismissible,
        onDismiss: onDismiss,
        content: content,
        backgroundColor: _getSnackbarBackgroundColor(),
        borderColor: Colors.transparent,
        textColor: _getSnackbarTextColor(),
        iconColor: _getSnackbarIconColor(),
        borderRadius: UiRadius.allSm,
        width: width,
        maxWidth: maxWidth,
        timing: timing,
        feedback: feedback,
        swipeConfig: swipeConfig,
        showCloseButton: showCloseButton,
        elevation: elevation,
        margin: _getPositionMargin(),
      ),
    );
  }
}

/// A widget that shows snackbar notifications in an overlay
class SnackbarOverlay extends StatefulWidget {
  /// The snackbar notification to show
  final SnackbarNotification snackbar;

  /// Animation controller for the overlay
  final AnimationController? animationController;

  /// Callback when the snackbar is dismissed
  final VoidCallback? onDismiss;

  const SnackbarOverlay({
    super.key,
    required this.snackbar,
    this.animationController,
    this.onDismiss,
  });

  @override
  State<SnackbarOverlay> createState() => _SnackbarOverlayState();
}

class _SnackbarOverlayState extends State<SnackbarOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.animationController ??
        AnimationController(
          duration: widget.snackbar.timing.animationDuration,
          vsync: this,
        );

    final slideOffset = widget.snackbar._getSlideOffset();

    _slideAnimation = Tween<Offset>(
      begin: slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.snackbar.timing.animationCurve,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.snackbar.timing.animationCurve,
    ));

    // Start animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.snackbar.timing.showDelay != null) {
        Future.delayed(widget.snackbar.timing.showDelay!, () {
          if (mounted) {
            _controller.forward();
          }
        });
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleDismiss() {
    _controller.reverse().then((_) {
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SnackbarNotification(
              type: widget.snackbar.type,
              message: widget.snackbar.message,
              icon: widget.snackbar.icon,
              action: widget.snackbar.action,
              position: widget.snackbar.position,
              dismissible: widget.snackbar.dismissible,
              onDismiss: _handleDismiss,
              content: widget.snackbar.content,
              backgroundColor: widget.snackbar.backgroundColor,
              textColor: widget.snackbar.textColor,
              iconColor: widget.snackbar.iconColor,
              width: widget.snackbar.width,
              maxWidth: widget.snackbar.maxWidth,
              timing: widget.snackbar.timing,
              feedback: widget.snackbar.feedback,
              swipeConfig: widget.snackbar.swipeConfig,
              showCloseButton: widget.snackbar.showCloseButton,
              margin: widget.snackbar.margin,
              elevation: widget.snackbar.elevation,
            ),
          ),
        );
      },
    );
  }
}
