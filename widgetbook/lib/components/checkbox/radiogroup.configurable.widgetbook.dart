import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

/// Example stateful radio group widget for demonstration in Widgetbook
class _ExampleRadioGroup extends StatefulWidget {
  final CheckboxSize size;
  final double spacing;
  final Axis direction;
  final bool isDisabled;
  final List<RadioOption<String>> options;

  const _ExampleRadioGroup({
    required this.size,
    required this.spacing,
    required this.direction,
    required this.isDisabled,
    required this.options,
  });

  @override
  State<_ExampleRadioGroup> createState() => _ExampleRadioGroupState();
}

class _ExampleRadioGroupState extends State<_ExampleRadioGroup> {
  String? selectedValue;

  void _handleValueChange(String? newValue) {
    if (!widget.isDisabled) {
      setState(() {
        selectedValue = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkboxes.radioGroup<String>(
      value: selectedValue,
      onChanged: widget.isDisabled ? null : _handleValueChange,
      options: widget.options,
      size: widget.size,
      spacing: widget.spacing,
      direction: widget.direction,
      disabled: widget.isDisabled,
    );
  }
}

@widgetbook.UseCase(
  name: 'ConfigurableRadioGroup',
  type: RadioGroup,
  path: 'Components/Checkbox/Configurable',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildConfigurableRadioGroup(BuildContext context) {
  // Radio group size
  final radioSize = context.knobs.list(
    label: 'Size',
    options: CheckboxSize.values,
    labelBuilder: (value) => value.name,
    initialOption: CheckboxSize.md,
  );

  // Number of radio options
  final numberOfOptions = context.knobs.int.slider(
    label: 'Number of Options',
    initialValue: 3,
    min: 2,
    max: 8,
  );

  // Direction
  final direction = context.knobs.list(
    label: 'Direction',
    options: [Axis.vertical, Axis.horizontal],
    labelBuilder: (axis) => axis == Axis.vertical ? 'Vertical' : 'Horizontal',
    initialOption: Axis.vertical,
  );

  // Spacing
  final spacing = context.knobs.double.slider(
    label: 'Spacing',
    initialValue: UiSpacing.xs,
    min: UiSpacing.spacing0,
    max: UiSpacing.spacing24,
  );

  // Text content options
  final hasLabels = context.knobs.boolean(
    label: 'Has Labels',
    initialValue: true,
  );

  // Interaction states
  final isDisabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  // Generate radio options based on numberOfOptions
  final options = List.generate(numberOfOptions, (index) {
    final value = 'option${index + 1}';
    final text = hasLabels ? 'Option ${index + 1}' : null;
    
    if (text != null) {
      return RadioOption.text(
        value: value,
        text: text,
      );
    } else {
      return RadioOption<String>(value: value);
    }
  });

  // Create radio group
  final radioGroup = _ExampleRadioGroup(
    size: radioSize,
    spacing: spacing,
    direction: direction,
    isDisabled: isDisabled,
    options: options,
  );

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'RadioGroup', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: radioGroup,
        ),
      ],
    ),
  );
}