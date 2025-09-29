import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// UI library
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableInput',
  type: BaseInput,
  path: 'Components/Input/Configurable',
)
Widget buildConfigurableInput(BuildContext context) {
  // Variant selection
  final variant = context.knobs.list(
    label: 'Variant',
    options: ['text', 'textArea', 'search', 'password'],
    initialOption: 'text',
  );

  // Placeholder
  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: variant == 'search' ? 'Search' : 'Enter value',
  );

  // Tooltip knob
  final tooltip = context.knobs.string(
    label: 'Tooltip Message',
    initialValue: '',
  );

  // Size
  final size = context.knobs.list(
    label: 'Size',
    options: InputSize.values,
    labelBuilder: (v) => v.name,
    initialOption: InputSize.md,
  );

  // State knob
  final state = context.knobs.list(
    label: 'State',
    options: InputState.values,
    labelBuilder: (s) => s.name,
    initialOption: InputState.normal,
  );

  final customError = context.knobs.string(
    label: 'Error Message',
    initialValue: '',
  );

  final hasPrefixIcon =
      context.knobs.boolean(label: 'Has Prefix Icon', initialValue: false);
  final hasSuffixIcon =
      context.knobs.boolean(label: 'Has Suffix Icon', initialValue: false);

  final customIconSize = context.knobs.double.input(
    label: 'Custom Icon Size (0 = auto)',
    initialValue: 0,
  );

  var prefixIconType = 'star';
  var suffixIconType = 'check';

  if (hasPrefixIcon) {
    prefixIconType = context.knobs.list(
      label: 'Prefix Icon Type',
      options: ['star', 'heart', 'check', 'add', 'arrow'],
      initialOption: 'star',
    );
  }
  if (hasSuffixIcon) {
    suffixIconType = context.knobs.list(
      label: 'Suffix Icon Type',
      options: ['star', 'heart', 'check', 'add', 'arrow'],
      initialOption: 'check',
    );
  }

  BaseInput input;
  switch (variant) {
    case 'textArea':
      input = Inputs.textArea(
        placeholder: placeholder.isEmpty ? null : placeholder,
        size: size,
        forceState: state,
        tooltipMessage: tooltip.isNotEmpty ? tooltip : null,
        errorText: state == InputState.error ? 'This field has an error' : null,
      );
      break;

    case 'search':
      input = Inputs.search(
        placeholder: placeholder.isEmpty ? 'Search' : placeholder,
        onSubmitted: (_) {},
        size: size,
        forceState: state,
        tooltipMessage: tooltip.isNotEmpty ? tooltip : null,
      );
      break;

    case 'password':
      input = Inputs.password(
        placeholder: 'Password',
        size: size,
        forceState: state,
        tooltipMessage: tooltip.isNotEmpty ? tooltip : null,
        errorText: state == InputState.error ? 'This field has an error' : null,
      );
      break;

    case 'text':
    default:
      input = Inputs.text(
        placeholder: placeholder.isEmpty ? null : placeholder,
        size: size,
        forceState: state,
        tooltipMessage: tooltip.isNotEmpty ? tooltip : null,
        errorText: state == InputState.error
            ? (customError.isNotEmpty ? customError : 'Error message')
            : null,
        prefixIcon: hasPrefixIcon ? _buildIconData(prefixIconType) : null,
        suffixIcon: hasSuffixIcon ? _buildIconData(suffixIconType) : null,
        iconSize: customIconSize,
        iconColor: UiColors.onPrimary,
      );
  }

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input', 'Configurable'],
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: input,
    ),
  );
}

IconData _buildIconData(String type) {
  switch (type) {
    case 'star':
      return Icons.star;
    case 'heart':
      return Icons.favorite;
    case 'check':
      return Icons.check;
    case 'add':
      return Icons.add;
    case 'arrow':
      return Icons.arrow_forward;
    default:
      return Icons.star;
  }
}
