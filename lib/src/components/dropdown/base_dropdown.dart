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
  ///Current state of the Dropdown
  final DropdownState state;

  /// Callback when the Dropdown state changes
  final ValueChanged<DropdownState>? onChanged;

  ///Current size of the Dropdown
  final DropdownSize size;

  //for Single or multiple selection
  final bool isMultiSelect;

  //For searching enabled or disabled
  final bool isSearchable;

  //Selected DropdownMenuItem
  final String? selectedValue;
  final ValueChanged<String> onSelectedValueChanged;

  //Selected DropdownMenuItems
  final List<DropdownMenuItem>? selectedvalues;

  //List Options
  final List<DropdownMenuEntry> options;

  //Enable Keyboard navigations
  final bool enableKeyboardNavigation;

  //Sort the dropdown menu Item
  final bool sortMenuItems;

  ///Auto select first Item on Dropdown list
  final bool autoSelectFirst;

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
    this.state = DropdownState.normal,
    this.onChanged,
    this.size = DropdownSize.md,
    this.isMultiSelect = false,
    this.isSearchable = false,
    required this.selectedValue,
    required this.onSelectedValueChanged,
    this.selectedvalues,
    this.options = const [],
    this.enableKeyboardNavigation = false,
    this.sortMenuItems = false,
    this.autoSelectFirst = true,
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
    if (widget.isMultiSelect) {
      widget.selectedvalues?.add(value);
    } else {
      widget.onSelectedValueChanged(value!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownMenu(
      enableSearch: true,
      width: widget.dropdownMenuWidth,
      dropdownMenuEntries: widget.options,
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
// class Dropdowns{
// static BaseDropdown select({
//   DropdownState state,

// })
// {
// return BaseDropdown();
// }
// }
