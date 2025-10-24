import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

const imageUrl =
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2070';

@UseCase(
  name: 'Image Avatars',
  type: BaseAvatar,
  path: 'Components/Avatar/Showcase',
  designLink: 'https://www.figma.com/community/file/1545817431010952080',
)
Widget imageAvatars(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'Image'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle shape - all sizes
        const SizedBox(height: 16),
        Text(
          'Circle Shape',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xs,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.sm,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.md,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xl,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xxl,
                shape: AvatarShape.circle,
              ),
            ),
          ],
        ),
        // Rounded rectangle shape - all sizes
        const SizedBox(height: 24),
        Text(
          'Rounded Rectangle Shape',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xs,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.sm,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.md,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xl,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xxl,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
          ],
        ),
        // With borders
        const SizedBox(height: 24),
        Text(
          'With Borders',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.md,
                shape: AvatarShape.circle,
                borderColor: UiColors.primary500,
                borderWidth: 2.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                shape: AvatarShape.circle,
                borderColor: UiColors.success500,
                borderWidth: 3.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xl,
                shape: AvatarShape.roundedRectangle,
                borderColor: UiColors.warning500,
                borderWidth: 3.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@UseCase(
  name: 'Initials Avatars',
  type: BaseAvatar,
  path: 'Components/Avatar/Showcase',
  designLink: 'https://www.figma.com/community/file/1545817431010952080',
)
Widget initialsAvatars(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'Initials'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // All sizes with auto-generated colors
        const SizedBox(height: 16),
        Text(
          'Auto-Generated Colors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'John Doe',
                size: AvatarSize.xs,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Jane Smith',
                size: AvatarSize.sm,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Bob Johnson',
                size: AvatarSize.md,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Alice Williams',
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Charlie Brown',
                size: AvatarSize.xl,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Diana Prince',
                size: AvatarSize.xxl,
              ),
            ),
          ],
        ),
        // Different shapes
        const SizedBox(height: 24),
        Text(
          'Different Shapes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Michael Scott',
                size: AvatarSize.lg,
                shape: AvatarShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Pam Beesly',
                size: AvatarSize.lg,
                shape: AvatarShape.roundedRectangle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Jim Halpert',
                size: AvatarSize.lg,
                shape: AvatarShape.circle,
              ),
            ),
          ],
        ),
        // Custom colors
        const SizedBox(height: 24),
        Text(
          'Custom Colors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Emma Watson',
                size: AvatarSize.lg,
                backgroundColor: UiColors.primary600,
                foregroundColor: UiColors.onPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Ryan Reynolds',
                size: AvatarSize.lg,
                backgroundColor: UiColors.success600,
                foregroundColor: UiColors.onPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Taylor Swift',
                size: AvatarSize.lg,
                backgroundColor: UiColors.error600,
                foregroundColor: UiColors.onPrimary,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@UseCase(
  name: 'Icon Avatars',
  type: BaseAvatar,
  path: 'Components/Avatar/Showcase',
  designLink: 'https://www.figma.com/community/file/1545817431010952080',
)
Widget iconAvatars(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'Icon'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // All sizes
        const SizedBox(height: 16),
        Text(
          'All Sizes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.xs,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.sm,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.md,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.xl,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.xxl,
              ),
            ),
          ],
        ),
        // Different icons
        const SizedBox(height: 24),
        Text(
          'Different Icons',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.person,
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.group,
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.business,
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.settings,
                size: AvatarSize.lg,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.star,
                size: AvatarSize.lg,
              ),
            ),
          ],
        ),
        // Custom colors
        const SizedBox(height: 24),
        Text(
          'Custom Colors',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.notifications,
                size: AvatarSize.lg,
                backgroundColor: UiColors.warning100,
                foregroundColor: UiColors.warning600,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.check_circle,
                size: AvatarSize.lg,
                backgroundColor: UiColors.success100,
                foregroundColor: UiColors.success600,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.icon(
                icon: Icons.error,
                size: AvatarSize.lg,
                backgroundColor: UiColors.error100,
                foregroundColor: UiColors.error600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@UseCase(
  name: 'Avatars with Badges',
  type: BaseAvatar,
  path: 'Components/Avatar/Showcase',
  designLink: 'https://www.figma.com/community/file/1545817431010952080',
)
Widget avatarsWithBadges(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'With Badges'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status badges
        const SizedBox(height: 16),
        Text(
          'Status Indicators',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Extra Small',
                size: AvatarSize.xs,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Small User',
                size: AvatarSize.sm,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'Medium User',
                size: AvatarSize.md,
                badge: AvatarBadge.status(status: UserStatus.away),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'L G',
                size: AvatarSize.lg,
                badge: AvatarBadge.status(status: UserStatus.busy),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'X L',
                size: AvatarSize.xl,
                badge: AvatarBadge.status(status: UserStatus.offline),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xxl,
                shape: AvatarShape.roundedRectangle,
                badge: AvatarBadge.status(status: UserStatus.offline),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Status With Custom Icons',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.xl,
                shape: AvatarShape.roundedRectangle,
                badge: AvatarBadge(
                    size: 24,
                    backgroundColor: UiColors.background,
                    showBorder: false,
                    child: Icon(
                      Icons.wifi,
                      color: UiColors.error,
                    )),
                badgePosition: BadgePosition.topRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                shape: AvatarShape.roundedRectangle,
                size: AvatarSize.xxl,
                badge: AvatarBadge(
                    size: 24,
                    backgroundColor: UiColors.neutral600,
                    showBorder: false,
                    child: Icon(
                      Icons.mic_off,
                      color: UiColors.onPrimary,
                    )),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
          ],
        ),
        // Notification badges
        const SizedBox(height: 24),
        Text(
          'Notification Badges',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                badge: AvatarBadge.notification(count: 3),
                badgePosition: BadgePosition.topRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                badge: AvatarBadge.notification(count: 12),
                badgePosition: BadgePosition.topRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                badge: AvatarBadge.notification(count: 99),
                badgePosition: BadgePosition.topRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.image(
                imageUrl: imageUrl,
                size: AvatarSize.lg,
                badge: AvatarBadge.notification(count: 150),
                badgePosition: BadgePosition.topRight,
              ),
            ),
          ],
        ),
        // Different badge positions
        const SizedBox(height: 24),
        Text(
          'Badge Positions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'TL',
                size: AvatarSize.xl,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.topLeft,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'TR',
                size: AvatarSize.xl,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.topRight,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'BL',
                size: AvatarSize.xl,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.bottomLeft,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Avatars.initials(
                name: 'BR',
                size: AvatarSize.xl,
                badge: AvatarBadge.status(status: UserStatus.online),
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@UseCase(
  name: 'Avatar Groups',
  type: AvatarGroup,
  path: 'Components/Avatar/Showcase',
  designLink: 'https://www.figma.com/community/file/1545817431010952080',
)
Widget avatarGroups(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Avatar', 'Groups'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small groups
        const SizedBox(height: 16),
        Text(
          'Small Groups (3 avatars)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.initials(
                name: 'John Doe',
                size: AvatarSize.md,
              ),
              Avatars.initials(
                name: 'Jane Smith',
                size: AvatarSize.md,
              ),
              Avatars.initials(
                name: 'Bob Johnson',
                size: AvatarSize.md,
              ),
            ],
            size: AvatarSize.md,
            maxVisible: 3,
          ),
        ),
        // With overflow
        const SizedBox(height: 24),
        Text(
          'With Overflow (+N indicator)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.initials(name: 'Alice Williams', size: AvatarSize.md),
              Avatars.initials(name: 'Charlie Brown', size: AvatarSize.md),
              Avatars.initials(name: 'Diana Prince', size: AvatarSize.md),
              Avatars.initials(name: 'Eve Martinez', size: AvatarSize.md),
              Avatars.initials(name: 'Frank Miller', size: AvatarSize.md),
            ],
            size: AvatarSize.md,
            maxVisible: 3,
          ),
        ),
        // Different sizes
        const SizedBox(height: 24),
        Text(
          'Different Sizes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.initials(name: 'User 1', size: AvatarSize.sm),
              Avatars.initials(name: 'User 2', size: AvatarSize.sm),
              Avatars.initials(name: 'User 3', size: AvatarSize.sm),
              Avatars.initials(name: 'User 4', size: AvatarSize.sm),
            ],
            size: AvatarSize.sm,
            maxVisible: 3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.initials(name: 'User A', size: AvatarSize.lg),
              Avatars.initials(name: 'User B', size: AvatarSize.lg),
              Avatars.initials(name: 'User C', size: AvatarSize.lg),
              Avatars.initials(name: 'User D', size: AvatarSize.lg),
              Avatars.initials(name: 'User E', size: AvatarSize.lg),
            ],
            size: AvatarSize.lg,
            maxVisible: 4,
          ),
        ),
        // Different sizes
        const SizedBox(height: 24),
        Text(
          'Different Sizes With Images',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UiColors.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.sm),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.sm),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.sm),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.sm),
            ],
            size: AvatarSize.sm,
            maxVisible: 3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: Avatars.group(
            avatars: [
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.lg),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.lg),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.lg),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.lg),
              Avatars.image(imageUrl: imageUrl, size: AvatarSize.lg),
            ],
            size: AvatarSize.lg,
            maxVisible: 4,
          ),
        ),
      ],
    ),
  );
}
