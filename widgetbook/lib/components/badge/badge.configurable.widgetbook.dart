import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

/// Example stateful checkbox widget for demonstration in Widgetbook
class _ExampleCheckbox extends StatefulWidget {
  const _ExampleCheckbox();

  @override
  State<_ExampleCheckbox> createState() => _ExampleCheckboxState();
}

class _ExampleCheckboxState extends State<_ExampleCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Badges.checkbox(
      isChecked: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}

/// Helper function to create badge widgets based on type
Widget? _createBadgeWidget(String widgetType, {int countValue = 5}) {
  switch (widgetType) {
    case 'dot':
      return const BadgeDot();
    case 'image':
      return const BadgeImage(
        imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
      );
    case 'checkbox':
      return const _ExampleCheckbox();
    case 'count':
      return BadgeCount(count: countValue);
    case 'none':
    default:
      return null;
  }
}

@widgetbook.UseCase(
  name: 'ConfigurableBadge',
  type: BaseBadge,
  path: 'Components/Badge/Configurable',
  designLink: 'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildConfigurableBadge(BuildContext context) {
  // Basic properties
  final badgeText = context.knobs.string(
    label: 'Text',
    initialValue: 'Label',
  );

  final size = context.knobs.list(
    label: 'Size',
    options: BadgeSize.values,
    labelBuilder: (value) => value.name.toUpperCase(),
    initialOption: BadgeSize.md,
  );

  final textColor = context.knobs.listOrNull(
    label: 'Text Color',
    options: [
      null, // Default
      UiColors.onPrimary,
      UiColors.neutral800,
      UiColors.neutral600,
      UiColors.primary600,
      UiColors.success600,
      UiColors.warning600,
      UiColors.error600,
    ],
    labelBuilder: (color) => color != null ? UiColors.getColorName(color) : 'Default',
  );

  // Left Widget 1 configuration
  final leftWidget1Type = context.knobs.list(
    label: 'Left Widget 1',
    options: ['none', 'dot', 'image', 'checkbox'],
    initialOption: 'none',
  );

  final leftWidget1 = _createBadgeWidget(leftWidget1Type);

  // Left Widget 2 configuration (only if leftWidget1 is present)
  Widget? leftWidget2;
  if (leftWidget1 != null) {
    final leftWidget2Type = context.knobs.list(
      label: 'Left Widget 2',
      options: ['none', 'dot', 'image', 'checkbox'],
      initialOption: 'none',
    );

    leftWidget2 = _createBadgeWidget(leftWidget2Type);
  }

  // Right Widget configuration
  final rightWidgetType = context.knobs.list(
    label: 'Right Widget',
    options: ['none', 'dot', 'image', 'checkbox', 'count'],
    initialOption: 'none',
  );

  final countValue = rightWidgetType == 'count'
    ? context.knobs.int.slider(
        label: 'Count Value',
        initialValue: 5,
        min: 1,
        max: 9999999,
      )
    : 5;

  final rightWidget = _createBadgeWidget(rightWidgetType, countValue: countValue);

  // Badge behavior
  final isRemovable = context.knobs.boolean(
    label: 'Removable',
    initialValue: false,
  );

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Badge', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Badges.badge(
              text: badgeText.isEmpty ? 'Label' : badgeText,
              leftWidget1: leftWidget1,
              leftWidget2: leftWidget2,
              rightWidget: rightWidget,
              size: size,
              textColor: textColor ?? UiColors.onPrimary,
              removable: isRemovable,
              onRemove: isRemovable ? () {
                // Handle remove action in widgetbook
              } : null,
            ),
          ),
        ])
      ],
    ),
  );
}