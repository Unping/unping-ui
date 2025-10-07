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
import 'package:widgetbook_workspace/components/checkbox/checkbox.configurable.widgetbook.dart'
    as _i6;
import 'package:widgetbook_workspace/components/checkbox/checkbox.showcase.widgetbook.dart'
    as _i8;
import 'package:widgetbook_workspace/components/checkbox/radiogroup.configurable.widgetbook.dart'
    as _i7;
import 'package:widgetbook_workspace/components/checkbox/radiogroup.showcase.widgetbook.dart'
    as _i9;
import 'package:widgetbook_workspace/components/inputs/input.configurable.widgetbook.dart'
    as _i10;
import 'package:widgetbook_workspace/components/inputs/input.showcase.widgetbook.dart'
    as _i11;
import 'package:widgetbook_workspace/components/notification.widgetbook.dart'
    as _i19;
import 'package:widgetbook_workspace/components/toggle/toggle.configurable.widgetbook.dart'
    as _i12;
import 'package:widgetbook_workspace/components/toggle/toggle.showcase.widgetbook.dart'
    as _i13;
import 'package:widgetbook_workspace/components/tooltip/tooltip.showcase.widgetbook.dart'
    as _i14;
import 'package:widgetbook_workspace/foundation/color.widgetbook.dart' as _i15;
import 'package:widgetbook_workspace/foundation/radius.widgetbook.dart' as _i16;
import 'package:widgetbook_workspace/foundation/spacing.widgetbook.dart'
    as _i17;
import 'package:widgetbook_workspace/foundation/text_styles.widgetbook.dart'
    as _i18;

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
          _i1.WidgetbookFolder(
            name: 'Configurable',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BaseCheckbox',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableCheckbox',
                  builder: _i6.buildConfigurableCheckbox,
                  designLink:
                      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: '_ExampleRadioGroup',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableRadioGroup',
                  builder: _i7.buildConfigurableRadioGroup,
                  designLink:
                      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
                ),
              ),
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'Showcase',
            children: [
              _i1.WidgetbookComponent(
                name: 'BaseCheckbox',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Checkbox',
                    builder: _i8.checkbox,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Radio Group',
                    builder: _i9.radioGroup,
                    designLink:
                        'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7284&p=f&t=fMXcYIOzZi7Elvf6-0',
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Input',
        children: [
          _i1.WidgetbookFolder(
            name: 'Configurable',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BaseInput',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableInput',
                  builder: _i10.buildConfigurableInput,
                ),
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'Showcase',
            children: [
              _i1.WidgetbookComponent(
                name: 'BaseInput',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Password',
                    builder: _i11.showcasePasswordInput,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Search',
                    builder: _i11.showcaseSearchInput,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Text',
                    builder: _i11.showcaseTextInput,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Text Area',
                    builder: _i11.showcaseTextArea,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Toggle',
        children: [
          _i1.WidgetbookFolder(
            name: 'Configurable',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'ToggleSwitch',
                useCase: _i1.WidgetbookUseCase(
                  name: 'ConfigurableToggle',
                  builder: _i12.buildConfigurableToggle,
                  designLink:
                      'https://www.figma.com/design/A4jImS7idoqAbZ2Db7E9zT/unping-ui.com-%7C-Public--Community-?node-id=4913-7283&p=f&t=PR11WcPWO8bHVDII-0',
                ),
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'Showcase',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'ToggleSwitch',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Toggle',
                  builder: _i13.toggle,
                  designLink:
                      'https://www.figma.com/design/A4jImS7idoqAbZ2Db7E9zT/unping-ui.com-%7C-Public--Community-?node-id=4913-7283&p=f&t=PR11WcPWO8bHVDII-0',
                ),
              )
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Tooltip',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'UiTooltip',
            useCase: _i1.WidgetbookUseCase(
              name: 'Tooltip – placements & variants',
              builder: _i14.tooltipShowcase,
              designLink:
                  'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4938-63907',
            ),
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
          builder: _i15.buildUiColorsUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7271&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiRadius',
        useCase: _i1.WidgetbookUseCase(
          name: 'Border Radius System',
          builder: _i16.buildUiRadiusUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-radius',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiSpacing',
        useCase: _i1.WidgetbookUseCase(
          name: 'Spacing System',
          builder: _i17.buildUiSpacingUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7276&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiTextStyles',
        useCase: _i1.WidgetbookUseCase(
          name: 'Typography System',
          builder: _i18.buildUiTextStylesUseCase,
          designLink:
              'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7272&p=f&t=fMXcYIOzZi7Elvf6-0',
        ),
      ),
    ],
  ),
      _i1.WidgetbookFolder(
        name: 'notification',
        children: [
          _i1.WidgetbookComponent(
            name: 'BaseNotification',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Base Notification',
                builder: _i19.baseNotificationUseCase,
              ),
              _i1.WidgetbookUseCase(
                name: 'Custom Styled Notifications',
                builder: _i19.customStyledNotificationsUseCase,
              ),
            ],
          ),
          _i1.WidgetbookLeafComponent(
            name: 'Notifications',
            useCase: _i1.WidgetbookUseCase(
              name: 'Notification Variants',
              builder: _i19.notificationVariantsUseCase,
            ),
          ),
          _i1.WidgetbookComponent(
            name: 'SnackbarNotification',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Snackbar Notification',
                builder: _i19.snackbarNotificationUseCase,
              ),
              _i1.WidgetbookUseCase(
                name: 'Snackbar Notification Variants',
                builder: _i19.snackbarNotificationVariantsUseCase,
              ),
            ],
          ),
          _i1.WidgetbookComponent(
            name: 'ToastNotification',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Toast Notification',
                builder: _i19.toastNotificationUseCase,
              ),
              _i1.WidgetbookUseCase(
                name: 'Toast Notification Variants',
                builder: _i19.toastNotificationVariantsUseCase,
              ),
            ],
          ),
        ],
      )
];
