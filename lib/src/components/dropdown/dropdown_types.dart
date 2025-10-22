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

///This is a constant used to set the Height of the ListTile
///Used for scrolling and container sizing
///This is only for SINGLE LINE list tiles!!!!
double singleLineListTileHeight = 60;

///Search or return null when not found
String? searchList(List<String> searchlist, String itemSearched) {
  ///For ignoring the case
  itemSearched = itemSearched.toLowerCase();
  for (String item in searchlist) {
    if (item.toLowerCase().contains(itemSearched)) {
      return item;
    }
  }
  return null;
}
