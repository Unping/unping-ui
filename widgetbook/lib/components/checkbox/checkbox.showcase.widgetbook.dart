import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@UseCase(
  name: 'Checkbox',
  type: BaseCheckbox,
  path: 'Components/Checkbox/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget checkbox(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Checkbox'],
    child: Column(
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
  ));
}

