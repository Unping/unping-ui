import 'package:flutter/material.dart' show Material;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A base dropdown widget that provides customizable dropdown functionality.
///
/// Supports single and multiple selection, keyboard navigation, search,
/// and various visual states. Use [Dropdowns] factory methods for common
/// configurations.
class BaseDropdown<T> extends StatefulWidget {
  /// Optional label displayed above the dropdown
  final String? label;

  /// Placeholder text when no value is selected
  final String? placeholder;

  /// Helper text displayed below the dropdown
  final String? helperText;

  /// Error text displayed below the dropdown
  final String? errorText;

  /// Currently selected value (single select)
  final T? selectedValue;

  /// Currently selected values (multi select)
  final List<T>? selectedValues;

  /// List of options to display in the dropdown
  final List<DropdownOption<T>> options;

  /// Callback when a single value is selected
  final ValueChanged<T?>? onChanged;

  /// Callback when multiple values are selected
  final ValueChanged<List<T>>? onMultiChanged;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Size of the dropdown
  final DropdownSize size;

  /// Configuration for the dropdown menu
  final DropdownConfig config;

  /// Force a specific state (for showcasing)
  final DropdownState? forceState;

  /// Custom widget to display for the selected value
  final Widget Function(T? value)? selectedBuilder;

  /// Custom widget to display for multiple selected values
  final Widget Function(List<T> values)? multiSelectedBuilder;

  /// Leading icon or widget
  final Widget? prefix;

  /// Trailing icon or widget (overrides default dropdown arrow)
  final Widget? suffix;

  /// Whether this is a multi-select dropdown
  final bool multiSelect;

  /// Background color of the trigger
  final Color? backgroundColor;

  /// Background color when hovered
  final Color? hoverBackgroundColor;

  /// Background color when focused/open
  final Color? focusBackgroundColor;

  /// Background color when disabled
  final Color? disabledBackgroundColor;

  /// Border color
  final Color? borderColor;

  /// Border color when hovered
  final Color? hoverBorderColor;

  /// Border color when focused/open
  final Color? focusBorderColor;

  /// Border color when disabled
  final Color? disabledBorderColor;

  /// Border color when error
  final Color? errorBorderColor;

  /// Border width
  final double borderWidth;

  /// Border radius
  final double borderRadius;

  /// Focus ring color
  final Color? focusRingColor;

  /// Focus ring width
  final double focusRingWidth;

  /// Text style
  final TextStyle? textStyle;

  /// Placeholder text style
  final TextStyle? placeholderStyle;

  /// Label text style
  final TextStyle? labelStyle;

  /// Helper text style
  final TextStyle? helperStyle;

  /// Error text style
  final TextStyle? errorStyle;

  /// Padding inside the trigger
  final EdgeInsetsGeometry? padding;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  const BaseDropdown({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.selectedValue,
    this.selectedValues,
    required this.options,
    this.onChanged,
    this.onMultiChanged,
    this.enabled = true,
    this.size = DropdownSize.md,
    this.config = const DropdownConfig(),
    this.forceState,
    this.selectedBuilder,
    this.multiSelectedBuilder,
    this.prefix,
    this.suffix,
    this.multiSelect = false,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.focusBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.hoverBorderColor,
    this.focusBorderColor,
    this.disabledBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1.0,
    this.borderRadius = UiRadius.sm,
    this.focusRingColor,
    this.focusRingWidth = 3.0,
    this.textStyle,
    this.placeholderStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.padding,
    this.semanticsLabel,
  });

  @override
  State<BaseDropdown<T>> createState() => _BaseDropdownState<T>();
}

