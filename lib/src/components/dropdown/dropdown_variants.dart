import 'package:flutter/material.dart' show Material;
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import 'dropdown_types.dart';
import 'base_dropdown.dart';
import 'dropdown_menu.dart';

/// Predefined dropdown configurations matching common design patterns
class Dropdowns {
  /// Creates a single-selection dropdown
  ///
  /// Example:
  /// ```dart
  /// Dropdowns.select<String>(
  ///   label: 'Country',
  ///   options: ['USA', 'Canada', 'Mexico'],
  ///   selectedValue: selectedCountry,
  ///   onChanged: (value) => setState(() => selectedCountry = value),
  ///   placeholder: 'Choose a country',
  /// )
  /// ```
  static BaseDropdown<T> select<T>({
    Key? key,
    String? label,
    String? placeholder,
    String? helperText,
    String? errorText,
    required List<T> options,
    T? selectedValue,
    ValueChanged<T?>? onChanged,
    bool enabled = true,
    DropdownSize size = DropdownSize.md,
    bool searchable = false,
    String? searchPlaceholder,
    double? menuWidth,
    double menuMaxHeight = 320.0,
    Widget Function(T option)? optionBuilder,
    Widget Function(T? value)? selectedBuilder,
    Widget? prefix,
    Widget? suffix,
    DropdownState? forceState,
    String? semanticsLabel,
  }) {
    // Convert simple list to DropdownOption list
    final dropdownOptions = options.map((option) {
      return DropdownOption<T>(
        value: option,
        label: optionBuilder != null
            ? '' // Will be handled by builder
            : option.toString(),
        builder: optionBuilder != null
            ? (context, selected, focused) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  child: optionBuilder(option),
                );
              }
            : null,
      );
    }).toList();

    return BaseDropdown<T>(
      key: key,
      label: label,
      placeholder: placeholder ?? 'Select an option',
      helperText: helperText,
      errorText: errorText,
      options: dropdownOptions,
      selectedValue: selectedValue,
      onChanged: onChanged,
      enabled: enabled,
      size: size,
      selectedBuilder: selectedBuilder,
      prefix: prefix,
      suffix: suffix,
      forceState: forceState,
      semanticsLabel: semanticsLabel,
      config: DropdownConfig(
        searchable: searchable,
        searchPlaceholder: searchPlaceholder ?? 'Search...',
        menuWidth: menuWidth,
        menuMaxHeight: menuMaxHeight,
        closeOnSelect: true,
        showCheckmarks: true,
      ),
    );
  }

  /// Creates a multi-selection dropdown with checkboxes
  ///
  /// Example:
  /// ```dart
  /// Dropdowns.multiSelect<String>(
  ///   label: 'Skills',
  ///   options: ['Flutter', 'Dart', 'React', 'Node.js'],
  ///   selectedValues: selectedSkills,
  ///   onChanged: (values) => setState(() => selectedSkills = values),
  /// )
  /// ```
  static BaseDropdown<T> multiSelect<T>({
    Key? key,
    String? label,
    String? placeholder,
    String? helperText,
    String? errorText,
    required List<T> options,
    List<T> selectedValues = const [],
    ValueChanged<List<T>>? onChanged,
    bool enabled = true,
    DropdownSize size = DropdownSize.md,
    bool searchable = false,
    String? searchPlaceholder,
    double? menuWidth,
    double menuMaxHeight = 320.0,
    Widget Function(T option)? optionBuilder,
    Widget Function(List<T> values)? selectedBuilder,
    Widget? prefix,
    Widget? suffix,
    bool showSelectAll = false,
    bool showClearAll = false,
    DropdownState? forceState,
    String? semanticsLabel,
  }) {
    // Convert simple list to DropdownOption list
    final dropdownOptions = options.map((option) {
      return DropdownOption<T>(
        value: option,
        label: optionBuilder != null ? '' : option.toString(),
        builder: optionBuilder != null
            ? (context, selected, focused) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  child: optionBuilder(option),
                );
              }
            : null,
      );
    }).toList();

    return BaseDropdown<T>(
      key: key,
      label: label,
      placeholder: placeholder ?? 'Select options',
      helperText: helperText,
      errorText: errorText,
      options: dropdownOptions,
      selectedValues: selectedValues,
      onMultiChanged: onChanged,
      multiSelect: true,
      enabled: enabled,
      size: size,
      multiSelectedBuilder: selectedBuilder,
      prefix: prefix,
      suffix: suffix,
      forceState: forceState,
      semanticsLabel: semanticsLabel,
      config: DropdownConfig(
        searchable: searchable,
        searchPlaceholder: searchPlaceholder ?? 'Search...',
        menuWidth: menuWidth,
        menuMaxHeight: menuMaxHeight,
        closeOnSelect: false, // Keep open for multi-select
        showCheckmarks: true,
      ),
    );
  }

  /// Creates a searchable combobox dropdown
  ///
  /// Example:
  /// ```dart
  /// Dropdowns.combobox<User>(
  ///   label: 'Assign to',
  ///   options: users,
  ///   optionBuilder: (user) => Text(user.name),
  ///   searchable: true,
  ///   onChanged: (user) => assignTask(user),
  /// )
  /// ```
  static BaseDropdown<T> combobox<T>({
    Key? key,
    String? label,
    String? placeholder,
    String? helperText,
    String? errorText,
    required List<T> options,
    T? selectedValue,
    ValueChanged<T?>? onChanged,
    required Widget Function(T option) optionBuilder,
    Widget Function(T? value)? selectedBuilder,
    bool enabled = true,
    DropdownSize size = DropdownSize.md,
    String? searchPlaceholder,
    bool Function(T option, String query)? searchFilter,
    double? menuWidth,
    double menuMaxHeight = 320.0,
    Widget? prefix,
    Widget? suffix,
    DropdownState? forceState,
    String? semanticsLabel,
  }) {
    // Convert to DropdownOption with custom search filter
    final dropdownOptions = options.map((option) {
      return DropdownOption<T>(
        value: option,
        label: option.toString(),
        builder: (context, selected, focused) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            child: optionBuilder(option),
          );
        },
      );
    }).toList();

    return BaseDropdown<T>(
      key: key,
      label: label,
      placeholder: placeholder ?? 'Search and select',
      helperText: helperText,
      errorText: errorText,
      options: dropdownOptions,
      selectedValue: selectedValue,
      onChanged: onChanged,
      enabled: enabled,
      size: size,
      selectedBuilder: selectedBuilder,
      prefix: prefix,
      suffix: suffix,
      forceState: forceState,
      semanticsLabel: semanticsLabel,
      config: DropdownConfig(
        searchable: true,
        searchPlaceholder: searchPlaceholder ?? 'Type to search...',
        menuWidth: menuWidth,
        menuMaxHeight: menuMaxHeight,
        closeOnSelect: true,
        showCheckmarks: true,
        searchFilter: searchFilter != null
            ? (option, query) => searchFilter(option.value, query)
            : null,
      ),
    );
  }

  /// Creates an action menu dropdown
  ///
  /// Example:
  /// ```dart
  /// Dropdowns.menu(
  ///   trigger: IconButton(icon: Icon(Icons.more_vert)),
  ///   items: [
  ///     DropdownMenuAction(
  ///       icon: Icon(Icons.edit),
  ///       label: 'Edit',
  ///       onTap: () => editItem(),
  ///     ),
  ///     DropdownMenuAction(
  ///       icon: Icon(Icons.delete),
  ///       label: 'Delete',
  ///       onTap: () => deleteItem(),
  ///       destructive: true,
  ///     ),
  ///   ],
  /// )
  /// ```
  static Widget menu({
    Key? key,
    required Widget trigger,
    required List<DropdownMenuAction> items,
    bool enabled = true,
    DropdownSize size = DropdownSize.md,
    double? menuWidth,
    double menuMaxHeight = 320.0,
    DropdownMenuPosition menuPosition = DropdownMenuPosition.auto,
    String? semanticsLabel,
  }) {
    return _ActionMenuDropdown(
      key: key,
      trigger: trigger,
      items: items,
      enabled: enabled,
      size: size,
      menuWidth: menuWidth,
      menuMaxHeight: menuMaxHeight,
      menuPosition: menuPosition,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// Internal widget for action menu dropdown
class _ActionMenuDropdown extends StatefulWidget {
  final Widget trigger;
  final List<DropdownMenuAction> items;
  final bool enabled;
  final DropdownSize size;
  final double? menuWidth;
  final double menuMaxHeight;
  final DropdownMenuPosition menuPosition;
  final String? semanticsLabel;

  const _ActionMenuDropdown({
    super.key,
    required this.trigger,
    required this.items,
    required this.enabled,
    required this.size,
    required this.menuWidth,
    required this.menuMaxHeight,
    required this.menuPosition,
    required this.semanticsLabel,
  });

  @override
  State<_ActionMenuDropdown> createState() => _ActionMenuDropdownState();
}

class _ActionMenuDropdownState extends State<_ActionMenuDropdown> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    // Don't call _closeMenu() here as it calls setState()
    // Just remove the overlay entry
    _overlayEntry?.remove();
    _overlayEntry = null;
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    if (_isOpen || !widget.enabled) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);

    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    if (!_isOpen) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _handleAction(DropdownMenuAction action) {
    action.onTap?.call();
    _closeMenu();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;
    final spaceBelow = screenHeight - offset.dy - size.height;
    final spaceAbove = offset.dy;

    bool showBelow = true;
    if (widget.menuPosition == DropdownMenuPosition.above) {
      showBelow = false;
    } else if (widget.menuPosition == DropdownMenuPosition.auto) {
      showBelow = spaceBelow >= widget.menuMaxHeight || spaceBelow > spaceAbove;
    }

    final menuWidth = widget.menuWidth ?? 200.0;

    // Convert actions to DropdownOption
    final options = widget.items.map((action) {
      return DropdownOption<DropdownMenuAction>(
        value: action,
        label: action.label,
        icon: action.icon,
        enabled: action.enabled,
        showDivider: action.showDivider,
        trailing: action.shortcut != null
            ? Text(
                action.shortcut!,
                style: UiTextStyles.textXs.copyWith(
                  color: UiColors.neutral400,
                ),
              )
            : null,
      );
    }).toList();

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeMenu,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: showBelow ? offset.dy + size.height + 4.0 : null,
              bottom: showBelow ? null : screenHeight - offset.dy + 4.0,
              width: menuWidth,
              child: Material(
                color: const Color(0x00000000), // Transparent
                child: DropdownMenu(
                  options: options,
                  selectedValues: const [],
                  onSelected: (value) {
                    if (value is DropdownMenuAction) {
                      _handleAction(value);
                    }
                  },
                  showCheckmarks: false,
                  width: menuWidth,
                  maxHeight: widget.menuMaxHeight,
                  searchable: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel ?? 'Menu',
      button: true,
      enabled: widget.enabled,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: _toggleMenu,
          child: widget.trigger,
        ),
      ),
    );
  }
}
