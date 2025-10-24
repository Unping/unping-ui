import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// Predefined avatar configurations matching common design patterns
class Avatars {
  /// Creates an image-based avatar with optional fallback
  ///
  /// Example:
  /// ```dart
  /// Avatars.image(
  ///   imageUrl: 'https://example.com/avatar.jpg',
  ///   size: AvatarSize.lg,
  ///   fallback: Avatars.initials(name: 'John Doe', size: AvatarSize.lg),
  /// )
  /// ```
  static BaseAvatar image({
    required String imageUrl,
    AvatarSize size = AvatarSize.md,
    AvatarShape shape = AvatarShape.circle,
    Widget? fallback,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0.0,
    AvatarBadge? badge,
    BadgePosition badgePosition = BadgePosition.bottomRight,
    String? semanticsLabel,
    double? borderRadius,
  }) {
    return BaseAvatar(
      imageUrl: imageUrl,
      size: size,
      shape: shape,
      fallback: fallback,
      backgroundColor: backgroundColor ?? UiColors.neutral300,
      foregroundColor: foregroundColor ?? UiColors.neutral600,
      borderColor: borderColor,
      borderWidth: borderWidth,
      badge: badge,
      badgePosition: badgePosition,
      semanticsLabel: semanticsLabel,
      borderRadius: borderRadius,
    );
  }

  /// Creates an initials-based avatar with auto-generated color
  ///
  /// Example:
  /// ```dart
  /// Avatars.initials(
  ///   name: 'Jane Smith',
  ///   size: AvatarSize.md,
  /// )
  /// ```
  static BaseAvatar initials({
    required String name,
    AvatarSize size = AvatarSize.md,
    AvatarShape shape = AvatarShape.circle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0.0,
    AvatarBadge? badge,
    BadgePosition badgePosition = BadgePosition.bottomRight,
    String? semanticsLabel,
    double? borderRadius,
    TextStyle? textStyle,
  }) {
    final initials = InitialsHelper.getInitials(name);
    final autoColor =
        backgroundColor ?? ColorGenerator.fromString(name.toLowerCase());

    return BaseAvatar(
      initials: initials,
      size: size,
      shape: shape,
      backgroundColor: autoColor,
      foregroundColor: foregroundColor ?? UiColors.onPrimary,
      borderColor: borderColor,
      borderWidth: borderWidth,
      badge: badge,
      badgePosition: badgePosition,
      semanticsLabel: semanticsLabel ?? '$name avatar',
      borderRadius: borderRadius,
      textStyle: textStyle,
    );
  }

  /// Creates an icon-based avatar for system users or placeholders
  ///
  /// Example:
  /// ```dart
  /// Avatars.icon(
  ///   icon: Icons.person,
  ///   size: AvatarSize.sm,
  /// )
  /// ```
  static BaseAvatar icon({
    required IconData icon,
    AvatarSize size = AvatarSize.md,
    AvatarShape shape = AvatarShape.circle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0.0,
    AvatarBadge? badge,
    BadgePosition badgePosition = BadgePosition.bottomRight,
    String? semanticsLabel,
    double? borderRadius,
  }) {
    return BaseAvatar(
      icon: icon,
      size: size,
      shape: shape,
      backgroundColor: backgroundColor ?? UiColors.neutral300,
      foregroundColor: foregroundColor ?? UiColors.neutral600,
      borderColor: borderColor,
      borderWidth: borderWidth,
      badge: badge,
      badgePosition: badgePosition,
      semanticsLabel: semanticsLabel,
      borderRadius: borderRadius,
    );
  }

  /// Creates an avatar group with stacked layout
  ///
  /// Example:
  /// ```dart
  /// Avatars.group(
  ///   avatars: [
  ///     Avatars.initials(name: 'Alice'),
  ///     Avatars.initials(name: 'Bob'),
  ///     Avatars.initials(name: 'Carol'),
  ///   ],
  ///   maxVisible: 3,
  ///   onMoreTap: () {},
  /// )
  /// ```
  static AvatarGroup group({
    required List<Widget> avatars,
    int maxVisible = 3,
    AvatarSize size = AvatarSize.md,
    double? spacing,
    Color? moreBackgroundColor,
    Color? moreTextColor,
    Color? borderColor,
    double borderWidth = 2.0,
    VoidCallback? onMoreTap,
    String? semanticsLabel,
  }) {
    return AvatarGroup(
      avatars: avatars,
      maxVisible: maxVisible,
      size: size,
      spacing: spacing ?? -8.0,
      moreBackgroundColor: moreBackgroundColor ?? UiColors.neutral600,
      moreTextColor: moreTextColor ?? UiColors.onPrimary,
      borderColor: borderColor ?? UiColors.background,
      borderWidth: borderWidth,
      onMoreTap: onMoreTap,
      semanticsLabel: semanticsLabel,
    );
  }
}
