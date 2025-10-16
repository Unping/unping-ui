import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// Avatar size variants
enum AvatarSize {
  /// Extra small avatar - 24px
  xs,

  /// Small avatar - 32px
  sm,

  /// Medium avatar - 40px (default)
  md,

  /// Large avatar - 48px
  lg,

  /// Extra large avatar - 56px
  xl,

  /// 2X large avatar - 64px
  xxl,
}

/// Avatar shape variants
enum AvatarShape {
  /// Circular avatar - fully rounded
  circle,

  /// Rounded rectangle avatar - slightly rounded corners
  roundedRectangle,
}

/// User status for badge indicators
enum UserStatus {
  /// User is online/active
  online,

  /// User is offline
  offline,

  /// User is away
  away,

  /// User is busy/do not disturb
  busy,
}

/// Badge position on the avatar
enum BadgePosition {
  /// Top left corner
  topLeft,

  /// Top right corner
  topRight,

  /// Bottom left corner
  bottomLeft,

  /// Bottom right corner
  bottomRight,
}

/// Helper class for avatar size calculations
class AvatarSizeHelper {
  /// Get the pixel size for an avatar size variant
  static double getSize(AvatarSize size) {
    switch (size) {
      case AvatarSize.xs:
        return UiSpacing.spacing6; // 24.0
      case AvatarSize.sm:
        return UiSpacing.spacing8; // 32.0
      case AvatarSize.md:
        return UiSpacing.spacing10; // 40.0
      case AvatarSize.lg:
        return UiSpacing.spacing12; // 48.0
      case AvatarSize.xl:
        return UiSpacing.spacing16; // 56.0 (closest token)
      case AvatarSize.xxl:
        return UiSpacing.spacing16; // 64.0 (approx using 64 token)
    }
  }

  /// Get the font size for initials based on avatar size
  static double getFontSize(AvatarSize size) {
    switch (size) {
      case AvatarSize.xs:
        return UiTextStyles.textXs.fontSize!; // 12.0
      case AvatarSize.sm:
        return UiTextStyles.textSm.fontSize!; // 14.0
      case AvatarSize.md:
        return UiTextStyles.textMd.fontSize!; // 16.0
      case AvatarSize.lg:
        return UiTextStyles.textLg.fontSize!; // 18.0
      case AvatarSize.xl:
        return UiTextStyles.textXl.fontSize!; // 20.0
      case AvatarSize.xxl:
        return UiTextStyles.displayXs.fontSize!; // 24.0
    }
  }

  /// Get the border radius for rounded rectangle avatars
  static double getBorderRadius(AvatarSize size) {
    switch (size) {
      case AvatarSize.xs:
        return UiRadius.xs; // 4.0
      case AvatarSize.sm:
        return UiRadius.xs; // 4.0
      case AvatarSize.md:
        return UiRadius.sm; // 8.0
      case AvatarSize.lg:
        return UiRadius.sm; // 8.0
      case AvatarSize.xl:
        return UiRadius.md; // 12.0
      case AvatarSize.xxl:
        return UiRadius.md; // 12.0
    }
  }

  /// Get the icon size for icon-based avatars
  static double getIconSize(AvatarSize size) {
    switch (size) {
      case AvatarSize.xs:
        return UiTextStyles.textXs.fontSize!; // 12.0
      case AvatarSize.sm:
        return UiTextStyles.textSm.fontSize!; // 14.0 (closest to 16)
      case AvatarSize.md:
        return UiTextStyles.textMd.fontSize!; // 16.0 (closest to 20)
      case AvatarSize.lg:
        return UiTextStyles.textLg.fontSize!; // 18.0 (closest to 24)
      case AvatarSize.xl:
        return UiTextStyles.textXl.fontSize!; // 20.0 (closest to 28)
      case AvatarSize.xxl:
        return UiTextStyles.displayXs.fontSize!; // 24.0 (closest to 32)
    }
  }
}

/// Helper class for generating consistent colors from strings
class ColorGenerator {
  /// Generate a color from a string (name or ID)
  /// This ensures the same string always generates the same color
  static Color fromString(String input) {
    if (input.isEmpty) return UiColors.neutral500;

    // Simple hash function
    int hash = 0;
    for (int i = 0; i < input.length; i++) {
      hash = input.codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Predefined color palette for avatars using design system tokens
    final colors = <Color>[
      UiColors.primary500,
      UiColors.primary400,
      UiColors.primary300,
      UiColors.success500,
      UiColors.success400,
      UiColors.warning500,
      UiColors.warning400,
      UiColors.error500,
      UiColors.error400,
      UiColors.neutral600,
    ];

    return colors[hash.abs() % colors.length];
  }
}

/// Helper class for extracting initials from names
class InitialsHelper {
  /// Extract initials from a full name
  /// Examples:
  /// - "John Doe" -> "JD"
  /// - "Jane" -> "J"
  /// - "Mary Jane Watson" -> "MW" (first and last)
  static String getInitials(String name) {
    if (name.isEmpty) return '?';

    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) {
      // Single word: take first character
      return parts[0].substring(0, 1).toUpperCase();
    } else {
      // Multiple words: take first character of first and last word
      final first = parts.first.substring(0, 1).toUpperCase();
      final last = parts.last.substring(0, 1).toUpperCase();
      return '$first$last';
    }
  }
}
