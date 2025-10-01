// widgetbook/components/tooltip/tooltip.configurable.widgetbook.dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';
import 'package:widgetbook_workspace/l10n/language_extension.dart';

@widgetbook.UseCase(
  name: 'Interactive Tooltip',
  type: UiTooltip,
  path: 'Components/Tooltip/Configurable',
)
Widget buildConfigurableTooltip(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a tooltip',
  );

  final placement = context.knobs.list(
    label: 'Placement',
    options: UiTooltipPlacement.values,
    labelBuilder: (value) => value.name,
    initialOption: UiTooltipPlacement.auto,
  );

  final variant = context.knobs.list(
    label: 'Variant',
    options: UiTooltipVariant.values,
    labelBuilder: (value) => value.name,
    initialOption: UiTooltipVariant.neutral,
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  final triggerOnHover = context.knobs.boolean(
    label: 'Trigger on Hover',
    initialValue: true,
  );

  final triggerOnLongPress = context.knobs.boolean(
    label: 'Trigger on Long Press',
    initialValue: true,
  );

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Tooltip', 'Configurable'],
    child: Center(
      child: UiTooltip(
        message: message,
        placement: placement,
        variant: variant,
        enabled: enabled,
        triggerOnHover: triggerOnHover,
        triggerOnLongPress: triggerOnLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: UiColors.neutral700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Hover or long press me',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

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
