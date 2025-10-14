import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// UI library
import 'package:unping_ui/unping_ui.dart';

@widgetbook.UseCase(
  name: 'ConfigurableDropdown',
  type: BaseDropdown,
  path: 'Components/Dropdown/Configurable',
)
Widget buildCoolButtonUseCase(BuildContext context) {
  return BaseDropdown();
}
