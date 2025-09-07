import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'Filled',
  type: BaseButton,
  path: 'Components/Button/Showcase',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildBaseButtonFilled(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Button', 'Filled'],
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),
      //Hovered state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
      ]),
      //Focused state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
      ]),
      //Disabled state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: null,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.filled(
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFF2A313C), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),

    ],
  ));
}

@widgetbook.UseCase(
  name: 'Outline',
  type: BaseButton,
  path: 'Components/Button/Showcase',
)
Widget buildBaseButtonOutlined(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Button', 'Outline'],
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),
      //Hovered state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
      ]),
      //Focused state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
      ]),
      //Disabled state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: null,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.outline(
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),
    ],
  ));
}

@widgetbook.UseCase(
  name: 'Ghost',
  type: BaseButton,
  path: 'Components/Button/Showcase',
)
Widget buildBaseButtonGhost(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Button', 'Ghost'],
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),
      //Hovered state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.hovered
          ),
        ),
      ]),
      //Focused state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            onPressed: () {},
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
            forceState: ButtonState.focused
          ),
        ),
      ]),
      //Disabled state
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: null,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.leading,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            text: 'Button',
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Buttons.ghost(
            onPressed: null,
            icon: Icon(
              Icons.radio_button_unchecked,
              size: 16,
              color: Color(0xFFFFFFFF), // Match the text color
            ),
            iconPosition: IconPosition.trailing,
          ),
        ),
      ]),
    ],
  ));
}

