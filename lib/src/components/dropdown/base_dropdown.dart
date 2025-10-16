import 'package:flutter/material.dart';
import 'package:unping_ui/src/components/dropdown/dropdown_types.dart';
import 'package:unping_ui/src/foundation/foundation.dart';
import 'package:unping_ui/unping_ui.dart';

class BaseDropdown<T> extends StatefulWidget {
  ///Labeling widget
  final String? label;

  ///Current state of the Dropdown
  final DropdownState state;

  ///Type of dropdown
  final DropdownType dropdownType;

  /// Callback when the Dropdown state changes
  final ValueChanged<DropdownState>? onDropdownStateChanged;

  ///Current size of the Dropdown
  final DropdownSize size;

  //for Single or multiple selection
  final bool isMultiSelect;

  /// For searching enabled or disabled
  final bool isSearchable;

  //Selected DropdownMenuItem
  final String? selectedValue;
  final ValueChanged<String> onSelectedValueChanged;

  ///List Options
  final List<String> options;

  /// Selected values
  final List<String> selectedValues;

  //Enable Keyboard navigations
  final bool enableKeyboardNavigation;

  //Sort the dropdown menu Item
  final bool sortMenuItems;

  /// Text style of the dropdown button text
  final TextStyle? textStyle;

  /// Padding around the visible portion of the dropdown widget.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the Dropdown
  final double borderRadius;
  final double borderRadiusWidth;

  //Dropdown Colors
  final Color? dropdownColor;
  final Color? containerBackgroundColor;
  final Color borderRadiusColor;

  /// width of the dropDown
  final double dropdownMenuWidth;

  const BaseDropdown({
    super.key,
    this.label,
    this.state = DropdownState.normal,
    required this.dropdownType,
    this.onDropdownStateChanged,
    this.size = DropdownSize.md,
    this.isMultiSelect = false,
    this.isSearchable = true,
    this.selectedValue,
    required this.onSelectedValueChanged,
    this.selectedValues = const [],
    this.options = const [],
    this.enableKeyboardNavigation = false,
    this.sortMenuItems = false,
    this.textStyle, //assign later
    this.padding = const EdgeInsets.all(5),
    this.borderRadius = UiRadius.xs,
    this.borderRadiusWidth = 1,
    this.dropdownColor = UiColors.neutral700,
    this.containerBackgroundColor = UiColors.neutral700,
    this.borderRadiusColor = UiColors.neutral300,
    this.dropdownMenuWidth = 150,
  });
  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
//On Dropdown Value changed
  void onDropdownValueSelected(value) {
    setState(() {
      widget.onSelectedValueChanged(value!);
    });
  }

  ///manage selected values add remove etc
  void manageSelectedValues(List selectedValues, String valueToManage) {
    if (selectedValues.contains(valueToManage)) {
      selectedValues.remove(valueToManage);
    } else {
      selectedValues.add(valueToManage);
    }
  }

//To prevent duplicates in the options list
  bool NoDuplicates() {
    return widget.options.toSet().length == widget.options.length;
  }

//Return a list of Dropdown menu items
  List<DropdownMenuEntry> getMenuEntries() {
    List<DropdownMenuEntry> entries = [];
    for (var option in widget.options) {
      entries.add(DropdownMenuEntry(value: option, label: option));
    }
    return entries;
  }

  ///for the Input Field
  TextEditingController textController = TextEditingController();
  LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  GlobalKey textFieldGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> menuEntries = getMenuEntries();

    ///Duplicate check for the option list to avoid double Keys
    assert(NoDuplicates(), "No duplicates in the options list allowed");

    ///Return Depending on the type of Dropdown
    switch (widget.dropdownType) {
      ///Single selection dropdown
      case DropdownType.single:
        return Center(
            child: DropdownMenu(
          label: widget.label != null ? Text(widget.label!) : SizedBox(),
          enableSearch: widget.isSearchable,
          width: widget.dropdownMenuWidth,
          dropdownMenuEntries: menuEntries,
          onSelected: onDropdownValueSelected,
          alignmentOffset: const Offset(0, 3),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: widget.dropdownColor,
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: widget.borderRadiusColor,
                  width: widget.borderRadiusWidth,
                )),
          ),
          menuStyle: MenuStyle(
              side: WidgetStatePropertyAll(BorderSide(
                color: widget.borderRadiusColor,
                width: widget.borderRadiusWidth,
              )),
              backgroundColor:
                  WidgetStatePropertyAll(widget.containerBackgroundColor),
              fixedSize: WidgetStatePropertyAll(
                  Size(widget.dropdownMenuWidth, double.infinity))),
        ));

      /// Multiple selection dropdown
      case DropdownType.multi:
        return Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: widget.dropdownMenuWidth,
                child: Wrap(
                  children: widget.selectedValues.map((selectedOption) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Chip(
                        label: Text(selectedOption),
                        onDeleted: () {
                          setState(() {
                            manageSelectedValues(
                                widget.selectedValues, selectedOption);
                          });
                        },
                        deleteIcon: Icon(Icons.close),
                        backgroundColor: widget.containerBackgroundColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              width: widget.dropdownMenuWidth,
              child: CompositedTransformTarget(
                link: layerLink,
                child: TextField(
                  key: textFieldGlobalKey,
                  controller: textController,
                  style: widget.textStyle,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.containerBackgroundColor,
                    labelText: widget.label,
                    suffixIcon: IconButton(
                      icon: Icon(overlayEntry == null
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up),
                      color: UiColors.background,
                      onPressed: () {
                        setState(() {
                          if (overlayEntry == null) {
                            overlayEntry = OptionsOverlay(
                                widget, layerLink, textFieldGlobalKey);
                            Overlay.of(context).insert(overlayEntry!);
                          } else {
                            overlayEntry!.remove();
                            overlayEntry = null;
                          }
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                            color: widget.borderRadiusColor,
                            width: widget.borderRadiusWidth)),
                  ),
                ),
              ),
            )
          ],
        ));

      /// Searchable combo box
      case DropdownType.comboBox:
        return Placeholder();

      ///Action menu dropdown
      case DropdownType.action:
        return Placeholder();
    }
  }
}
