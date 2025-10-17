//Enums, option classes, and helpers
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
