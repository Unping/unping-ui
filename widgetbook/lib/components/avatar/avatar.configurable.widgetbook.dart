import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

Widget _buildBadgeChild(String? kind, Color iconColor) {
  switch (kind) {
    case 'mute':
      return Icon(Icons.volume_off, size: 12, color: iconColor);
    case 'star':
      return Icon(Icons.star, size: 12, color: iconColor);
    case 'none':
    default:
      return const SizedBox.shrink();
  }
}

@widgetbook.UseCase(
  name: 'ConfigurableAvatar',
  type: BaseAvatar,
  path: 'Components/Avatar/Configurable',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildConfigurableAvatar(BuildContext context) {
  // Avatar core knobs
  final avatarType = context.knobs.list(
    label: 'Type',
    options: ['image', 'initials', 'icon'],
    initialOption: 'image',
  );

  final avatarSize = context.knobs.list(
    label: 'Size',
    options: AvatarSize.values,
    labelBuilder: (v) => v.name.toUpperCase(),
    initialOption: AvatarSize.md,
  );

  final avatarShape = context.knobs.list(
    label: 'Shape',
    options: AvatarShape.values,
    labelBuilder: (v) => v.name,
    initialOption: AvatarShape.circle,
  );

  final overrideRadius = context.knobs.boolean(
    label: 'Override Border Radius',
    initialValue: false,
  );
  final double? borderRadiusOverride = overrideRadius
      ? context.knobs.double.slider(
          label: 'Border Radius',
          initialValue: 12.0,
          min: 0.0,
          max: 32.0,
        )
      : null;

  final bgColor = context.knobs.listOrNull(
    label: 'Background',
    options: [
      null,
      UiColors.neutral200,
      UiColors.neutral300,
      UiColors.primary500,
      UiColors.success500,
      UiColors.warning500,
      UiColors.error500,
    ],
    labelBuilder: (c) => c != null ? UiColors.getColorName(c) : 'Auto/Default',
  );

  final fgColor = context.knobs.listOrNull(
    label: 'Foreground',
    options: [
      null,
      UiColors.onPrimary,
      UiColors.neutral900,
      UiColors.neutral700,
    ],
    labelBuilder: (c) => c != null ? UiColors.getColorName(c) : 'Default',
  );

  final borderColor = context.knobs.listOrNull(
    label: 'Border Color',
    options: [
      null,
      UiColors.background,
      UiColors.neutral700,
      UiColors.primary500
    ],
    labelBuilder: (c) => c != null ? UiColors.getColorName(c) : 'None',
  );

  final borderWidth = context.knobs.double.slider(
    label: 'Border Width',
    initialValue: 0.0,
    min: 0.0,
    max: 6.0,
  );

  // Badge knobs
  final showBadge =
      context.knobs.boolean(label: 'Show Badge', initialValue: false);
  final badgeType = context.knobs.list(
    label: 'Badge Type',
    options: ['status', 'notification', 'custom-child'],
    initialOption: 'status',
  );

  final badgePosition = context.knobs.list(
    label: 'Badge Position',
    options: BadgePosition.values,
    initialOption: BadgePosition.bottomRight,
  );

  final badgeSize = context.knobs.double.slider(
    label: 'Badge Size',
    initialValue: 12.0,
    min: 8.0,
    max: 24.0,
  );

  final badgeStatus = context.knobs.list(
    label: 'Status',
    options: UserStatus.values,
    initialOption: UserStatus.online,
  );

  final badgeCount = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 1,
    max: 150,
  );

  final badgeChildKind = context.knobs.list(
    label: 'Custom Child',
    options: ['none', 'mute', 'star'],
    initialOption: 'mute',
  );

  final badgeBg = context.knobs.listOrNull(
    label: 'Badge Background',
    options: [
      null,
      UiColors.neutral700,
      UiColors.primary600,
      UiColors.success600,
      UiColors.error600
    ],
    labelBuilder: (c) => c != null ? UiColors.getColorName(c) : 'Default',
  );

  final badgeShowBorder =
      context.knobs.boolean(label: 'Badge Border', initialValue: true);
  final badgeBorderColor = context.knobs.list(
    label: 'Badge Border Color',
    options: [UiColors.background, UiColors.neutral900],
    initialOption: UiColors.background,
    labelBuilder: (c) => UiColors.getColorName(c),
  );

  // Build avatar according to knobs
  AvatarBadge? badge;
  if (showBadge) {
    switch (badgeType) {
      case 'notification':
        badge = AvatarBadge.notification(
          count: badgeCount,
          position: badgePosition,
          size: badgeSize,
          backgroundColor: badgeBg,
          showBorder: badgeShowBorder,
          borderColor: badgeBorderColor,
        );
        break;
      case 'custom-child':
        final child = _buildBadgeChild(badgeChildKind, UiColors.onPrimary);
        badge = AvatarBadge(
          position: badgePosition,
          size: badgeSize,
          backgroundColor: badgeBg ?? UiColors.neutral700,
          showBorder: badgeShowBorder,
          borderColor: badgeBorderColor,
          child: badgeChildKind == 'none' ? null : child,
        );
        break;
      case 'status':
      default:
        badge = AvatarBadge.status(
          status: badgeStatus,
          position: badgePosition,
          size: badgeSize,
          showBorder: badgeShowBorder,
          borderColor: badgeBorderColor,
        );
    }
  }

  Widget avatar;
  switch (avatarType) {
    case 'initials':
      final name =
          context.knobs.string(label: 'Name', initialValue: 'Jane Doe');
      avatar = Avatars.initials(
        name: name,
        size: avatarSize,
        shape: avatarShape,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        badge: badge,
        badgePosition: badgePosition,
        borderRadius: borderRadiusOverride,
      );
      break;
    case 'icon':
      final icon = context.knobs.list(
        label: 'Icon',
        options: [Icons.person, Icons.group, Icons.star],
        labelBuilder: (i) => i.codePoint.toString(),
        initialOption: Icons.person,
      );
      avatar = Avatars.icon(
        icon: icon,
        size: avatarSize,
        shape: avatarShape,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        badge: badge,
        badgePosition: badgePosition,
        borderRadius: borderRadiusOverride,
      );
      break;
    case 'image':
    default:
      final imageUrl = context.knobs.string(
        label: 'Image URL',
        initialValue:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=512',
      );
      avatar = Avatars.image(
        imageUrl: imageUrl,
        size: avatarSize,
        shape: avatarShape,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        badge: badge,
        badgePosition: badgePosition,
        borderRadius: borderRadiusOverride,
      );
  }

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'Configurable'],
    child: Row(
      children: [
        Container(padding: const EdgeInsets.all(16), child: avatar),
      ],
    ),
  );
}
