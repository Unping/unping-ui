import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

Widget _pad(Widget child) => Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 320,
        child: child,
      ),
    );

@widgetbook.UseCase(
  name: 'Text',
  type: BaseInput,
  path: 'Components/Input/Showcase',
)
Widget showcaseTextInput(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input', 'Text'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pad(Inputs.text(
          label: 'Label',
          placeholder: 'Placeholder',
          onChanged: (_) {},
        )),
        _pad(Inputs.text(
          label: 'Focused',
          placeholder: 'Placeholder',
          forceState: InputState.focused,
        )),
        _pad(Inputs.text(
          label: 'Error',
          placeholder: 'Placeholder',
          errorText: 'Error message',
        )),
        _pad(Inputs.text(
          label: 'Disabled',
          placeholder: 'Placeholder',
          enabled: false,
        )),
        _pad(Inputs.text(
            label: 'With prefix',
            placeholder: 'Email',
            prefix: const Icon(
              Icons.alternate_email,
              size: 18,
              color: UiColors.neutral400,
            ))),
        _pad(
          Inputs.text(
              label: 'With suffix',
              placeholder: 'Username',
              suffix: const Icon(
                Icons.check_circle,
                size: 18,
                color: UiColors.neutral400,
              )),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Text Area',
  type: BaseInput,
  path: 'Components/Input/Showcase',
)
Widget showcaseTextArea(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input', 'Text Area'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pad(Inputs.textArea(
          label: 'Description',
          placeholder: 'Write something...',
          minLines: 3,
          maxLines: 8,
          resizable: true,
        )),
        _pad(Inputs.textArea(
          label: 'Focused',
          placeholder: 'Write...',
          forceState: InputState.focused,
        )),
        _pad(Inputs.textArea(
          label: 'Error',
          placeholder: 'Write...',
          errorText: 'Too long',
        )),
        _pad(
          Inputs.textArea(
            label: 'Disabled',
            placeholder: 'Write...',
            enabled: false,
          ),
        ),
        _pad(Inputs.textArea(
          label: 'With counter',
          placeholder: 'Max 120 chars',
          maxLength: 120,
          showCharacterCount: true,
        )),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Search',
  type: BaseInput,
  path: 'Components/Input/Showcase',
)
Widget showcaseSearchInput(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input', 'Search'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pad(Inputs.search(placeholder: 'Search...')),
        _pad(BaseInput(
          placeholder: 'Clearable search',
          prefix: const Icon(
            Icons.search,
            size: 18,
            color: UiColors.neutral400,
          ),
          showClearButton: true,
        )),
        _pad(Inputs.search(
          placeholder: 'Focused',
          forceState: InputState.focused,
        )),
        _pad(Inputs.search(
          placeholder: 'Disabled',
          enabled: false,
        )),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Password',
  type: BaseInput,
  path: 'Components/Input/Showcase',
)
Widget showcasePasswordInput(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input', 'Password'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pad(Inputs.password(
          label: 'Password',
          placeholder: 'Enter password',
          showStrengthIndicator: true,
        )),
        _pad(Inputs.password(
          label: 'Focused',
          placeholder: 'Enter password',
          showStrengthIndicator: true,
          forceState: InputState.focused,
        )),
        _pad(Inputs.password(
          label: 'Error',
          placeholder: 'Enter password',
          errorText: 'Weak password',
        )),
        _pad(Inputs.password(
          label: 'Disabled',
          placeholder: 'Enter password',
          showStrengthIndicator: true,
          enabled: false,
        )),
      ],
    ),
  );
}
