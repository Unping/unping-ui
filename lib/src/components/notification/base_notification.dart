import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'foundation_compat.dart';
import 'notification_types.dart';

/// A base notification widget that provides the foundation for all notification types.
/// Supports customizable styling, actions, icons, and animations.
class BaseNotification extends StatefulWidget {
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

  /// Border radius override
  final BorderRadius? borderRadius;

  /// Custom padding
  final EdgeInsetsGeometry? padding;

  /// Custom margin
  final EdgeInsetsGeometry? margin;

  /// Elevation for shadow
  final double elevation;

  /// Width of the notification
  final double? width;

  /// Maximum width of the notification
  final double? maxWidth;

  /// Timing configuration
  final NotificationTiming timing;

  /// Feedback configuration
  final NotificationFeedback feedback;

  /// Swipe configuration
  final NotificationSwipeConfig swipeConfig;

  /// Whether to show close button
  final bool showCloseButton;

  /// Animation controller for external control
  final AnimationController? animationController;

  /// Whether to show progress indicator
  final bool showProgress;

  /// Progress value (0.0 to 1.0) for custom progress
  final double? progress;

  const BaseNotification({
    super.key,
    required this.type,
    required this.message,
    this.title,
    this.icon,
    this.actions = const [],
    this.dismissible = true,
    this.onDismiss,
    this.content,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation = 4.0,
    this.width,
    this.maxWidth,
    this.timing = NotificationTiming.toast,
    this.feedback = const NotificationFeedback(),
    this.swipeConfig = NotificationSwipeConfig.defaultConfig,
    this.showCloseButton = true,
    this.animationController,
    this.showProgress = false,
    this.progress,
  });

  @override
  State<BaseNotification> createState() => _BaseNotificationState();
}

