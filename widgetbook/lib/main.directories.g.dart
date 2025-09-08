// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/components/badge/badge.configurable.widgetbook.dart'
    as _i2;
import 'package:widgetbook_workspace/components/badge/badge.showcase.widgetbook.dart'
    as _i3;
import 'package:widgetbook_workspace/components/button/button.configurable.widgetbook.dart'
    as _i4;
import 'package:widgetbook_workspace/components/button/button.showcase.widgetbook.dart'
    as _i5;
import 'package:widgetbook_workspace/components/checkbox.widgetbook.dart'
    as _i6;
import 'package:widgetbook_workspace/foundation/color.widgetbook.dart' as _i7;
import 'package:widgetbook_workspace/foundation/radius.widgetbook.dart' as _i8;
import 'package:widgetbook_workspace/foundation/spacing.widgetbook.dart' as _i9;
import 'package:widgetbook_workspace/foundation/text_styles.widgetbook.dart'
    as _i10;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'Components',
    children: [
      _i1.WidgetbookFolder(
        name: 'Badge',
        children: [
          _i1.WidgetbookFolder(
            name: 'Configurable',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BaseBadge',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableBadge',
                  builder: _i2.buildConfigurableBadge,
                  designLink:
                      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                ),
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'Showcase',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BadgeImage',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Badge Image Component',
                  builder: _i3.badgeImageComponent,
                  designLink:
                      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                ),
              ),
              _i1.WidgetbookComponent(
                name: 'BaseBadge',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Badge with Image',
                    builder: _i3.badgeWithImage,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Badge with Text',
                    builder: _i3.badge,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Badge with Widget',
                    builder: _i3.badgeWithWidget,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Interactive Badge with Checkbox',
                    builder: _i3.interactiveBadgeWithCheckbox,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                ],
              ),
              _i1.WidgetbookLeafComponent(
                name: 'BaseCheckbox',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Badge Checkbox Component',
                  builder: _i3.badgeCheckboxComponent,
                  designLink:
                      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
                ),
              ),
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Button',
        children: [
          _i1.WidgetbookFolder(
            name: 'Configurable',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BaseButton',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableButton',
                  builder: _i4.buildConfigurableButton,
                ),
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'Showcase',
            children: [
              _i1.WidgetbookComponent(
                name: 'BaseButton',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Filled',
                    builder: _i5.buildBaseButtonFilled,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7279&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Ghost',
                    builder: _i5.buildBaseButtonGhost,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Outline',
                    builder: _i5.buildBaseButtonOutlined,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Checkbox',
        children: [
          _i1.WidgetbookComponent(
            name: 'BaseCheckbox',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Checkbox',
                builder: _i6.checkbox,
                designLink:
                    'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
              ),
              _i1.WidgetbookUseCase(
                name: 'Radio Group',
                builder: _i6.radioGroup,
              ),
            ],
          )
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'Foundation',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'UiColors',
        useCase: _i1.WidgetbookUseCase(
          name: 'Color Palette',
          builder: _i7.buildUiColorsUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7271&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiRadius',
        useCase: _i1.WidgetbookUseCase(
          name: 'Border Radius System',
          builder: _i8.buildUiRadiusUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-radius',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiSpacing',
        useCase: _i1.WidgetbookUseCase(
          name: 'Spacing System',
          builder: _i9.buildUiSpacingUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7276&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiTextStyles',
        useCase: _i1.WidgetbookUseCase(
          name: 'Typography System',
          builder: _i10.buildUiTextStylesUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7272&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
    ],
  ),
];
