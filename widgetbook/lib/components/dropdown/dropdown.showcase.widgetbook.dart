import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/l10n/language_extension.dart';
import 'package:widgetbook_workspace/l10n/unping_widgetbook_localizations.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
    name: 'Single',
    type: BaseDropdown,
    path: 'Components/Dropdown/Showcase',
    designLink:
        'https://www.figma.com/design/cSxzk4PnnsUO4mxTwKjkNf/unping-ui.com-%7C-Public--Community-?node-id=4919-61142&t=qP6frzBuXXGCqLoA-0')
Widget buildBaseDropdownSingle(BuildContext context) {
  AppLocalizations localizations = context.lang;
  String? selectedValue = '';
  List<String> options = ['USA', 'Canada', 'Mexico'];
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Single'],
    child: Column(
      spacing: UiSpacing.spacing10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ///Normal
        Dropdowns.select(
          size: dropdownSize,
          label: localizations.singleSelect,
          textStyle: labelStyle,
          state: DropdownState.normal,
          errorMessage: localizations.error,
          selectedValue: selectedValue,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValue = value;
          },
        ),

        ///Without border
        Dropdowns.select(
          size: dropdownSize,
          label: localizations.singleSelect,
          textStyle: labelStyle,
          state: DropdownState.normal,
          errorMessage: localizations.error,
          selectedValue: selectedValue,
          isSearchable: true,
          withBorder: false,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValue = value;
          },
        ),

        ///disabled
        Dropdowns.select(
          size: dropdownSize,
          label: localizations.singleSelect,
          textStyle: labelStyle,
          state: DropdownState.disabled,
          errorMessage: localizations.error,
          selectedValue: selectedValue,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValue = value;
          },
        ),

        ///Error
        Dropdowns.select(
          size: dropdownSize,
          label: localizations.singleSelect,
          textStyle: labelStyle,
          state: DropdownState.error,
          errorMessage: localizations.error,
          selectedValue: selectedValue,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValue = value;
          },
        )
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multi Select',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildBaseDropdownMulti(BuildContext context) {
  AppLocalizations localizations = context.lang;
  List<String> options = [
    'Flutter',
    'Dart',
    'React',
    'Node.js',
    'Python',
    'R',
    'C++'
  ];
  List<String> selectedValues = [];
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Multi Select'],
    child: Column(
      spacing: UiSpacing.spacing10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ///Normal
        Dropdowns.multiSelect(
          label: localizations.multiSelect,
          size: dropdownSize,
          textStyle: labelStyle,
          state: DropdownState.normal,
          errorMessage: localizations.error,
          selectAllText: localizations.selectAll,
          clearAllText: localizations.clearAll,
          selectedValues: selectedValues,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValues.add(value);
          },
        ),

        ///Normal selected
        Dropdowns.multiSelect(
          label: localizations.multiSelect,
          size: dropdownSize,
          textStyle: labelStyle,
          state: DropdownState.normal,
          errorMessage: localizations.error,
          selectAllText: localizations.selectAll,
          clearAllText: localizations.clearAll,
          selectedValues: ['Flutter', 'Dart'],
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValues.add(value);
          },
        ),

        ///Without border
        Dropdowns.multiSelect(
          label: localizations.multiSelect,
          size: dropdownSize,
          textStyle: labelStyle,
          state: DropdownState.normal,
          errorMessage: localizations.error,
          selectAllText: localizations.selectAll,
          clearAllText: localizations.clearAll,
          selectedValues: selectedValues,
          isSearchable: true,
          withBorder: false,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValues.add(value);
          },
        ),

        ///disabled
        Dropdowns.multiSelect(
          label: localizations.multiSelect,
          size: dropdownSize,
          textStyle: labelStyle,
          state: DropdownState.disabled,
          errorMessage: localizations.error,
          selectAllText: localizations.selectAll,
          clearAllText: localizations.clearAll,
          selectedValues: selectedValues,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValues.add(value);
          },
        ),

        ///Error
        Dropdowns.multiSelect(
          label: localizations.multiSelect,
          size: dropdownSize,
          textStyle: labelStyle,
          state: DropdownState.error,
          errorMessage: localizations.error,
          selectAllText: localizations.selectAll,
          clearAllText: localizations.clearAll,
          selectedValues: selectedValues,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            selectedValues.add(value);
          },
        )
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Combobox',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildBaseDropdownCombobox(BuildContext context) {
  AppLocalizations localizations = context.lang;
  List<String> options = ['Flutter', 'Dart', 'React', 'Node.js'];
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Combobox'],
    child: Column(
      spacing: UiSpacing.spacing10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Dropdowns.combobox(
          label: localizations.chooseALanguage,
          size: dropdownSize,
          textStyle: labelStyle,
          errorMessage: localizations.error,
          state: DropdownState.normal,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            debugPrint("You selected $value");
          },
        ),

        ///Without border
        Dropdowns.combobox(
          label: localizations.chooseALanguage,
          size: dropdownSize,
          textStyle: labelStyle,
          errorMessage: localizations.error,
          state: DropdownState.normal,
          isSearchable: true,
          withBorder: false,
          options: options,
          onSelectedValueChanged: (value) {
            debugPrint("You selected $value");
          },
        ),

        ///Disabled
        Dropdowns.combobox(
          label: localizations.chooseALanguage,
          size: dropdownSize,
          textStyle: labelStyle,
          errorMessage: localizations.error,
          state: DropdownState.disabled,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            debugPrint("You selected $value");
          },
        ),

        ///Error
        Dropdowns.combobox(
          label: localizations.chooseALanguage,
          size: dropdownSize,
          textStyle: labelStyle,
          errorMessage: localizations.error,
          state: DropdownState.error,
          isSearchable: true,
          withBorder: true,
          options: options,
          onSelectedValueChanged: (value) {
            debugPrint("You selected $value");
          },
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Action',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildBaseDropdownAction(BuildContext context) {
  AppLocalizations localizations = context.lang;
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Action'],
    child: Column(
      spacing: UiSpacing.spacing10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ///Normal Action Menu with label
        Dropdowns.menu(
          label: localizations.option,
          leadingDropdownIcon: Icon(Icons.more_vert),
          trailingDropdownIcon: Icon(Icons.arrow_drop_down),
          textStyle: labelStyle,
          size: dropdownSize,
          state: DropdownState.normal,
          actionMenuDivider: true,
          actionMenuGroups: [
            MenuDropdownItemGroup(
              groupTitle: localizations.file,
              groupItems: [
                MenuDropdownItem(
                  label: localizations.newItem,
                  icon: Icon(Icons.add),
                  onTap: () {
                    debugPrint("You pressed New");
                  },
                ),
                MenuDropdownItem(
                  label: localizations.open,
                  icon: Icon(Icons.folder_open),
                  onTap: () {
                    debugPrint("You pressed Open");
                  },
                ),
              ],
            ),
            MenuDropdownItemGroup(
              groupTitle: localizations.dangerZone,
              groupItems: [
                MenuDropdownItem(
                  label: localizations.delete,
                  destructive: true,
                  icon: Icon(Icons.delete),
                  onTap: () {
                    debugPrint("You pressed Delete");
                  },
                ),
              ],
            ),
          ],
        ),

        ///Normal without label
        Dropdowns.menu(
          leadingDropdownIcon: Icon(Icons.more_vert),
          withBorder: false,
          textStyle: labelStyle,
          size: DropdownSize.sm,
          state: DropdownState.normal,
          actionMenuDivider: true,
          actionMenuGroups: [
            MenuDropdownItemGroup(
              groupTitle: localizations.file,
              groupItems: [
                MenuDropdownItem(
                  label: localizations.newItem,
                  icon: Icon(Icons.add),
                  onTap: () {
                    debugPrint("You pressed New");
                  },
                ),
                MenuDropdownItem(
                  label: localizations.open,
                  icon: Icon(Icons.folder_open),
                  onTap: () {
                    debugPrint("You pressed Open");
                  },
                ),
              ],
            ),
            MenuDropdownItemGroup(
              groupTitle: localizations.dangerZone,
              groupItems: [
                MenuDropdownItem(
                  label: localizations.delete,
                  destructive: true,
                  icon: Icon(Icons.delete),
                  onTap: () {
                    debugPrint("You pressed Delete");
                  },
                ),
              ],
            ),
          ],
        ),

        ///Disabled state
        Dropdowns.menu(
          leadingDropdownIcon: Icon(Icons.more_vert),
          trailingDropdownIcon: Icon(Icons.arrow_drop_down),
          label: localizations.option,
          textStyle: labelStyle,
          size: dropdownSize,
          state: DropdownState.disabled,
          actionMenuDivider: true,
          actionMenuGroups: [
            MenuDropdownItemGroup(
              groupTitle: localizations.file,
              groupItems: [
                MenuDropdownItem(
                  label: localizations.newItem,
                  icon: Icon(Icons.add),
                  onTap: () {
                    debugPrint("You pressed New");
                  },
                ),
                MenuDropdownItem(
                  label: localizations.open,
                  icon: Icon(Icons.folder_open),
                  onTap: () {
                    debugPrint("You pressed Open");
                  },
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

DropdownSize dropdownSize = DropdownSize.md;
TextStyle labelStyle = UiTextStyles.textMd;
