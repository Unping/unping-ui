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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExampleSingleSelectDropdown(),
            ],
          ),
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
  List<DropdownMenuEntry> options = [
    DropdownMenuEntry(value: 'Apple', label: 'Apple'),
    DropdownMenuEntry(value: 'Banana', label: 'Banana'),
    DropdownMenuEntry(value: 'Cherry', label: 'Cherry'),
    DropdownMenuEntry(value: 'Date', label: 'Date'),
    DropdownMenuEntry(value: 'Elderberry', label: 'Elderberry'),
  ];

  String? selectedValue = 'Apple';

  // @override
  // void initState() {
  //   selectedValue = options[0];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BaseDropdown(
      textStyle: UiTextStyles.textSm,
      selectedValue: selectedValue,
      options: options,
      onSelectedValueChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
