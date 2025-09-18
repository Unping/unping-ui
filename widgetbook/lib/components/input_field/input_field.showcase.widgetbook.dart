import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'Outlined',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldOutlined(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Outlined'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic outlined input
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Enter text...',
            label: 'Label',
            helperText: 'This is a helper text.',
          ),
        ),

        // With leading icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Search...',
            label: 'Search',
            leadingIcon: const Icon(
              Icons.search,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),

        // With trailing icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Password',
            label: 'Password',
            obscureText: true,
            trailingIcon: const Icon(
              Icons.visibility_off,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),

        // With both icons
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Enter email...',
            label: 'Email',
            leadingIcon: const Icon(
              Icons.email_outlined,
              size: 16,
              color: UiColors.neutral400,
            ),
            trailingIcon: const Icon(
              Icons.check_circle,
              size: 16,
              color: UiColors.success500,
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Filled',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldFilled(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Filled'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic filled input
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.filled,
            placeholder: 'Enter text...',
            label: 'Label',
            helperText: 'This is a helper text.',
          ),
        ),

        // With leading icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.filled,
            placeholder: 'Search...',
            label: 'Search',
            leadingIcon: const Icon(
              Icons.search,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),

        // With trailing icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.filled,
            placeholder: 'Password',
            label: 'Password',
            obscureText: true,
            trailingIcon: const Icon(
              Icons.visibility_off,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Underlined',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldUnderlined(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Underlined'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic underlined input
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.underlined,
            placeholder: 'Enter text...',
            label: 'Label',
            helperText: 'This is a helper text.',
          ),
        ),

        // With leading icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.underlined,
            placeholder: 'Search...',
            label: 'Search',
            leadingIcon: const Icon(
              Icons.search,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),

        // With trailing icon
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.underlined,
            placeholder: 'Password',
            label: 'Password',
            obscureText: true,
            trailingIcon: const Icon(
              Icons.visibility_off,
              size: 16,
              color: UiColors.neutral400,
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Sizes',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldSizes(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Sizes'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small size
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            size: InputFieldSize.sm,
            placeholder: 'Small input...',
            label: 'Small',
          ),
        ),

        // Medium size (default)
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            size: InputFieldSize.md,
            placeholder: 'Medium input...',
            label: 'Medium',
          ),
        ),

        // Large size
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            size: InputFieldSize.lg,
            placeholder: 'Large input...',
            label: 'Large',
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'States',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldStates(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'States'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Normal state
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Normal state...',
            label: 'Normal',
            helperText: 'This is a normal input field.',
          ),
        ),

        // Focused state
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Focused state...',
            label: 'Focused',
            forceState: InputFieldState.focused,
            focusRingColor: UiColors.primary200,
          ),
        ),

        // Error state
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Error state...',
            label: 'Error',
            errorText: 'This field is required.',
          ),
        ),

        // Disabled state
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Disabled state...',
            label: 'Disabled',
            enabled: false,
            helperText: 'This field is disabled.',
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multiline',
  type: BaseInputField,
  path: 'Components/Input Field/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseInputFieldMultiline(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Input Field', 'Multiline'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Multiline textarea
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            placeholder: 'Enter your message...',
            label: 'Message',
            helperText: 'This is a multiline text input.',
            maxLines: 4,
            minLines: 3,
          ),
        ),

        // Multiline with filled variant
        Container(
          padding: const EdgeInsets.all(16),
          child: BaseInputField(
            textColor: UiColors.neutral900,
            variant: InputFieldVariant.filled,
            placeholder: 'Enter description...',
            label: 'Description',
            maxLines: 3,
            minLines: 2,
          ),
        ),
      ],
    ),
  );
}