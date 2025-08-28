import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Checkbox',
  type: BaseCheckbox,
  path: 'Components/Checkbox',
)
Widget checkbox(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.indeterminate,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.normal,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.indeterminate,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.indeterminate,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.disabled,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.disabled,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.checkbox(
            size: CheckboxSize.sm,
            state: CheckboxState.indeterminate,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.disabled,
          ),
        ),
      ]),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.sm,
              state: CheckboxState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.sm,
              state: CheckboxState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.sm,
              state: CheckboxState.indeterminate,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.md,
              state: CheckboxState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.md,
              state: CheckboxState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.md,
              state: CheckboxState.indeterminate,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.lg,
              state: CheckboxState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.lg,
              state: CheckboxState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.checkbox(
              size: CheckboxSize.lg,
              state: CheckboxState.indeterminate,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
    ],
  );
}

@UseCase(
  name: 'Radio Group',
  type: BaseCheckbox,
  path: 'Components/Checkbox',
)
Widget radioGroup(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.normal,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.hovered,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.focused,
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.unchecked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.disabled,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Checkboxes.radio(
            size: CheckboxSize.sm,
            state: RadioState.checked,
            onChanged: (state) => {},
            forceVisualState: CheckboxVisualState.disabled,
          ),
        ),
      ]),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.sm,
              state: RadioState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.sm,
              state: RadioState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.md,
              state: RadioState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.md,
              state: RadioState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.lg,
              state: RadioState.unchecked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Checkboxes.radio(
              size: CheckboxSize.lg,
              state: RadioState.checked,
              onChanged: (state) => {},
              label: 'Custom styled checkbox',
              description: 'This checkbox has custom text styles.',
              forceVisualState: CheckboxVisualState.disabled,
            ),
          ),
        ],
      ),
    ],
  );
}
