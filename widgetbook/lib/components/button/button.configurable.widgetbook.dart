import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableButton',
  type: BaseButton,
  path: 'Components/Button/Configurable',
)
Widget buildConfigurableButton(BuildContext context) {
  // Button type selection
  final buttonType = context.knobs.list(
    label: 'Button Type',
    options: ['filled', 'ghost', 'outline'],
    initialOption: 'filled',
  );

  // Basic properties
  final buttonText = context.knobs.string(
    label: 'Text',
    initialValue: 'Button',
  );

  // Color properties - only available for all button types
  final textColor = context.knobs.listOrNull(
    label: 'Text Color (override default)',
    options: [
      null, // Default for button type
      UiColors.neutral800,
      UiColors.onPrimary,
      UiColors.primary600,
      UiColors.success600,
      UiColors.warning600,
      UiColors.error600,
    ],
    labelBuilder: (color) => color != null ? UiColors.getColorName(color) : 'Default',
  );


  final hasIcon = context.knobs.boolean(
    label: 'Has Icon',
    initialValue: false,
  );

  // Build icon widget
  Widget? iconWidget;
  if (hasIcon) {
    final iconType = context.knobs.list(
      label: 'Icon Type',
      options: ['star', 'heart', 'check', 'add', 'arrow'],
      initialOption: 'star',
    );
    
    // Use appropriate default color for icon based on button type
    Color iconColor;
    if (textColor != null) {
      iconColor = textColor;
    } else {
      switch (buttonType) {
        case 'filled':
          iconColor = UiColors.neutral800;
          break;
        case 'ghost':
        case 'outline':
          iconColor = UiColors.onPrimary;
          break;
        default:
          iconColor = UiColors.neutral800;
      }
    }
    
    iconWidget = _buildIcon(iconType, iconColor);
  }

  final iconPosition = context.knobs.list(
    label: 'Icon Position',
    options: IconPosition.values,
    labelBuilder: (value) => value.name,
    initialOption: IconPosition.trailing,
  );

  final isDisabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  final underlineText = context.knobs.boolean(
    label: 'Underline Text',
    initialValue: false,
  );

  // Force state for showcasing
  final forceState = context.knobs.listOrNull(
    label: 'Force State',
    options: ButtonState.values,
    labelBuilder: (value) => value?.name ?? 'None',
  );

  // Text style
  final textStyle = context.knobs.listOrNull(
    label: 'Text Style (override default)',
    options: [
      null, // Default
      UiTextStyles.textXs,
      UiTextStyles.textSm,
      UiTextStyles.textMd,
      UiTextStyles.textLg,
      UiTextStyles.textXl,
    ],
    labelBuilder: (style) => style != null ? UiTextStyles.getTextStyleName(style) : 'Default',
  );


  // Create the appropriate button based on type
  BaseButton button;
  switch (buttonType) {
    case 'filled':
      button = Buttons.filled(
        text: buttonText.isEmpty ? null : buttonText,
        icon: iconWidget,
        iconPosition: iconPosition,
        onPressed: isDisabled ? null : () {},
        textColor: textColor ?? UiColors.neutral800,
        underlineText: underlineText,
        textStyle: textStyle,
        forceState: forceState,
      );
      break;
    case 'ghost':
      button = Buttons.ghost(
        text: buttonText.isEmpty ? null : buttonText,
        icon: iconWidget,
        iconPosition: iconPosition,
        onPressed: isDisabled ? null : () {},
        textColor: textColor ?? UiColors.onPrimary,
        underlineText: underlineText,
        textStyle: textStyle,
        forceState: forceState,
      );
      break;
    case 'outline':
      button = Buttons.outline(
        text: buttonText.isEmpty ? null : buttonText,
        icon: iconWidget,
        iconPosition: iconPosition,
        onPressed: isDisabled ? null : () {},
        textColor: textColor ?? UiColors.onPrimary,
        underlineText: underlineText,
        textStyle: textStyle,
        forceState: forceState,
      );
      break;
    default:
      button = Buttons.filled(
        text: buttonText.isEmpty ? null : buttonText,
        icon: iconWidget,
        iconPosition: iconPosition,
        onPressed: isDisabled ? null : () {},
        textColor: textColor ?? UiColors.neutral800,
        underlineText: underlineText,
        textStyle: textStyle,
        forceState: forceState,
      );
  }

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Button', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: button,
          ),
        ])
      ],
    ),
  );
}

Widget _buildIcon(String iconType, Color color) {
  switch (iconType) {
    case 'star':
      return Icon(Icons.star, size: 16, color: color);
    case 'heart':
      return Icon(Icons.favorite, size: 16, color: color);
    case 'check':
      return Icon(Icons.check, size: 16, color: color);
    case 'add':
      return Icon(Icons.add, size: 16, color: color);
    case 'arrow':
      return Icon(Icons.arrow_forward, size: 16, color: color);
    default:
      return Icon(Icons.star, size: 16, color: color);
  }
}