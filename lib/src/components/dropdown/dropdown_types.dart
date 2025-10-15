import 'package:flutter/widgets.dart';

/// Size variants for dropdown components
enum DropdownSize {
  /// Small: 36px height
  sm,

  /// Medium: 44px height (default)
  md,

  /// Large: 52px height
  lg,
}

/// Visual states for dropdown components
enum DropdownState {
  /// Normal state - default appearance
  normal,

  /// Focused state - when dropdown has keyboard focus
  focused,

  /// Open state - when dropdown menu is visible
  open,

  /// Disabled state - when dropdown is not interactive
  disabled,

  /// Error state - when dropdown has validation errors
  error,
}

/// Type of dropdown menu
enum DropdownType {
  /// Single selection dropdown
  select,

  /// Multiple selection dropdown
  multiSelect,

  /// Searchable combobox
  combobox,

  /// Action menu
  menu,
}

/// Position of the dropdown menu relative to the trigger
enum DropdownMenuPosition {
  /// Menu appears below the trigger
  below,

  /// Menu appears above the trigger
  above,

  /// Automatically determine position based on available space
  auto,
}

/// A selectable option in a dropdown menu
class DropdownOption<T> {
  /// The value associated with this option
  final T value;

  /// The display label for this option
  final String label;

  /// Optional supporting text below the label
  final String? supportingText;

  /// Optional icon to display before the label
  final Widget? icon;

  /// Optional trailing widget (overrides checkmark for selected items)
  final Widget? trailing;

  /// Whether this option is enabled
  final bool enabled;

  /// Optional divider below this item
  final bool showDivider;

  /// Optional group label for this item
  final String? group;

  /// Custom builder for this option (overrides default rendering)
  final Widget Function(BuildContext context, bool selected, bool focused)?
      builder;

  const DropdownOption({
    required this.value,
    required this.label,
    this.supportingText,
    this.icon,
    this.trailing,
    this.enabled = true,
    this.showDivider = false,
    this.group,
    this.builder,
  });

  /// Create a copy of this option with some fields replaced
  DropdownOption<T> copyWith({
    T? value,
    String? label,
    String? supportingText,
    Widget? icon,
    Widget? trailing,
    bool? enabled,
    bool? showDivider,
    String? group,
    Widget Function(BuildContext context, bool selected, bool focused)? builder,
  }) {
    return DropdownOption<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      supportingText: supportingText ?? this.supportingText,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
      enabled: enabled ?? this.enabled,
      showDivider: showDivider ?? this.showDivider,
      group: group ?? this.group,
      builder: builder ?? this.builder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DropdownOption<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Configuration for dropdown menu appearance and behavior
class DropdownConfig {
  /// Width of the menu (null = match trigger width)
  final double? menuWidth;

  /// Maximum height of the menu before scrolling
  final double menuMaxHeight;

  /// Minimum width of the menu
  final double? menuMinWidth;

  /// Position of the menu relative to the trigger
  final DropdownMenuPosition menuPosition;

  /// Whether to close the menu when an option is selected
  final bool closeOnSelect;

  /// Whether to show a search field in the menu
  final bool searchable;

  /// Placeholder text for search field
  final String? searchPlaceholder;

  /// Whether to show checkmarks on selected items
  final bool showCheckmarks;

  /// Whether to enable virtual scrolling for performance
  final bool virtualScrolling;

  /// Custom filter function for search
  final bool Function(DropdownOption option, String query)? searchFilter;

  /// Gap between menu and trigger
  final double menuOffset;

  /// Whether the dropdown is in a loading state
  final bool isLoading;

  /// Custom loading widget
  final Widget? loadingWidget;

  /// Loading message text
  final String loadingMessage;

  const DropdownConfig({
    this.menuWidth,
    this.menuMaxHeight = 320.0,
    this.menuMinWidth = 320.0,
    this.menuPosition = DropdownMenuPosition.auto,
    this.closeOnSelect = true,
    this.searchable = false,
    this.searchPlaceholder,
    this.showCheckmarks = true,
    this.virtualScrolling = false,
    this.searchFilter,
    this.menuOffset = 4.0,
    this.isLoading = false,
    this.loadingWidget,
    this.loadingMessage = 'Loading...',
  });

  /// Create a copy with some fields replaced
  DropdownConfig copyWith({
    double? menuWidth,
    double? menuMaxHeight,
    double? menuMinWidth,
    DropdownMenuPosition? menuPosition,
    bool? closeOnSelect,
    bool? searchable,
    String? searchPlaceholder,
    bool? showCheckmarks,
    bool? virtualScrolling,
    bool Function(DropdownOption option, String query)? searchFilter,
    double? menuOffset,
    bool? isLoading,
    Widget? loadingWidget,
    String? loadingMessage,
  }) {
    return DropdownConfig(
      menuWidth: menuWidth ?? this.menuWidth,
      menuMaxHeight: menuMaxHeight ?? this.menuMaxHeight,
      menuMinWidth: menuMinWidth ?? this.menuMinWidth,
      menuPosition: menuPosition ?? this.menuPosition,
      closeOnSelect: closeOnSelect ?? this.closeOnSelect,
      searchable: searchable ?? this.searchable,
      searchPlaceholder: searchPlaceholder ?? this.searchPlaceholder,
      showCheckmarks: showCheckmarks ?? this.showCheckmarks,
      virtualScrolling: virtualScrolling ?? this.virtualScrolling,
      searchFilter: searchFilter ?? this.searchFilter,
      menuOffset: menuOffset ?? this.menuOffset,
      isLoading: isLoading ?? this.isLoading,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingMessage: loadingMessage ?? this.loadingMessage,
    );
  }
}

/// Size tokens for different dropdown sizes
class DropdownSizeTokens {
  /// Minimum height of the dropdown trigger
  final double minHeight;

  /// Text style for the dropdown
  final TextStyle textStyle;

  /// Padding inside the dropdown trigger
  final EdgeInsetsGeometry padding;

  /// Icon size
  final double iconSize;

  const DropdownSizeTokens({
    required this.minHeight,
    required this.textStyle,
    required this.padding,
    required this.iconSize,
  });

  /// Get size tokens for a specific dropdown size
  static DropdownSizeTokens forSize(DropdownSize size) {
    switch (size) {
      case DropdownSize.sm:
        return const DropdownSizeTokens(
          minHeight: 36.0,
          textStyle: TextStyle(fontSize: 14.0, height: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          iconSize: 16.0,
        );
      case DropdownSize.md:
        return const DropdownSizeTokens(
          minHeight: 44.0,
          textStyle: TextStyle(fontSize: 16.0, height: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          iconSize: 20.0,
        );
      case DropdownSize.lg:
        return const DropdownSizeTokens(
          minHeight: 52.0,
          textStyle: TextStyle(fontSize: 18.0, height: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          iconSize: 24.0,
        );
    }
  }
}

/// Action item for menu-style dropdowns
class DropdownMenuAction {
  /// Label for the action
  final String label;

  /// Optional icon before the label
  final Widget? icon;

  /// Callback when action is selected
  final VoidCallback? onTap;

  /// Whether this is a destructive action (shown in red)
  final bool destructive;

  /// Whether this action is enabled
  final bool enabled;

  /// Show a divider after this action
  final bool showDivider;

  /// Optional keyboard shortcut hint
  final String? shortcut;

  const DropdownMenuAction({
    required this.label,
    this.icon,
    this.onTap,
    this.destructive = false,
    this.enabled = true,
    this.showDivider = false,
    this.shortcut,
  });
}
