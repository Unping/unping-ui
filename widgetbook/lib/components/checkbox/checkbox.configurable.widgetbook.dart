import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

/// Example stateful checkbox widget for demonstration in Widgetbook
class _ExampleCheckbox extends StatefulWidget {
  final CheckboxSize size;
  final String? label;
  final String? description;
  final TextStyle? labelStyle;
  final TextStyle? descriptionStyle;
  final double textSpacing;
  final bool isDisabled;

  const _ExampleCheckbox({
    required this.size,
    this.label,
    this.description,
    this.labelStyle,
    this.descriptionStyle,
    required this.textSpacing,
    required this.isDisabled,
  });

  @override
  State<_ExampleCheckbox> createState() => _ExampleCheckboxState();
}

class _ExampleCheckboxState extends State<_ExampleCheckbox> {
  CheckboxState currentState = CheckboxState.unchecked;

  void _handleStateChange(CheckboxState newState) {
    if (!widget.isDisabled) {
      setState(() {
        // Cycle through states: unchecked -> checked -> indeterminate -> unchecked
        switch (currentState) {
          case CheckboxState.unchecked:
            currentState = CheckboxState.checked;
            break;
          case CheckboxState.checked:
            currentState = CheckboxState.indeterminate;
            break;
          case CheckboxState.indeterminate:
            currentState = CheckboxState.unchecked;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkboxes.checkbox(
      state: currentState,
      onChanged: widget.isDisabled ? null : _handleStateChange,
      size: widget.size,
      label: widget.label,
      description: widget.description,
      labelStyle: widget.labelStyle,
      descriptionStyle: widget.descriptionStyle,
      textSpacing: widget.textSpacing,
    );
  }
}

@widgetbook.UseCase(
  name: 'ConfigurableCheckbox',
  type: BaseCheckbox,
  path: 'Components/Checkbox/Configurable',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildConfigurableCheckbox(BuildContext context) {
  // Checkbox size
  final checkboxSize = context.knobs.list(
    label: 'Size',
    options: CheckboxSize.values,
    labelBuilder: (value) => value.name,
    initialOption: CheckboxSize.md,
  );

  // Text content
  final hasLabel = context.knobs.boolean(
    label: 'Has Label',
    initialValue: true,
  );

  final labelText = hasLabel
      ? context.knobs.string(
          label: 'Label Text',
          initialValue: 'Checkbox Label',
        )
      : null;

  final hasDescription = context.knobs.boolean(
    label: 'Has Description',
    initialValue: false,
  );

  final descriptionText = hasDescription
      ? context.knobs.string(
          label: 'Description Text',
          initialValue: 'This is a description for the checkbox.',
        )
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
  final textSpacing = context.knobs.double.slider(
    label: 'Text Spacing',
    initialValue: UiSpacing.xs,
    min: UiSpacing.spacing0,
    max: UiSpacing.spacing24,
  );

  // Interaction states
  final isDisabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  // Create checkbox
  final checkbox = _ExampleCheckbox(
    size: checkboxSize,
    label: labelText,
    description: descriptionText,
    labelStyle: labelStyle,
    descriptionStyle: descriptionStyle,
    textSpacing: textSpacing,
    isDisabled: isDisabled,
  );

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Checkbox', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: checkbox,
            ),
          ],
        ),
      ],
    ),
  );
}
