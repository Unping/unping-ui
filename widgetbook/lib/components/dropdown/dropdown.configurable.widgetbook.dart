import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableDropdown',
  type: BaseDropdown,
  path: 'Components/Dropdown/Configurable',
)
Widget buildConfigurableDropdown(BuildContext context) {
  // Dropdown type selection
  final dropdownType = context.knobs.list(
    label: 'Dropdown Type',
    options: ['select', 'multiSelect', 'combobox'],
    initialOption: 'select',
  );

  // Size selection
  final size = context.knobs.list(
    label: 'Size',
    options: DropdownSize.values,
    labelBuilder: (value) => value.name.toUpperCase(),
    initialOption: DropdownSize.md,
  );

  // Basic properties
  final label = context.knobs.stringOrNull(
    label: 'Label',
    initialValue: 'Select an option',
  );

  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'Choose...',
  );

  final helperText = context.knobs.stringOrNull(
    label: 'Helper Text',
    initialValue: null,
  );

  final errorText = context.knobs.stringOrNull(
    label: 'Error Text',
    initialValue: null,
  );

  final isDisabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  final searchable = context.knobs.boolean(
    label: 'Searchable',
    initialValue: dropdownType == 'combobox',
  );

  // Number of options (to test scrolling)
  final optionCount = context.knobs.int.slider(
    label: 'Number of Options',
    initialValue: 10,
    min: 3,
    max: 100,
  );

  // Force state for showcasing
  final forceState = context.knobs.listOrNull(
    label: 'Force State',
    options: DropdownState.values,
    labelBuilder: (value) => value?.name ?? 'None',
  );

  // Has prefix icon
  final hasPrefix = context.knobs.boolean(
    label: 'Has Prefix Icon',
    initialValue: false,
  );

  // Generate options based on count
  final options = List.generate(
    optionCount,
    (index) => 'Option ${index + 1}',
  );

  // State for selected values
  final selectedValue = context.knobs.listOrNull(
    label: 'Selected Value (Single)',
    options: options,
  );

  // Create prefix icon if enabled
  Widget? prefixIcon;
  if (hasPrefix) {
    prefixIcon = Icon(
      Icons.search,
      size: 20,
      color: UiColors.neutral400,
    );
  }

  // Create the appropriate dropdown based on type
  Widget dropdown;
  switch (dropdownType) {
    case 'select':
      dropdown = Dropdowns.select<String>(
        label: label,
        placeholder: placeholder,
        helperText: helperText,
        errorText: errorText,
        options: options,
        selectedValue: selectedValue,
        onChanged: (value) {
          // In a real app, update state here
          debugPrint('Selected: $value');
        },
        enabled: !isDisabled,
        size: size,
        searchable: searchable,
        menuWidth: null,
        menuMaxHeight: 320,
        prefix: prefixIcon,
        forceState: forceState,
      );
      break;

    case 'multiSelect':
      dropdown = Dropdowns.multiSelect<String>(
        label: label,
        placeholder: placeholder,
        helperText: helperText,
        errorText: errorText,
        options: options,
        selectedValues: selectedValue != null ? [selectedValue] : [],
        onChanged: (values) {
          debugPrint('Selected: $values');
        },
        enabled: !isDisabled,
        size: size,
        searchable: searchable,
        menuWidth: null,
        menuMaxHeight: 320,
        prefix: prefixIcon,
        forceState: forceState,
      );
      break;

    case 'combobox':
      dropdown = Dropdowns.combobox<String>(
        label: label,
        placeholder: placeholder,
        helperText: helperText,
        errorText: errorText,
        options: options,
        selectedValue: selectedValue,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
        optionBuilder: (option) => Text(
          option,
          style: UiTextStyles.textMd.copyWith(color: UiColors.onPrimary),
        ),
        enabled: !isDisabled,
        size: size,
        menuWidth: null,
        menuMaxHeight: 320,
        prefix: prefixIcon,
        forceState: forceState,
      );
      break;

    default:
      dropdown = Dropdowns.select<String>(
        label: label,
        placeholder: placeholder,
        options: options,
        selectedValue: selectedValue,
        onChanged: (value) {},
        enabled: !isDisabled,
        size: size,
      );
  }

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 400),
          child: dropdown,
        ),
      ],
    ),
  );
}
