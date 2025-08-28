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
import 'package:widgetbook_workspace/components/base_badge.dart' as _i6;
import 'package:widgetbook_workspace/components/base_button.dart' as _i7;
import 'package:widgetbook_workspace/components/base_checkbox.dart' as _i8;
import 'package:widgetbook_workspace/foundation/color.dart' as _i2;
import 'package:widgetbook_workspace/foundation/radius.dart' as _i3;
import 'package:widgetbook_workspace/foundation/spacing.dart' as _i4;
import 'package:widgetbook_workspace/foundation/text_styles.dart' as _i5;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'Foundation',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'UiColors',
        useCase: _i1.WidgetbookUseCase(
          name: 'Color Palette',
          builder: _i2.buildUiColorsUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-colors',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiRadius',
        useCase: _i1.WidgetbookUseCase(
          name: 'Border Radius System',
          builder: _i3.buildUiRadiusUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-radius',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiSpacing',
        useCase: _i1.WidgetbookUseCase(
          name: 'Spacing System',
          builder: _i4.buildUiSpacingUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-spacing',
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'UiTextStyles',
        useCase: _i1.WidgetbookUseCase(
          name: 'Typography System',
          builder: _i5.buildUiTextStylesUseCase,
          designLink: 'https://www.figma.com/design/unping-ui-typography',
        ),
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'BadgeCount',
        useCase: _i1.WidgetbookUseCase(
          name: 'Badge Count Component',
          builder: _i6.badgeCountComponent,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'BadgeDot',
        useCase: _i1.WidgetbookUseCase(
          name: 'Badge Dot Component',
          builder: _i6.badgeDotComponent,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'BadgeImage',
        useCase: _i1.WidgetbookUseCase(
          name: 'Badge Image Component',
          builder: _i6.badgeImageComponent,
        ),
      ),
      _i1.WidgetbookComponent(
        name: 'BaseBadge',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Badge with Image',
            builder: _i6.badgeWithImage,
          ),
          _i1.WidgetbookUseCase(
            name: 'Badge with Text',
            builder: _i6.badge,
          ),
          _i1.WidgetbookUseCase(
            name: 'Badge with Widget',
            builder: _i6.badgeWithWidget,
          ),
          _i1.WidgetbookUseCase(
            name: 'Interactive Badge with Checkbox',
            builder: _i6.interactiveBadgeWithCheckbox,
          ),
        ],
      ),
      _i1.WidgetbookComponent(
        name: 'BaseButton',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Filled',
            builder: _i7.buildBaseButtonFilled,
          ),
          _i1.WidgetbookUseCase(
            name: 'Ghost',
            builder: _i7.buildBaseButtonGhost,
          ),
          _i1.WidgetbookUseCase(
            name: 'Outline',
            builder: _i7.buildBaseButtonOutlined,
          ),
        ],
      ),
      _i1.WidgetbookComponent(
        name: 'BaseCheckbox',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Badge Checkbox Component',
            builder: _i6.badgeCheckboxComponent,
          ),
          _i1.WidgetbookUseCase(
            name: 'Checkbox',
            builder: _i8.checkbox,
          ),
          _i1.WidgetbookUseCase(
            name: 'Radio Group',
            builder: _i8.radioGroup,
          ),
        ],
      ),
    ],
  ),
];
