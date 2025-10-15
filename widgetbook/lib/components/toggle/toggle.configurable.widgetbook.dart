import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import your toggle widget
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableToggle',
  type: ToggleSwitch,
  path: 'Components/Toggle/Configurable',
  designLink:
      'https://www.figma.com/design/A4jImS7idoqAbZ2Db7E9zT/unping-ui.com-%7C-Public--Community-?node-id=4913-7283&p=f&t=PR11WcPWO8bHVDII-0',
)
Widget buildConfigurableToggle(BuildContext context) {
  // Toggle size
  final toggleSize = context.knobs.list(
    label: 'Size',
    options: ToggleSize.values,
    labelBuilder: (value) => value.name,
    initialOption: ToggleSize.md,
  );

  // Text content
  final hasLabel =
      context.knobs.boolean(label: 'Has Label', initialValue: true);
  final labelText = hasLabel
      ? context.knobs.string(label: 'Label Text', initialValue: 'Remember me')
      : null;

  final hasDescription =
      context.knobs.boolean(label: 'Has Description', initialValue: false);
  final descriptionText = hasDescription
      ? context.knobs.string(
          label: 'Description Text',
          initialValue: 'Save my login details for next time.')
      : null;

  // Text styling
  final labelStyle = context.knobs.listOrNull(
    label: 'Label Style (override default)',
    options: [
      null,
      UiTextStyles.textXs,
      UiTextStyles.textSm,
      UiTextStyles.textMd,
      UiTextStyles.textLg,
      UiTextStyles.textXl,
      UiTextStyles.textSmMedium,
      UiTextStyles.textSmBold,
    ],
    labelBuilder: (style) =>
        style != null ? UiTextStyles.getTextStyleName(style) : 'Default',
  );

  final descriptionStyle = context.knobs.listOrNull(
    label: 'Description Style (override default)',
    options: [
      null,
      UiTextStyles.textXs,
      UiTextStyles.textSm,
      UiTextStyles.textMd,
      UiTextStyles.textLg,
      UiTextStyles.textXl,
      UiTextStyles.textSmMedium,
      UiTextStyles.textSmBold,
    ],
    labelBuilder: (style) =>
        style != null ? UiTextStyles.getTextStyleName(style) : 'Default',
  );

  // Spacing
  final spacing = context.knobs.double.slider(
    label: 'Text Spacing',
    initialValue: UiSpacing.xs,
    min: UiSpacing.spacing0,
    max: UiSpacing.spacing24,
  );

  // Interaction states
  final isDisabled =
      context.knobs.boolean(label: 'Disabled', initialValue: false);

  // Animation
  final animationDuration = Duration(
    milliseconds: context.knobs.int.slider(
      label: 'Animation Duration (ms)',
      initialValue: 200,
      min: 50,
      max: 1000,
    ),
  );

  // Colors
  final activeColor = context.knobs
      .color(label: 'Active Color', initialValue: UiColors.toggleActive);
  final inactiveColor = context.knobs
      .color(label: 'Inactive Color', initialValue: UiColors.neutral600);
  final thumbColor = context.knobs
      .color(label: 'Thumb Color', initialValue: UiColors.neutral400);

  // Create toggle
  final toggle = _ExampleToggle(
    size: toggleSize,
    label: labelText,
    description: descriptionText,
    labelStyle: labelStyle,
    descriptionStyle: descriptionStyle,
    spacing: spacing,
    isDisabled: isDisabled,
    animationDuration: animationDuration,
    activeColor: activeColor,
    inactiveColor: inactiveColor,
    thumbColor: thumbColor,
  );

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Toggle', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: toggle,
            ),
          ],
        ),
      ],
    ),
  );
}

/// Example stateful toggle widget for demonstration in Widgetbook
class _ExampleToggle extends StatefulWidget {
  final ToggleSize size;
  final String? label;
  final String? description;
  final TextStyle? labelStyle;
  final TextStyle? descriptionStyle;
  final double spacing;
  final bool isDisabled;
  final Duration animationDuration;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;

  const _ExampleToggle({
    required this.size,
    this.label,
    this.description,
    this.labelStyle,
    this.descriptionStyle,
    required this.spacing,
    required this.isDisabled,
    required this.animationDuration,
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbColor,
  });

  @override
  State<_ExampleToggle> createState() => _ExampleToggleState();
}

class _ExampleToggleState extends State<_ExampleToggle> {
  bool isOn = false;

  void _handleToggle(bool newValue) {
    if (!widget.isDisabled) {
      setState(() {
        isOn = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Toggles.switchToggle(
      value: isOn,
      onChanged: widget.isDisabled ? (_) {} : _handleToggle,
      size: widget.size,
      label: widget.label,
      description: widget.description,
      labelStyle: widget.labelStyle,
      descriptionStyle: widget.descriptionStyle,
      spacing: widget.spacing,
      isDisabled: widget.isDisabled,
      animationDuration: widget.animationDuration,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      thumbColor: widget.thumbColor,
    );
  }
}
