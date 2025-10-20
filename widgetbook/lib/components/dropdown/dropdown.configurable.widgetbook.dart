import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// UI library
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableDropdown',
  type: BaseDropdown,
  path: 'Components/Dropdown/Configurable',
  designLink:
      'https://www.figma.com/design/cSxzk4PnnsUO4mxTwKjkNf/unping-ui.com-%7C-Public--Community-?node-id=4919-61142&t=qP6frzBuXXGCqLoA-0',
)
Widget buildConfigurableDropdown(BuildContext context) {
  return UnpingUIContainer(
      breadcrumbs: ['Components', 'Dropdown', 'Configurable'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExampleSingleSelectDropdown(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExampleMultiSelectDropdown(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExampleComboboxDropdown(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExampleActionDropdownMenu(),
          )
        ],
      ));
}

class ExampleSingleSelectDropdown extends StatefulWidget {
  const ExampleSingleSelectDropdown({super.key});

  @override
  State<ExampleSingleSelectDropdown> createState() =>
      _ExampleSingleSelectDropdownState();
}

class _ExampleSingleSelectDropdownState
    extends State<ExampleSingleSelectDropdown> {
  String? selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Dropdowns.select(
      dropdownMenuWidth: 250,
      label: 'Single selection',
      textStyle: UiTextStyles.textSm,
      selectedValue: selectedValue,
      options: ['USA', 'Canada', 'Mexico'],
      onSelectedValueChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}

class ExampleMultiSelectDropdown extends StatefulWidget {
  const ExampleMultiSelectDropdown({super.key});

  @override
  State<ExampleMultiSelectDropdown> createState() =>
      _ExampleMultiSelectDropdownState();
}

class _ExampleMultiSelectDropdownState
    extends State<ExampleMultiSelectDropdown> {
  List<String> selectedValues = [];
  @override
  Widget build(BuildContext context) {
    return Dropdowns.multiSelect(
      label: 'Multi selection',
      dropdownMenuWidth: 250,
      textStyle: UiTextStyles.textSm,
      selectedValues: selectedValues,
      options: ['Flutter', 'Dart', 'React', 'Node.js', 'Python', 'R', 'C++'],
      onSelectedValueChanged: (value) {
        setState(() {
          selectedValues.add(value);
        });
      },
    );
  }
}

class ExampleComboboxDropdown extends StatefulWidget {
  const ExampleComboboxDropdown({super.key});

  @override
  State<ExampleComboboxDropdown> createState() =>
      _ExampleComboboxDropdownState();
}

class _ExampleComboboxDropdownState extends State<ExampleComboboxDropdown> {
  @override
  Widget build(BuildContext context) {
    return Dropdowns.combobox(
      label: 'Choose a Language',
      dropdownMenuWidth: 250,
      textStyle: UiTextStyles.textSm,
      options: ['Flutter', 'Dart', 'React', 'Node.js'],
      onSelectedValueChanged: (value) {
        debugPrint("You selected $value");
      },
    );
  }
}

class ExampleActionDropdownMenu extends StatefulWidget {
  const ExampleActionDropdownMenu({super.key});

  @override
  State<ExampleActionDropdownMenu> createState() =>
      _ExampleActionDropdownMenuState();
}

class _ExampleActionDropdownMenuState extends State<ExampleActionDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return MenuDropdown(
      icon: Icon(Icons.more_vert),
      divider: true,
      actionMenuGroups: [
        MenuDropdownItemGroup(
          groupTitle: "File",
          groupItems: [
            MenuDropdownItem(
              label: "New",
              icon: Icon(Icons.add),
              onTap: () {
                debugPrint("You pressed New");
              },
            ),
            MenuDropdownItem(
              label: "Open",
              icon: Icon(Icons.folder_open),
              onTap: () {
                debugPrint("You pressed Open");
              },
            ),
          ],
        ),
        MenuDropdownItemGroup(
          groupTitle: "Danger Zone",
          groupItems: [
            MenuDropdownItem(
              label: "Delete",
              destructive: true,
              icon: Icon(Icons.delete),
              onTap: () {
                debugPrint("You pressed Delete");
              },
            ),
          ],
        ),
      ],
    );
  }
}
