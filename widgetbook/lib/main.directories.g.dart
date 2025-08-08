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
import 'package:widgetbook_workspace/base_badge.dart' as _i2;
import 'package:widgetbook_workspace/base_button.dart' as _i3;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookLeafComponent(
    name: 'BadgeCheckbox',
    useCase: _i1.WidgetbookUseCase(
      name: 'Badge Checkbox Component',
      builder: _i2.badgeCheckboxComponent,
    ),
  ),
  _i1.WidgetbookLeafComponent(
    name: 'BadgeCount',
    useCase: _i1.WidgetbookUseCase(
      name: 'Badge Count Component',
      builder: _i2.badgeCountComponent,
    ),
  ),
  _i1.WidgetbookLeafComponent(
    name: 'BadgeDot',
    useCase: _i1.WidgetbookUseCase(
      name: 'Badge Dot Component',
      builder: _i2.badgeDotComponent,
    ),
  ),
  _i1.WidgetbookLeafComponent(
    name: 'BadgeImage',
    useCase: _i1.WidgetbookUseCase(
      name: 'Badge Image Component',
      builder: _i2.badgeImageComponent,
    ),
  ),
  _i1.WidgetbookComponent(
    name: 'BaseBadge',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Badge with Image',
        builder: _i2.badgeWithImage,
      ),
      _i1.WidgetbookUseCase(
        name: 'Badge with Text',
        builder: _i2.badge,
      ),
      _i1.WidgetbookUseCase(
        name: 'Badge with Widget',
        builder: _i2.badgeWithWidget,
      ),
    ],
  ),
  _i1.WidgetbookComponent(
    name: 'BaseButton',
    useCases: [
      _i1.WidgetbookUseCase(
        name: 'Filled',
        builder: _i3.buildBaseButtonFilled,
      ),
      _i1.WidgetbookUseCase(
        name: 'Ghost',
        builder: _i3.buildBaseButtonGhost,
      ),
      _i1.WidgetbookUseCase(
        name: 'Outline',
        builder: _i3.buildBaseButtonOutlined,
      ),
    ],
  ),
];
