import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A widget that displays multiple avatars in a stacked/overlapped layout
class AvatarGroup extends StatelessWidget {
  /// List of avatars to display
  final List<Widget> avatars;

  /// Maximum number of visible avatars (remaining shown as +N)
  final int maxVisible;

  /// Size of the avatars in the group
  final AvatarSize size;

  /// Spacing between avatars (negative for overlap)
  final double spacing;

  /// Background color for the +N indicator avatar
  final Color moreBackgroundColor;

  /// Text color for the +N indicator
  final Color moreTextColor;

  /// Border color for avatars (creates separation in overlap)
  final Color? borderColor;

  /// Border width for avatars
  final double borderWidth;

  /// Callback when the +N indicator is tapped
  final VoidCallback? onMoreTap;

  /// Optional semantic label for accessibility
  final String? semanticsLabel;

  const AvatarGroup({
    super.key,
    required this.avatars,
    this.maxVisible = 3,
    this.size = AvatarSize.md,
    this.spacing = -8.0,
    this.moreBackgroundColor = UiColors.neutral600,
    this.moreTextColor = UiColors.onPrimary,
    this.borderColor = UiColors.background,
    this.borderWidth = 2.0,
    this.onMoreTap,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) {
      return const SizedBox.shrink();
    }

    final avatarSize = AvatarSizeHelper.getSize(size);
    final visibleAvatars = avatars.take(maxVisible).toList();
    final remainingCount = avatars.length - maxVisible;
    final showMoreIndicator = remainingCount > 0;

    final List<Widget> stackChildren = [];

    // Add visible avatars with borders
    for (int i = 0; i < visibleAvatars.length; i++) {
      final avatar = visibleAvatars[i];
      final offset = i * (avatarSize + spacing);

      stackChildren.add(
        Positioned(
          left: offset,
          child: Container(
            decoration: borderColor != null
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor!,
                      width: borderWidth,
                    ),
                  )
                : null,
            child: avatar,
          ),
        ),
      );
    }

    // Add +N indicator if needed
    if (showMoreIndicator) {
      final offset = visibleAvatars.length * (avatarSize + spacing);
      final moreWidget = _buildMoreIndicator(remainingCount);

      stackChildren.add(
        Positioned(
          left: offset,
          child: GestureDetector(
            onTap: onMoreTap,
            child: Container(
              decoration: borderColor != null
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor!,
                        width: borderWidth,
                      ),
                    )
                  : null,
              child: moreWidget,
            ),
          ),
        ),
      );
    }

    // Calculate total width
    final displayCount =
        showMoreIndicator ? visibleAvatars.length + 1 : visibleAvatars.length;
    final totalWidth = avatarSize + (displayCount - 1) * (avatarSize + spacing);

    Widget group = SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: stackChildren,
      ),
    );

    if (semanticsLabel != null) {
      group = Semantics(
        label: semanticsLabel,
        child: group,
      );
    }

    return group;
  }

  Widget _buildMoreIndicator(int count) {
    final fontSize = AvatarSizeHelper.getFontSize(size);

    return BaseAvatar(
      size: size,
      backgroundColor: moreBackgroundColor,
      foregroundColor: moreTextColor,
      shape: AvatarShape.circle,
      child: Center(
        child: Text(
          '+$count',
          style: UiTextStyles.textSm.copyWith(
            fontSize: fontSize,
            color: moreTextColor,
            fontWeight: UiTextStyles.semiBold,
          ),
        ),
      ),
    );
  }
}