class _BaseNotificationState extends State<BaseNotification>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Use external controller or create our own
    _controller = widget.animationController ??
        AnimationController(
          duration: widget.timing.animationDuration,
          vsync: this,
        );

    // Progress controller for auto-dismiss timing
    _progressController = AnimationController(
      duration: widget.timing.duration ?? Duration.zero,
      vsync: this,
    );

    // Setup animations
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.timing.animationCurve,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.timing.animationCurve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.timing.animationCurve,
    ));

    // Start entrance animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.timing.showDelay != null) {
        Future.delayed(widget.timing.showDelay!, () {
          if (mounted) {
            _controller.forward();
            _startAutoTimer();
            _provideFeedback();
          }
        });
      } else {
        _controller.forward();
        _startAutoTimer();
        _provideFeedback();
      }
    });
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    _progressController.dispose();
    super.dispose();
  }

  void _startAutoTimer() {
    if (widget.timing.duration != null &&
        widget.timing.duration! > Duration.zero) {
      _progressController.forward().then((_) {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  void _provideFeedback() {
    if (widget.feedback.hapticFeedback) {
      switch (widget.feedback.hapticType) {
        case HapticFeedbackType.lightImpact:
          HapticFeedback.lightImpact();
          break;
        case HapticFeedbackType.mediumImpact:
          HapticFeedback.mediumImpact();
          break;
        case HapticFeedbackType.heavyImpact:
          HapticFeedback.heavyImpact();
          break;
        case HapticFeedbackType.selectionClick:
          HapticFeedback.selectionClick();
          break;
      }
    }
  }

  void _dismiss() {
    if (widget.onDismiss != null) {
      widget.onDismiss!();
    }
  }

  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    switch (widget.type) {
      case NotificationType.success:
        return UiColors.success50;
      case NotificationType.error:
        return UiColors.error50;
      case NotificationType.warning:
        return UiColors.warning50;
      case NotificationType.info:
        return UiColors.primary50;
    }
  }

  Color _getBorderColor() {
    if (widget.borderColor != null) return widget.borderColor!;

    switch (widget.type) {
      case NotificationType.success:
        return UiColors.success200;
      case NotificationType.error:
        return UiColors.error200;
      case NotificationType.warning:
        return UiColors.warning200;
      case NotificationType.info:
        return UiColors.primary200;
    }
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.type) {
      case NotificationType.success:
        return UiColors.success800;
      case NotificationType.error:
        return UiColors.error800;
      case NotificationType.warning:
        return UiColors.warning800;
      case NotificationType.info:
        return UiColors.primary800;
    }
  }

  Color _getIconColor() {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.type) {
      case NotificationType.success:
        return UiColors.success600;
      case NotificationType.error:
        return UiColors.error600;
      case NotificationType.warning:
        return UiColors.warning600;
      case NotificationType.info:
        return UiColors.primary600;
    }
  }

  Widget _getDefaultIcon() {
    switch (widget.type) {
      case NotificationType.success:
        return Icon(
          Icons.check_circle,
          color: _getIconColor(),
          size: 20,
        );
      case NotificationType.error:
        return Icon(
          Icons.error,
          color: _getIconColor(),
          size: 20,
        );
      case NotificationType.warning:
        return Icon(
          Icons.warning,
          color: _getIconColor(),
          size: 20,
        );
      case NotificationType.info:
        return Icon(
          Icons.info,
          color: _getIconColor(),
          size: 20,
        );
    }
  }

  Widget _buildContent() {
    if (widget.content != null) {
      return widget.content!;
    }

    final textColor = _getTextColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: UiTextStyles.textMdSemibold.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 4.0),
        ],
        Text(
          widget.message,
          style: UiTextStyles.textSm.copyWith(
            color: textColor,
          ),
        ),
        if (widget.actions.isNotEmpty) ...[
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            children: widget.actions
                .map((action) => _buildActionButton(action))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(NotificationAction action) {
    switch (action.style) {
      case NotificationActionStyle.text:
        return TextButton(
          onPressed: () {
            action.onPressed();
            if (action.dismissOnTap) {
              _dismiss();
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: _getIconColor(),
            padding: const EdgeInsets.symmetric(
              horizontal: UiSpacing.spacing3,
              vertical: UiSpacing.spacing1,
            ),
          ),
          child: Text(action.label),
        );
      case NotificationActionStyle.filled:
        return ElevatedButton(
          onPressed: () {
            action.onPressed();
            if (action.dismissOnTap) {
              _dismiss();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _getIconColor(),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: UiSpacing.spacing3,
              vertical: UiSpacing.spacing1,
            ),
          ),
          child: Text(action.label),
        );
      case NotificationActionStyle.outlined:
        return OutlinedButton(
          onPressed: () {
            action.onPressed();
            if (action.dismissOnTap) {
              _dismiss();
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: _getIconColor(),
            side: BorderSide(color: _getIconColor()),
            padding: const EdgeInsets.symmetric(
              horizontal: UiSpacing.spacing3,
              vertical: UiSpacing.spacing1,
            ),
          ),
          child: Text(action.label),
        );
    }
  }

  Widget _buildProgressIndicator() {
    if (!widget.showProgress && !widget.timing.showProgress) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        final progress = widget.progress ?? (1.0 - _progressController.value);

        return Container(
          height: 2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(_getIconColor()),
          ),
        );
      },
    );
  }

  Widget _buildNotification() {
    final borderRadius =
        widget.borderRadius ?? const BorderRadius.all(Radius.circular(8.0));
    final padding = widget.padding ?? const EdgeInsets.all(16.0);

    Widget notification = Container(
      width: widget.width,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth!)
          : null,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: borderRadius,
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
        boxShadow: widget.elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: widget.elevation * 2,
                  offset: Offset(0, widget.elevation),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                widget.icon ?? _getDefaultIcon(),
                const SizedBox(width: 12.0),
                // Content
                Expanded(child: _buildContent()),
                // Close button
                if (widget.showCloseButton && widget.dismissible) ...[
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: _dismiss,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: _getTextColor().withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          _buildProgressIndicator(),
        ],
      ),
    );

    // Wrap in dismissible if swipe is enabled
    if (widget.swipeConfig.enabled && widget.dismissible) {
      notification = Dismissible(
        key: UniqueKey(),
        direction: widget.swipeConfig.direction,
        dismissThresholds: {
          DismissDirection.startToEnd: widget.swipeConfig.threshold,
          DismissDirection.endToStart: widget.swipeConfig.threshold,
        },
        onDismissed: (direction) => _dismiss(),
        background: widget.swipeConfig.showBackground
            ? Container(
                decoration: BoxDecoration(
                  color: widget.swipeConfig.backgroundColor ??
                      _getIconColor().withOpacity(0.1),
                  borderRadius: borderRadius,
                ),
                child: widget.swipeConfig.icon != null
                    ? Icon(
                        widget.swipeConfig.icon,
                        color: _getIconColor(),
                      )
                    : null,
              )
            : null,
        child: notification,
      );
    }

    return notification;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: _buildNotification(),
            ),
          ),
        );
      },
    );
  }
}
