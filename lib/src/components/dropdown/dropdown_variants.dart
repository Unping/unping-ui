import 'package:unping_ui/src/components/dropdown/dropdown_types.dart';
import 'package:unping_ui/unping_ui.dart';

/// Predefined Dropdown configurations matching common design patterns
class Dropdowns {
  static BaseDropdown select(
      {label,
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
      borderRadiusColor}) {
    return BaseDropdown(
      label: label,
      dropdownType: DropdownType.single,
      options: options,
      onSelectedValueChanged: onSelectedValueChanged,
      selectedValue: selectedValue,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor ?? UiColors.neutral700,
      dropdownColor: dropdownColor ?? UiColors.neutral700,
      enableKeyboardNavigation: enableKeyboardNavigation,
      dropdownMenuWidth: dropdownMenuWidth,
      borderRadiusColor: borderRadiusColor ?? UiColors.neutral300,
    );
  }

  static BaseDropdown multiSelect(
      {label,
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
      borderRadiusColor}) {
    return BaseDropdown(
      label: label,
      dropdownType: DropdownType.multi,
      onSelectedValueChanged: onSelectedValueChanged!,
      selectedValues: selectedValues,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor ?? UiColors.neutral700,
      dropdownColor: dropdownColor ?? UiColors.neutral700,
      enableKeyboardNavigation: enableKeyboardNavigation,
      textStyle: textStyle,
      isSearchable: isSearchable,
      isMultiSelect: isMultiSelect,
      padding: padding,
      options: options,
      dropdownMenuWidth: dropdownMenuWidth,
      borderRadiusColor: borderRadiusColor ?? UiColors.neutral300,
    );
  }
}
