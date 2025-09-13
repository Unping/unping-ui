// widgetbook/components/tooltip/tooltip.configurable.widgetbook.dart
import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_workspace/utils/background.widgetbook.dart';
import 'package:widgetbook_workspace/utils/header.widgetbook.dart';


@widgetbook.UseCase(
  name: 'Tooltip – configurable',
  type: UiTooltip,
  path: 'Components/Tooltip',
)
Widget tooltipConfigurable(BuildContext context) {
  // Use list<T>() instead of options()
  final variant = context.knobs.list<UiTooltipVariant>(
    label: 'Variant',
    options: UiTooltipVariant.values,
    initialOption: UiTooltipVariant.neutral,
  );

  final placement = context.knobs.list<UiTooltipPlacement>(
    label: 'Placement',
    options: UiTooltipPlacement.values,
    initialOption: UiTooltipPlacement.auto,
  );

  final long = context.knobs.boolean(label: 'Long text', initialValue: false);
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final hover =
  context.knobs.boolean(label: 'Trigger on hover', initialValue: true);
  final longPress =
  context.knobs.boolean(label: 'Trigger on long-press', initialValue: true);

  final msg = long
      ? 'Very long tooltip that wraps within a constrained max width to stay readable across small viewports.'
      : context.knobs.string(label: 'Message', initialValue: 'This is a tooltip');


  return UnpingUIWidgetbookBackground(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UnpingUiWidgetbookHeader(
            breadcrumbs: ['Components', 'Tooltip'],
            title: 'Tooltip (configurable)',
          ),
          const SizedBox(height: UiSpacing.spacing6),
          UiTooltip(
            message: msg,
            placement: placement,
            variant: variant,
            enabled: enabled,
            triggerOnHover: hover,
            triggerOnLongPress: longPress,
            child: FilledButton(
              onPressed: () {},
              child: const Text('Hover / focus / long-press me'),
            ),
          ),
        ],
      ),
    ),
  );
}
