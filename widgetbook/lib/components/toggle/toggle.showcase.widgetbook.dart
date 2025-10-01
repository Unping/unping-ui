import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@UseCase(
  name: 'Toggle',
  type: ToggleSwitch,
  path: 'Components/Toggle/Showcase',
  designLink:
      'https://www.figma.com/design/A4jImS7idoqAbZ2Db7E9zT/unping-ui.com-%7C-Public--Community-?node-id=4913-7283&p=f&t=PR11WcPWO8bHVDII-0',
)

Widget toggle(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Toggle'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Normal states
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              size: ToggleSize.md,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: true,
              onChanged: (_) {},
              size: ToggleSize.md,
            ),
          ),
        ]),
        // Focused states
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              size: ToggleSize.md,
              forceVisualState: ToggleVisualState.focused,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: true,
              onChanged: (_) {},
              size: ToggleSize.md,
              forceVisualState: ToggleVisualState.focused,
            ),
          ),
        ]),
        // Disabled states
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: false,
              onChanged: (_) {},
              size: ToggleSize.md,
              isDisabled: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Toggles.switchToggle(
              value: true,
              onChanged: (_) {},
              size: ToggleSize.md,
              isDisabled: true,
            ),
          ),
        ]),
        // With label + description
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: false,
                    onChanged: (_) {},
                    size: ToggleSize.sm,
                    label: 'Small toggle',
                    description: 'This is a small sized toggle.',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: false,
                    onChanged: (_) {},
                    size: ToggleSize.md,
                    label: 'Medium toggle',
                    description: 'This is a medium sized toggle.',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: false,
                    onChanged: (_) {},
                    size: ToggleSize.lg,
                    label: 'Large toggle',
                    description: 'This is a large sized toggle.',
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: true,
                    onChanged: (_) {},
                    size: ToggleSize.sm,
                    label: 'Small toggle',
                    description: 'This is a small sized toggle.',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: true,
                    onChanged: (_) {},
                    size: ToggleSize.md,
                    label: 'Medium toggle',
                    description: 'This is a medium sized toggle.',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Toggles.switchToggle(
                    value: true,
                    onChanged: (_) {},
                    size: ToggleSize.lg,
                    label: 'Large toggle',
                    description: 'This is a large sized toggle.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
