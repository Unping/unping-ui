import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unping_ui/src/foundation/foundation.dart';

class BaseDropdown extends StatefulWidget {
  const BaseDropdown({super.key});

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: UiColors.primary500,
        child: DropdownButton(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          dropdownColor: UiColors.primary500,
          items: [
            DropdownMenuItem(child: Text("Hello"), value: "Hello"),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
