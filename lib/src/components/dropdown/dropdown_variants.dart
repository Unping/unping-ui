import 'package:unping_ui/unping_ui.dart';

/// Predefined Dropdown configurations matching common design patterns
class Dropdowns {
  static BaseDropdown select(
      {label,
      onDropdownStateChanged,
      size,
      state,
      errorColor,
      errorMessage,
      isMultiSelect = false,
      isSearchable = true,
      required selectedValue,
      required onSelectedValueChanged,
      required options,
      enableKeyboardNavigation = false,
      sortMenuItems = false,
      textStyle,
      padding,
      dropdownColor,
      containerBackgroundColor,
      borderRadiusColor}) {
    return BaseDropdown(
      label: label,
      state: state ?? DropdownState.normal,
      dropdownType: DropdownType.single,
      errorColor: errorColor ?? UiColors.error,
      errorMessage: errorMessage ?? 'Error',
      options: options,
      onSelectedValueChanged: onSelectedValueChanged,
      selectedValue: selectedValue,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor ?? UiColors.neutral700,
      dropdownColor: dropdownColor ?? UiColors.neutral700,
      enableKeyboardNavigation: enableKeyboardNavigation,
      size: size,
      borderRadiusColor: borderRadiusColor ?? UiColors.neutral300,
    );
  }

  static BaseDropdown multiSelect(
      {label,
      onDropdownStateChanged,
      size,
      state,
      errorColor,
      errorMessage,
      isMultiSelect = true,
      isSearchable = true,
      required selectedValues,
      required onSelectedValueChanged,
      required options,
      enableKeyboardNavigation = false,
      sortMenuItems = false,
      textStyle,
      padding,
      dropdownColor,
      containerBackgroundColor,
      borderRadiusColor}) {
    return BaseDropdown(
      label: label,
      state: state ?? DropdownState.normal,
      dropdownType: DropdownType.multi,
      errorColor: errorColor ?? UiColors.error,
      errorMessage: errorMessage ?? 'Error',
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
      size: size,
      borderRadiusColor: borderRadiusColor ?? UiColors.neutral300,
    );
  }

  static BaseDropdown combobox(
      {label,
      onDropdownStateChanged,
      size,
      state,
      isMultiSelect = true,
      isSearchable = true,
      required onSelectedValueChanged,
      required options,
      enableKeyboardNavigation = false,
      sortMenuItems = false,
      textStyle, //assign later
      padding,
      dropdownColor,
      containerBackgroundColor,
      borderRadiusColor}) {
    return BaseDropdown(
      label: label,
      dropdownType: DropdownType.comboBox,
      state: state ?? DropdownState.normal,
      onSelectedValueChanged: onSelectedValueChanged!,
      onDropdownStateChanged: onDropdownStateChanged,
      containerBackgroundColor: containerBackgroundColor ?? UiColors.neutral700,
      dropdownColor: dropdownColor ?? UiColors.neutral700,
      enableKeyboardNavigation: enableKeyboardNavigation,
      textStyle: textStyle,
      isSearchable: isSearchable,
      isMultiSelect: isMultiSelect,
      padding: padding,
      options: options,
      size: size,
      borderRadiusColor: borderRadiusColor ?? UiColors.neutral300,
    );
  }
}
