import 'package:flutter/material.dart';
import 'tooltip_types.dart';

OverlayEntry buildTooltipOverlay({
  required BuildContext context,
  required LayerLink link,
  required AnimationController controller,
  required String message,
  Widget? content,
  required UiTooltipPlacement placement,
  required UiTooltipStyle style,

  // NEW: enable interactive popover overlays
  bool interactive = false,
  bool dismissOnTapOutside = false,
  VoidCallback? onTapOutside,
}) {
  final anchors = _anchorsFor(placement);

  final childContent = content ??
      Text(
        message,
        softWrap: true,
        textScaler: MediaQuery.textScalerOf(context),
        style: style.textStyle,
      );

  final bubble = FadeTransition(
    opacity: CurvedAnimation(parent: controller, curve: Curves.easeOut),
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.98, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: style.maxWidth),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: style.radius,
              boxShadow: style.shadow,
            ),
            child: Padding(
              padding: style.padding,
              child: childContent,
            ),
          ),
        ),
      ),
    ),
  );

  Widget follower = CompositedTransformFollower(
    link: link,
    targetAnchor: anchors.$1,
    followerAnchor: anchors.$2,
    offset: anchors.$3,
    child: bubble,
  );

  if (!interactive) {
    // Tooltip (hover/long-press): don’t block events behind it
    return OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(ignoring: true, child: follower),
      ),
    );
  }

  // Popover: interactive and (optionally) close on outside tap
  return OverlayEntry(
    builder: (_) => Positioned.fill(
      child: Stack(
        children: [
          if (dismissOnTapOutside)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTapOutside,
              onPanDown: (_) => onTapOutside?.call(),
            ),
          // bubble on top so it remains interactive
          follower,
        ],
      ),
    ),
  );
}

(Alignment, Alignment, Offset) _anchorsFor(UiTooltipPlacement placement) {
  switch (placement) {
    case UiTooltipPlacement.top:
      return (Alignment.topCenter, Alignment.bottomCenter,
      const Offset(0, kTooltipGap * -1));
    case UiTooltipPlacement.bottom:
      return (Alignment.bottomCenter, Alignment.topCenter,
      const Offset(0, kTooltipGap));
    case UiTooltipPlacement.left:
      return (Alignment.centerLeft, Alignment.centerRight,
      const Offset(kTooltipGap * -1, 0));
    case UiTooltipPlacement.right:
      return (Alignment.centerRight, Alignment.centerLeft,
      const Offset(kTooltipGap, 0));
    case UiTooltipPlacement.auto:
      return (Alignment.bottomCenter, Alignment.topCenter,
      const Offset(0, kTooltipGap));
  }
}
