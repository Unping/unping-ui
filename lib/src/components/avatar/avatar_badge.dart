import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A badge widget for showing status indicators on avatars
class AvatarBadge extends StatelessWidget {
  /// The status to display
  final UserStatus? status;

  /// Custom notification count (alternative to status)
  final int? notificationCount;

  /// Position of the badge on the avatar
  final BadgePosition position;

  /// Size of the badge
  final double size;

  /// Optional custom child to render inside the badge (e.g., mute icon)
  final Widget? child;

  /// Custom background color (overrides status color)
  final Color? backgroundColor;

  /// Whether to show a border around the badge
  final bool showBorder;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  const AvatarBadge({
    super.key,
    this.status,
    this.notificationCount,
    this.child,
    this.position = BadgePosition.bottomRight,
    this.size = 12.0,
    this.backgroundColor,
    this.showBorder = true,
    this.borderColor = UiColors.background,
    this.borderWidth = 2.0,
  }) : assert(
          status != null || notificationCount != null || child != null,
          'Provide status, notificationCount, or child for AvatarBadge',
        );

  /// Factory constructor for status badges
  factory AvatarBadge.status({
    required UserStatus status,
    BadgePosition position = BadgePosition.bottomRight,
    double? size,
    bool showBorder = true,
    Color borderColor = UiColors.background,
  }) {
    return AvatarBadge(
      status: status,
      position: position,
      size: size ?? 12.0,
      showBorder: showBorder,
      borderColor: borderColor,
    );
  }

  /// Factory constructor for notification count badges
  factory AvatarBadge.notification({
    required int count,
    BadgePosition position = BadgePosition.topRight,
    double? size,
    Color? backgroundColor,
    bool showBorder = true,
    Color borderColor = UiColors.background,
  }) {
    return AvatarBadge(
      notificationCount: count,
      position: position,
      size: size ?? 16.0,
      backgroundColor: backgroundColor,
      showBorder: showBorder,
      borderColor: borderColor,
    );
  }

  Color _getStatusColor() {
    if (backgroundColor != null) return backgroundColor!;

    if (status != null) {
      switch (status!) {
        case UserStatus.online:
          return UiColors.success500;
        case UserStatus.offline:
          return UiColors.neutral400;
        case UserStatus.away:
          return UiColors.warning400;
        case UserStatus.busy:
          return UiColors.error500;
      }
    }

    return UiColors.error500; // Default for notifications
  }

  @override
  Widget build(BuildContext context) {
    if (notificationCount != null) {
      // Notification badge with count
      return Semantics(
        label:
            'Notifications: ${notificationCount! > 99 ? '99+' : notificationCount}',
        child: Container(
          constraints: BoxConstraints(
            minWidth: size,
            minHeight: size,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(size / 2),
            border: showBorder
                ? Border.all(color: borderColor, width: borderWidth)
                : null,
          ),
          child: Center(
            child: Text(
              notificationCount! > 99 ? '99+' : notificationCount.toString(),
              style: UiTextStyles.textXs.copyWith(
                color: UiColors.onPrimary,
                fontSize: size * 0.6,
                fontWeight: UiTextStyles.bold,
              ),
            ),
          ),
        ),
      );
    }

    if (child != null) {
      // Custom child badge inside a circular container
      return Semantics(
        label: 'Avatar badge',
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _getStatusColor(),
            shape: BoxShape.circle,
            border: showBorder
                ? Border.all(color: borderColor, width: borderWidth)
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
            child: SizedBox(
              width: size * 0.7,
              height: size * 0.7,
              child: FittedBox(
                fit: BoxFit.contain,
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    // Status dot badge
    return Semantics(
      label: _statusSemanticsLabel(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _getStatusColor(),
          shape: BoxShape.circle,
          border: showBorder
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
        ),
      ),
    );
  }

  String _statusSemanticsLabel() {
    if (status == null) return 'Avatar badge';
    switch (status!) {
      case UserStatus.online:
        return 'Status: online';
      case UserStatus.offline:
        return 'Status: offline';
      case UserStatus.away:
        return 'Status: away';
      case UserStatus.busy:
        return 'Status: busy';
    }
  }
}
