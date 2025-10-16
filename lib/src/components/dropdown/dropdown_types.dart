//Enums, option classes, and helpers
import 'package:flutter/material.dart';
import 'package:unping_ui/src/components/dropdown/base_dropdown.dart';

enum DropdownSize {
  /// Small Dropdown - compact size
  sm,

  /// Medium Dropdown - default size
  md,

  /// Large Dropdown - expanded size
  lg,
}

enum DropdownState {
  /// Normal state - default appearance
  normal,

  /// Error state
  error,

  /// Focused state change focus color
  focused,

  /// Disabled state
  disabled,
}

enum DropdownType {
  ///Single selection dropdown
  single,

  ///Multiple selection dropdown
  multi,

  ///Searchable combo box
  comboBox,

  ///Action menu dropdown
  action
}

///Overlay for Multiselect Dropdown
OverlayEntry OptionsOverlay(
  BaseDropdown widget,
  LayerLink layerLink,
  GlobalKey textFieldKey,
) {
  RenderBox renderBox =
      textFieldKey.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);
  return OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx - 290,
      top: offset.dy + size.height + 3,
      width: size.width,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
                color: widget.containerBackgroundColor,
                border: Border.all(
                  color: widget.borderRadiusColor,
                  width: widget.borderRadiusWidth,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius))),
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                String optionsValue = widget.options[index];
                return ListTile(
                  title: Text(optionsValue),
                  trailing: widget.selectedValues.contains(optionsValue)
                      ? Icon(Icons.done)
                      : SizedBox(),
                  onTap: () {
                    setState(
                      () {
                        manageSelectedValues(
                            widget.selectedValues, optionsValue);
                      },
                    );
                  },
                );
              },
            ),
          );
        }),
      ),
    ),
  );
}

///manage selected values add remove etc
void manageSelectedValues(List selectedValues, String valueToManage) {
  if (selectedValues.contains(valueToManage)) {
    selectedValues.remove(valueToManage);
  } else {
    selectedValues.add(valueToManage);
  }
}
