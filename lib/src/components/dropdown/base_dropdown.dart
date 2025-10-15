import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unping_ui/src/foundation/foundation.dart';
import 'package:unping_ui/unping_ui.dart';

//Dropdown size variants
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

class BaseDropdown<T> extends StatefulWidget {
  ///Labeling widget
  final String? label;

  ///Current state of the Dropdown
  final DropdownState state;

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
  final List<T> options;

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
    this.dropdownColor = UiColors.neutral500,
    this.containerBackgroundColor = UiColors.neutral600,
    this.borderRadiusColor = UiColors.neutral500,
    this.dropdownMenuWidth = 150,
  });
  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
//On Dropdown Value changed
  void onDropdownValueSelected(value) {
    setState(() {
      if (widget.isMultiSelect) {
        if (widget.selectedValues.contains(value)) {
          widget.selectedValues.remove(value);
        } else {
          widget.selectedValues.add(value);
        }
      } else {
        widget.onSelectedValueChanged(value!);
      }
    });
  }

//To prevent duplicates in the options list
  bool NoDuplicates() {
    return widget.options.toSet().length == widget.options.length;
  }

//Return a list of Dropdown menu items
  List<DropdownMenuEntry> getMenuEntries() {
    List<DropdownMenuEntry> entries = [];
    if (widget.isMultiSelect) {
      for (var option in widget.options) {
        entries.add(DropdownMenuEntry(
            value: option,
            label: option,
            trailingIcon: widget.selectedValues.contains(option)
                ? Icon(Icons.done)
                : SizedBox()));
      }
    } else {
      for (var option in widget.options) {
        entries.add(DropdownMenuEntry(value: option, label: option));
      }
    }
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> menuEntries = getMenuEntries();

    //Duplicate check for the option list to avoid double Keys
    assert(NoDuplicates(), "No duplicates in the options list allowed");

    return Center(
        child: DropdownMenu(
      label: widget.label != null ? Text(widget.label!) : SizedBox(),
      enableSearch: widget.isSearchable,
      width: widget.dropdownMenuWidth,
      dropdownMenuEntries: menuEntries,
      onSelected: onDropdownValueSelected,
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
          backgroundColor:
              WidgetStatePropertyAll(widget.containerBackgroundColor),
          padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
          fixedSize: WidgetStatePropertyAll(
              Size(widget.dropdownMenuWidth, double.infinity))),
    ));
  }
}

/// Predefined Dropdown configurations matching common design patterns
class Dropdowns {
  static BaseDropdown select({
    label,
    onDropdownStateChanged,
    size,
    isMultiSelect = false,
    isSearchable = true,
    required selectedValue,
    required onSelectedValueChanged,
    required options,
    enableKeyboardNavigation = false,
    sortMenuItems = false,
    textStyle, //assign later
    padding,
    dropdownColor,
    containerBackgroundColor,
    dropdownMenuWidth,
  }) {
    return BaseDropdown(
      label: label,
      options: options,
      onSelectedValueChanged: onSelectedValueChanged,
      selectedValue: selectedValue,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor,
      dropdownColor: dropdownColor,
      enableKeyboardNavigation: enableKeyboardNavigation,
      dropdownMenuWidth: dropdownMenuWidth,
    );
  }

  static BaseDropdown multiSelect({
    label,
    onDropdownStateChanged,
    size,
    isMultiSelect = true,
    isSearchable = true,
    required selectedValues,
    required onSelectedValueChanged,
    required options,
    enableKeyboardNavigation = false,
    sortMenuItems = false,
    textStyle, //assign later
    padding,
    dropdownColor,
    containerBackgroundColor,
    dropdownMenuWidth,
  }) {
    return BaseDropdown(
      label: label,
      onSelectedValueChanged: onSelectedValueChanged!,
      selectedValues: selectedValues,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor,
      dropdownColor: dropdownColor,
      enableKeyboardNavigation: enableKeyboardNavigation,
      textStyle: textStyle,
      isSearchable: isSearchable,
      isMultiSelect: isMultiSelect,
      padding: padding,
      options: options,
      dropdownMenuWidth: dropdownMenuWidth,
    );
  }
}
