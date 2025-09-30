import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/l10n/language_extension.dart';
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
          label: context.lang.inputLabel,
          placeholder: context.lang.inputPlaceholder,
          onChanged: (_) {},
        )),
        _pad(Inputs.text(
          label: context.lang.inputFocused,
          placeholder: context.lang.inputPlaceholder,
          forceState: InputState.focused,
        )),
        _pad(Inputs.text(
          label: context.lang.inputError,
          placeholder: context.lang.inputPlaceholder,
          errorText: context.lang.inputErrorMessage,
        )),
        _pad(Inputs.text(
          label: context.lang.inputDisabled,
          placeholder: context.lang.inputPlaceholder,
          enabled: false,
        )),
        _pad(Inputs.text(
            label: context.lang.inputWithPrefix,
            placeholder: context.lang.inputEmailPlaceholder,
            prefix: const Icon(
              Icons.alternate_email,
              size: 18,
              color: UiColors.neutral400,
            ))),
        _pad(
          Inputs.text(
              label: context.lang.inputWithSuffix,
              placeholder: context.lang.inputUsernamePlaceholder,
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
          label: context.lang.inputDescription,
          placeholder: context.lang.inputDescriptionPlaceholder,
          minLines: 3,
          maxLines: 8,
          resizable: true,
        )),
        _pad(Inputs.textArea(
          label: context.lang.inputFocused,
          placeholder: context.lang.inputWritePlaceholder,
          forceState: InputState.focused,
        )),
        _pad(Inputs.textArea(
          label: context.lang.inputError,
          placeholder: context.lang.inputWritePlaceholder,
          errorText: context.lang.inputTooLong,
        )),
        _pad(
          Inputs.textArea(
            label: context.lang.inputDisabled,
            placeholder: context.lang.inputWritePlaceholder,
            enabled: false,
          ),
        ),
        _pad(Inputs.textArea(
          label: context.lang.inputWithCounter,
          placeholder: context.lang.inputMaxCharsPlaceholder,
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
        _pad(Inputs.search(placeholder: context.lang.inputSearchPlaceholder)),
        _pad(BaseInput(
          placeholder: context.lang.inputClearableSearch,
          prefix: const Icon(
            Icons.search,
            size: 18,
            color: UiColors.neutral400,
          ),
          showClearButton: true,
        )),
        _pad(Inputs.search(
          placeholder: context.lang.inputFocused,
          forceState: InputState.focused,
        )),
        _pad(Inputs.search(
          placeholder: context.lang.inputDisabled,
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
          label: context.lang.inputPasswordLabel,
          placeholder: context.lang.inputPasswordPlaceholder,
          showStrengthIndicator: true,
        )),
        _pad(Inputs.password(
          label: context.lang.inputFocused,
          placeholder: context.lang.inputPasswordPlaceholder,
          showStrengthIndicator: true,
          forceState: InputState.focused,
        )),
        _pad(Inputs.password(
          label: context.lang.inputError,
          placeholder: context.lang.inputPasswordPlaceholder,
          errorText: context.lang.inputWeakPassword,
        )),
        _pad(Inputs.password(
          label: context.lang.inputDisabled,
          placeholder: context.lang.inputPasswordPlaceholder,
          showStrengthIndicator: true,
          enabled: false,
        )),
      ],
    ),
  );
}