class _BaseDropdownState<T> extends State<BaseDropdown<T>> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isHovered = false;
  int _focusedIndex = -1;
  bool _isInteractingWithMenu = false;

  T? _selectedValueInternal;
  List<T>? _selectedValuesInternal;

  List<T> get _selectedList =>
      _selectedValuesInternal ?? (widget.selectedValues ?? []);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    // Initialize internal selection from widget
    _selectedValueInternal = widget.selectedValue;
    if (widget.selectedValues != null) {
      _selectedValuesInternal = List<T>.from(widget.selectedValues!);
    }
  }

  @override
  void dispose() {
    // Don't call _closeMenu() here as it calls setState()
    // Just remove the overlay entry if it exists and has been inserted
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
    }
    _overlayEntry = null;
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Don't close menu if we're interacting with menu elements (like search field)
    if (!_focusNode.hasFocus && _isOpen && !_isInteractingWithMenu) {
      // Add a small delay to allow focus to move to menu elements
      // coverage:ignore-start
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _isOpen && !_isInteractingWithMenu) {
          _closeMenu();
        }
      });
      // coverage:ignore-end
    }
  }

  DropdownState get _currentState {
    if (widget.forceState != null) {
      if (!widget.enabled) return DropdownState.disabled;
      return widget.forceState!;
    }

    if (!widget.enabled) return DropdownState.disabled;
    if (widget.errorText?.isNotEmpty ?? false) return DropdownState.error;
    if (_isOpen) return DropdownState.open;
    if (_focusNode.hasFocus) return DropdownState.focused;
    return DropdownState.normal;
  }

  Color _getBackgroundColor() {
    final state = _currentState;
    switch (state) {
      case DropdownState.disabled:
        return widget.disabledBackgroundColor ?? UiColors.neutral600;
      case DropdownState.open:
      case DropdownState.focused:
        return widget.focusBackgroundColor ?? UiColors.neutral600;
      case DropdownState.error:
        return widget.backgroundColor ?? UiColors.neutral600;
      case DropdownState.normal:
        return _isHovered
            ? (widget.hoverBackgroundColor ?? UiColors.neutral600)
            : (widget.backgroundColor ?? UiColors.neutral600);
    }
  }

  Color _getBorderColor() {
    final state = _currentState;
    switch (state) {
      case DropdownState.disabled:
        return widget.disabledBorderColor ??
            const Color(0x00000000); // Transparent
      case DropdownState.error:
        return widget.errorBorderColor ?? UiColors.error;
      case DropdownState.open:
      case DropdownState.focused:
        return widget.focusBorderColor ?? UiColors.neutral500;
      case DropdownState.normal:
        return _isHovered
            ? (widget.hoverBorderColor ?? UiColors.neutral500)
            : (widget.borderColor ?? UiColors.neutral500);
    }
  }

  List<BoxShadow>? _getBoxShadow() {
    final state = _currentState;
    if (state == DropdownState.focused || state == DropdownState.open) {
      if (widget.focusRingColor != null) {
        return [
          BoxShadow(
            color: widget.focusRingColor!,
            offset: Offset.zero,
            blurRadius: 0,
            spreadRadius: widget.focusRingWidth,
          ),
        ];
      }
    }
    return null;
  }

  void _toggleMenu() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeMenu(); // coverage:ignore-line
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    if (_isOpen || !widget.enabled) return;

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      // In test environments without an Overlay ancestor, just focus without opening.
      _focusNode.requestFocus();
      return;
    }

    _focusedIndex = -1;
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);

    setState(() => _isOpen = true);
    _focusNode.requestFocus();
  }

  void _closeMenu() {
    if (!_isOpen) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
      _focusedIndex = -1;
    });
  }

  void _handleSelection(T value) {
    if (widget.multiSelect) {
      final newList = List<T>.from(_selectedList);
      if (newList.contains(value)) {
        newList.remove(value);
      } else {
        newList.add(value);
      }
      // Update internal state
      _selectedValuesInternal = newList;
      setState(() {});
      // Rebuild the overlay to show updated checkmarks
      _overlayEntry?.markNeedsBuild();
      // Notify callback
      widget.onMultiChanged?.call(newList);

      // Don't close menu for multi-select unless configured
      if (widget.config.closeOnSelect) {
        _closeMenu();
      }
    } else {
      // Update internal selection and notify
      _selectedValueInternal = value;
      setState(() {});
      widget.onChanged?.call(value);

      if (widget.config.closeOnSelect) {
        _closeMenu();
      }
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _closeMenu();
      return;
    }

    if (!_isOpen) {
      // coverage:ignore-start
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space ||
          event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _openMenu();
      }
      // coverage:ignore-end
      return;
    }

    // Menu is open - handle navigation
    final maxIndex = widget.options.length - 1;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _focusedIndex = (_focusedIndex + 1).clamp(0, maxIndex);
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _focusedIndex = (_focusedIndex - 1).clamp(0, maxIndex);
      });
    } else if (event.logicalKey == LogicalKeyboardKey.home) {
      setState(() => _focusedIndex = 0);
    } else if (event.logicalKey == LogicalKeyboardKey.end) {
      setState(() => _focusedIndex = maxIndex);
    } else if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.space) {
      if (_focusedIndex >= 0 && _focusedIndex <= maxIndex) {
        final option = widget.options[_focusedIndex];
        if (option.enabled) {
          _handleSelection(option.value);
        }
      }
    }
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // Calculate menu position
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Constants for padding
    const double screenPadding = 8.0;
    const double minMenuHeight = 100.0;

    final spaceBelow = screenHeight - offset.dy - size.height - screenPadding;
    final spaceAbove = offset.dy - screenPadding;

    // Determine menu dimensions
    final menuWidth = widget.config.menuWidth ??
        size.width.clamp(200.0, screenWidth - (screenPadding * 2));

    // Calculate available height and position
    double menuTop;
    double actualMaxHeight;

    // Decide whether to show below or above based on available space
    final bool showBelow;

    if (widget.config.menuPosition == DropdownMenuPosition.above) {
      showBelow = false;
    } else if (widget.config.menuPosition == DropdownMenuPosition.below) {
      showBelow = true;
    } else {
      // Auto: choose based on available space
      showBelow =
          spaceBelow >= widget.config.menuMaxHeight || spaceBelow > spaceAbove;
    }

    if (showBelow && spaceBelow >= minMenuHeight) {
      // Position below trigger
      menuTop = offset.dy + size.height + widget.config.menuOffset;
      actualMaxHeight =
          spaceBelow.clamp(minMenuHeight, widget.config.menuMaxHeight);
    } else if (!showBelow && spaceAbove >= minMenuHeight) {
      // Position above trigger
      actualMaxHeight =
          spaceAbove.clamp(minMenuHeight, widget.config.menuMaxHeight);
      menuTop = offset.dy - actualMaxHeight - widget.config.menuOffset;
    } else {
      // Not enough space above or below - use the larger space
      // coverage:ignore-start
      if (spaceBelow > spaceAbove) {
        menuTop = offset.dy + size.height + widget.config.menuOffset;
        actualMaxHeight =
            spaceBelow.clamp(minMenuHeight, widget.config.menuMaxHeight);
        // coverage:ignore-end
      } else {
        actualMaxHeight =
            spaceAbove.clamp(minMenuHeight, widget.config.menuMaxHeight);
        menuTop = offset.dy - actualMaxHeight - widget.config.menuOffset;
      }
    }

    // Ensure positioning stays within screen bounds
    final menuLeft = offset.dx.clamp(
      screenPadding,
      (screenWidth - menuWidth - screenPadding)
          .clamp(screenPadding, double.infinity),
    );

    final finalTop = menuTop.clamp(
      screenPadding,
      (screenHeight - actualMaxHeight - screenPadding)
          .clamp(screenPadding, double.infinity),
    );

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _isInteractingWithMenu = false;
          _closeMenu();
        },
        child: Stack(
          children: [
            // Full-screen backdrop to catch taps
            Positioned.fill(
              child: Container(
                color: const Color(0x00000000), // Transparent
              ),
            ),
            Positioned(
              left: menuLeft,
              top: finalTop,
              width: menuWidth,
              child: GestureDetector(
                // Prevent taps inside menu from bubbling up to backdrop
                onTap: () {}, // coverage:ignore-line
                child: MouseRegion(
                  onEnter: (_) => _isInteractingWithMenu = true,
                  onExit: (_) => _isInteractingWithMenu = false,
                  child: Material(
                    elevation: 4,
                    color: UiColors.neutral700,
                    borderRadius: BorderRadius.circular(UiRadius.sm),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: actualMaxHeight,
                        minWidth: menuWidth,
                      ),
                      child: DropdownMenu(
                        options: widget.options,
                        selectedValues: widget.multiSelect
                            ? _selectedList
                            : (widget.selectedValue != null
                                ? [widget.selectedValue]
                                : []),
                        onSelected: (value) => _handleSelection(value as T),
                        showCheckmarks: widget.config.showCheckmarks,
                        width: menuWidth,
                        maxHeight: actualMaxHeight,
                        searchable: widget.config.searchable,
                        searchPlaceholder: widget.config.searchPlaceholder,
                        searchFilter: widget.config.searchFilter,
                        focusedIndex: _focusedIndex,
                        isLoading: widget.config.isLoading,
                        loadingWidget: widget.config.loadingWidget,
                        loadingMessage: widget.config.loadingMessage,
                        virtualScrolling: widget.config.virtualScrolling,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerContent() {
    final sizeTokens = DropdownSizeTokens.forSize(widget.size);
    final textStyle =
        (widget.textStyle ?? UiTextStyles.textMd).merge(sizeTokens.textStyle);
    final isDisabled = !widget.enabled;

    // Build selected value display
    Widget? valueWidget;

    if (widget.multiSelect && _selectedList.isNotEmpty) {
      if (widget.multiSelectedBuilder != null) {
        valueWidget = widget.multiSelectedBuilder!(_selectedList);
      } else {
        valueWidget = Text(
          '${_selectedList.length} selected',
          style: textStyle.copyWith(
            color: isDisabled ? UiColors.neutral400 : UiColors.onPrimary,
          ),
        );
      }
    } else if (!widget.multiSelect &&
        (_selectedValueInternal != null || widget.selectedValue != null)) {
      final effectiveValue = _selectedValueInternal ?? widget.selectedValue;
      if (widget.selectedBuilder != null) {
        valueWidget = widget.selectedBuilder!(effectiveValue);
      } else {
        // Find the option to display its label
        final selectedOption =
            widget.options.cast<DropdownOption<T>?>().firstWhere(
                  (opt) => opt?.value == effectiveValue,
                  orElse: () => null,
                );
        valueWidget = Text(
          selectedOption?.label ?? effectiveValue.toString(),
          style: textStyle.copyWith(
            color: isDisabled ? UiColors.neutral400 : UiColors.onPrimary,
          ),
        );
      }
    }

    // Show placeholder if no selection
    if (valueWidget == null && widget.placeholder != null) {
      valueWidget = Text(
        widget.placeholder!,
        style: (widget.placeholderStyle ?? textStyle).copyWith(
          color: isDisabled
              ? UiColors.neutral400.withValues(alpha: 0.5)
              : UiColors.neutral400,
        ),
      );
    }

    return Row(
      children: [
        if (widget.prefix != null) ...[
          widget.prefix!,
          const SizedBox(width: 8.0),
        ],
        Expanded(
          child: valueWidget ?? const SizedBox.shrink(),
        ),
        if (widget.suffix != null) ...[
          const SizedBox(width: 8.0),
          widget.suffix!,
        ] else ...[
          const SizedBox(width: 8.0),
          Transform.rotate(
            angle: _isOpen ? 3.14159 : 0, // 180 degrees when open
            child: CustomPaint(
              size: Size(sizeTokens.iconSize, sizeTokens.iconSize),
              painter: _DropdownArrowPainter(
                color: isDisabled ? UiColors.neutral400 : UiColors.onPrimary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeTokens = DropdownSizeTokens.forSize(widget.size);
    final resolvedPadding = widget.padding ?? sizeTokens.padding;
    final helperStyle = widget.helperStyle ??
        UiTextStyles.textXs.copyWith(
          color: _currentState == DropdownState.error
              ? UiColors.error
              : UiColors.neutral400,
        );

    final trigger = CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: (node, event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        child: MouseRegion(
          // coverage:ignore-start
          onEnter:
              widget.enabled ? (_) => setState(() => _isHovered = true) : null,
          onExit:
              widget.enabled ? (_) => setState(() => _isHovered = false) : null,
          // coverage:ignore-end
          child: GestureDetector(
            onTap: _toggleMenu,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeInOut,
              constraints: BoxConstraints(minHeight: sizeTokens.minHeight),
              padding: resolvedPadding,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: _getBorderColor(),
                  width: widget.borderWidth,
                ),
                boxShadow: _getBoxShadow(),
              ),
              child: _buildTriggerContent(),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      label: widget.semanticsLabel ?? widget.label,
      button: true,
      enabled: widget.enabled,
      hint: widget.placeholder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: widget.labelStyle ??
                  UiTextStyles.textSm.copyWith(
                    color: UiColors.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 6.0),
          ],

          // Trigger
          trigger,

          // Helper/Error text
          if (widget.errorText != null || widget.helperText != null) ...[
            const SizedBox(height: 6.0),
            Text(
              widget.errorText ?? widget.helperText!,
              style: helperStyle,
            ),
          ],
        ],
      ),
    );
  }
}

/// Custom painter for dropdown arrow icon
class _DropdownArrowPainter extends CustomPainter {
  final Color color;

  _DropdownArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw down-pointing chevron
    final path = Path()
      ..moveTo(size.width * 0.25, size.height * 0.35)
      ..lineTo(size.width * 0.5, size.height * 0.65)
      ..lineTo(size.width * 0.75, size.height * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
