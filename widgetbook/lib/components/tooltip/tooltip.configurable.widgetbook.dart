// widgetbook/components/tooltip/tooltip.configurable.widgetbook.dart
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A tiny wrapper that turns any child into a *live* tooltip anchor with
/// hover, focus, and long-press interactions. The showcase imports and uses this.
class TooltipConfigurable extends StatelessWidget {
  const TooltipConfigurable({
    super.key,
    required this.child,
    required this.message,
    required this.placement,
    this.variant = UiTooltipVariant.neutral,
    this.enabled = true,
    this.triggerOnHover = true,
    this.triggerOnLongPress = true,
  });

  final Widget child;
  final String message;
  final UiTooltipPlacement placement;
  final UiTooltipVariant variant;
  final bool enabled;
  final bool triggerOnHover;
  final bool triggerOnLongPress;

  @override
  Widget build(BuildContext context) {
    return UiTooltip(
      message: message,
      placement: placement,
      variant: variant,
      enabled: enabled,
      triggerOnHover: triggerOnHover,
      triggerOnLongPress: triggerOnLongPress,
      // ensure focus path works even for non-focusable children
      child: Focus(canRequestFocus: true, child: child),
    );
  }
}
