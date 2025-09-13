import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'Configurable',
  type: BaseInputField,
  path: 'Components/Input Field',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldConfigurable(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Configurable'],
    child: Container(
      padding: const EdgeInsets.all(16),
      child: BaseInputField(
        textColor: context.knobs.color(
          label: 'Text Color',
          initialValue: UiColors.neutral900,
        ),
        placeholder: context.knobs.string(
          label: 'Placeholder',
          initialValue: 'Enter text...',
        ),
        label: context.knobs.stringOrNull(
          label: 'Label',
          initialValue: 'Label',
        ),
        helperText: context.knobs.stringOrNull(
          label: 'Helper Text',
          initialValue: 'This is a helper text.',
        ),
        errorText: context.knobs.stringOrNull(
          label: 'Error Text',
          initialValue: null,
        ),
        variant: context.knobs.list(
          label: 'Variant',
          options: InputFieldVariant.values,
          labelBuilder: (variant) => variant.name,
          initialOption: InputFieldVariant.outlined,
        ),
        size: context.knobs.list(
          label: 'Size',
          options: InputFieldSize.values,
          labelBuilder: (size) => size.name,
          initialOption: InputFieldSize.md,
        ),
        enabled: context.knobs.boolean(
          label: 'Enabled',
          initialValue: true,
        ),
        readOnly: context.knobs.boolean(
          label: 'Read Only',
          initialValue: false,
        ),
        obscureText: context.knobs.boolean(
          label: 'Obscure Text',
          initialValue: false,
        ),
        maxLines: context.knobs.int.slider(
          label: 'Max Lines',
          initialValue: 1,
          min: 1,
          max: 10,
        ),
        backgroundColor: context.knobs.colorOrNull(
          label: 'Background Color',
          initialValue: null,
        ),
        borderColor: context.knobs.colorOrNull(
          label: 'Border Color',
          initialValue: null,
        ),
        focusBorderColor: context.knobs.colorOrNull(
          label: 'Focus Border Color',
          initialValue: null,
        ),
        errorBorderColor: context.knobs.colorOrNull(
          label: 'Error Border Color',
          initialValue: null,
        ),
        focusRingColor: context.knobs.colorOrNull(
          label: 'Focus Ring Color',
          initialValue: UiColors.primary200,
        ),
        borderWidth: context.knobs.double.slider(
          label: 'Border Width',
          initialValue: 1.0,
          min: 0.0,
          max: 5.0,
          divisions: 50,
        ),
        borderRadius: context.knobs.double.slider(
          label: 'Border Radius',
          initialValue: UiRadius.xs,
          min: 0.0,
          max: 20.0,
          divisions: 20,
        ),
        forceState: context.knobs.listOrNull(
          label: 'Force State',
          options: InputFieldState.values,
          labelBuilder: (state) => state?.name ?? 'null',
          initialOption: null,
        ),
        leadingIcon: context.knobs.boolean(
          label: 'Show Leading Icon',
          initialValue: false,
        ) ? const Icon(
          Icons.search,
          size: 16,
          color: UiColors.neutral400,
        ) : null,
        trailingIcon: context.knobs.boolean(
          label: 'Show Trailing Icon',
          initialValue: false,
        ) ? const Icon(
          Icons.visibility_off,
          size: 16,
          color: UiColors.neutral400,
        ) : null,
      ),
    ),
  );
}