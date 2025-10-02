import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

/// A toast notification widget that appears as a floating overlay.
/// Toasts are typically positioned at the top or corners of the screen
/// and auto-dismiss after a specified duration.
class ToastNotification extends StatelessWidget {
  /// The type of notification for semantic styling
  final NotificationType type;

  /// Optional title text
  final String? title;

  /// Main message content
  final String message;

  /// Optional custom icon widget
  final Widget? icon;

  /// List of action buttons
  final List<NotificationAction> actions;

  /// Position of the toast on screen
  final ToastPosition position;

  /// Whether the notification can be dismissed manually
  final bool dismissible;

  /// Callback when notification is dismissed
  final VoidCallback? onDismiss;

  /// Custom content widget (overrides title/message)
  final Widget? content;

  /// Background color override
  final Color? backgroundColor;

  /// Border color override
  final Color? borderColor;

  /// Text color override
  final Color? textColor;

  /// Icon color override
  final Color? iconColor;

  /// Width of the toast
  final double? width;

  /// Maximum width of the toast
  final double? maxWidth;

  /// Timing configuration
  final NotificationTiming timing;

  /// Feedback configuration
  final NotificationFeedback feedback;

  /// Whether to show close button
  final bool showCloseButton;

  /// Custom elevation
  final double elevation;

  /// Custom margin from screen edges
  final EdgeInsetsGeometry? margin;

  const ToastNotification({
    super.key,
    required this.type,
    required this.message,
    this.title,
    this.icon,
    this.actions = const [],
    this.position = ToastPosition.topCenter,
    this.dismissible = true,
    this.onDismiss,
    this.content,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.width,
    this.maxWidth = 400,
    this.timing = NotificationTiming.toast,
    this.feedback = const NotificationFeedback(),
    this.showCloseButton = true,
    this.elevation = 8.0,
    this.margin,
  });

  /// Creates a success toast notification
  static ToastNotification success({
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
    NotificationTiming timing = NotificationTiming.toast,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
  }) {
    return ToastNotification(
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
      timing: timing,
      feedback: NotificationFeedback.success,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates an error toast notification
  static ToastNotification error({
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
    NotificationTiming timing = NotificationTiming.toast,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
  }) {
    return ToastNotification(
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
      timing: timing,
      feedback: NotificationFeedback.error,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates a warning toast notification
  static ToastNotification warning({
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
    NotificationTiming timing = NotificationTiming.toast,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
  }) {
    return ToastNotification(
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
      timing: timing,
      feedback: NotificationFeedback.warning,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Creates an info toast notification
  static ToastNotification info({
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
    NotificationTiming timing = NotificationTiming.toast,
    bool showCloseButton = true,
    EdgeInsetsGeometry? margin,
  }) {
    return ToastNotification(
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
      timing: timing,
      feedback: NotificationFeedback.info,
      showCloseButton: showCloseButton,
      margin: margin,
    );
  }

  /// Get alignment based on position
  Alignment _getAlignment() {
    switch (position) {
      case ToastPosition.topCenter:
        return Alignment.topCenter;
      case ToastPosition.topLeft:
        return Alignment.topLeft;
      case ToastPosition.topRight:
        return Alignment.topRight;
      case ToastPosition.bottomCenter:
        return Alignment.bottomCenter;
      case ToastPosition.bottomLeft:
        return Alignment.bottomLeft;
      case ToastPosition.bottomRight:
        return Alignment.bottomRight;
      case ToastPosition.center:
        return Alignment.center;
    }
  }

  /// Get margin based on position
  EdgeInsetsGeometry _getPositionMargin() {
    const defaultMargin = UiSpacing.spacing4;

    if (margin != null) return margin!;

    switch (position) {
      case ToastPosition.topCenter:
        return const EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        );
      case ToastPosition.topLeft:
        return const EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
        );
      case ToastPosition.topRight:
        return const EdgeInsets.only(
          top: defaultMargin,
          right: defaultMargin,
        );
      case ToastPosition.bottomCenter:
        return const EdgeInsets.only(
          bottom: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        );
      case ToastPosition.bottomLeft:
        return const EdgeInsets.only(
          bottom: defaultMargin,
          left: defaultMargin,
        );
      case ToastPosition.bottomRight:
        return const EdgeInsets.only(
          bottom: defaultMargin,
          right: defaultMargin,
        );
      case ToastPosition.center:
        return const EdgeInsets.all(defaultMargin);
    }
  }

  /// Get slide animation offset based on position
  Offset _getSlideOffset() {
    switch (position) {
      case ToastPosition.topCenter:
      case ToastPosition.topLeft:
      case ToastPosition.topRight:
        return const Offset(0, -1);
      case ToastPosition.bottomCenter:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        return const Offset(0, 1);
      case ToastPosition.center:
        return const Offset(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _getAlignment(),
      child: BaseNotification(
        type: type,
        title: title,
        message: message,
        icon: icon,
        actions: actions,
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
        feedback: feedback,
        showCloseButton: showCloseButton,
        elevation: elevation,
        margin: _getPositionMargin(),
        // Disable swipe for toast - we'll handle positioning differently
        swipeConfig: const NotificationSwipeConfig(enabled: false),
      ),
    );
  }
}

/// A widget that shows toast notifications in an overlay
class ToastOverlay extends StatefulWidget {
  /// The toast notification to show
  final ToastNotification toast;

  /// Animation controller for the overlay
  final AnimationController? animationController;

  /// Callback when the toast is dismissed
  final VoidCallback? onDismiss;

  const ToastOverlay({
    super.key,
    required this.toast,
    this.animationController,
    this.onDismiss,
  });

  @override
  State<ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<ToastOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.animationController ??
        AnimationController(
          duration: widget.toast.timing.animationDuration,
          vsync: this,
        );

    final slideOffset = widget.toast._getSlideOffset();

    _slideAnimation = Tween<Offset>(
      begin: slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.toast.timing.animationCurve,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.toast.timing.animationCurve,
    ));

    // Start animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.toast.timing.showDelay != null) {
        Future.delayed(widget.toast.timing.showDelay!, () {
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
            child: ToastNotification(
              type: widget.toast.type,
              title: widget.toast.title,
              message: widget.toast.message,
              icon: widget.toast.icon,
              actions: widget.toast.actions,
              position: widget.toast.position,
              dismissible: widget.toast.dismissible,
              onDismiss: _handleDismiss,
              content: widget.toast.content,
              backgroundColor: widget.toast.backgroundColor,
              borderColor: widget.toast.borderColor,
              textColor: widget.toast.textColor,
              iconColor: widget.toast.iconColor,
              width: widget.toast.width,
              maxWidth: widget.toast.maxWidth,
              timing: widget.toast.timing,
              feedback: widget.toast.feedback,
              showCloseButton: widget.toast.showCloseButton,
              elevation: widget.toast.elevation,
              margin: widget.toast.margin,
            ),
          ),
        );
      },
    );
  }
}
