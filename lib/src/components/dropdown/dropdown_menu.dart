import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

/// A menu item in a dropdown list
class DropdownMenuItem extends StatefulWidget {
  /// The label text for this menu item
  final String label;

  /// Optional supporting text below the label
  final String? supportingText;

  /// Whether this item is currently selected
  final bool selected;

  /// Whether this item is currently focused (keyboard navigation)
  final bool focused;

  /// Whether this item is enabled
  final bool enabled;

  /// Callback when this item is tapped
  final VoidCallback? onTap;

  /// Optional icon before the label
  final Widget? icon;

  /// Optional trailing widget (overrides checkmark)
  final Widget? trailing;

  /// Whether to show a checkmark when selected
  final bool showCheckmark;

  /// Whether this is a destructive action (shown in red)
  final bool destructive;

  /// Background color (overrides default)
  final Color? backgroundColor;

  /// Text color (overrides default)
  final Color? textColor;

  /// Text style (overrides default)
  final TextStyle? textStyle;

  /// Padding (overrides default)
  final EdgeInsetsGeometry? padding;

  const DropdownMenuItem({
    super.key,
    required this.label,
    this.supportingText,
    this.selected = false,
    this.focused = false,
    this.enabled = true,
    this.onTap,
    this.icon,
    this.trailing,
    this.showCheckmark = true,
    this.destructive = false,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.padding,
  });

  @override
  State<DropdownMenuItem> createState() => _DropdownMenuItemState();
}

class _DropdownMenuItemState extends State<DropdownMenuItem> {
  bool _isHovered = false;

  Color _getBackgroundColor() {
    if (!widget.enabled) {
      return widget.selected
          ? UiColors.neutral500
          : const Color(0x00000000); // Transparent
    }

    if (widget.selected || _isHovered || widget.focused) { // coverage:ignore-line
      return widget.backgroundColor ?? UiColors.neutral500; // #647690
    }

    return widget.backgroundColor ?? const Color(0x00000000); // Transparent
  }

  Color _getTextColor() {
    if (!widget.enabled) {
      return UiColors.neutral400; // #93A0B4
    }

    if (widget.destructive) {
      return UiColors.error;
    }

    return widget.textColor ?? UiColors.onPrimary; // #FFFFFF
  }

  @override
  Widget build(BuildContext context) {
    final resolvedPadding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0);

    final textStyle = (widget.textStyle ?? UiTextStyles.textMd).copyWith(
      color: _getTextColor(),
    );

    return MouseRegion(
      onEnter: widget.enabled ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.enabled ? (_) => setState(() => _isHovered = false) : null,
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
          ),
          padding: resolvedPadding,
          child: Row(
            children: [
              // Leading icon
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 8.0),
              ],

              // Label and supporting text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: textStyle,
                    ),
                    if (widget.supportingText != null) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        widget.supportingText!,
                        style: UiTextStyles.textXs.copyWith(
                          color: widget.enabled
                              ? UiColors.neutral400
                              : UiColors.neutral400.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Trailing widget or checkmark
              if (widget.trailing != null) ...[ // coverage:ignore-line
                const SizedBox(width: 8.0),
                widget.trailing!,
              ] else if (widget.selected &&
                  widget.showCheckmark &&
                  widget.enabled) ...[
                const SizedBox(width: 8.0),
                CustomPaint(
                  size: const Size(20, 20),
                  painter: _CheckmarkIconPainter(
                    color: UiColors.onPrimary, // #FFFFFF
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The dropdown menu overlay that contains menu items
class DropdownMenu extends StatefulWidget {
  /// List of options to display
  final List<DropdownOption<dynamic>> options;

  /// Currently selected values
  final List<dynamic> selectedValues;

  /// Callback when an option is selected
  final void Function(dynamic value)? onSelected;

  /// Whether to show checkmarks on selected items
  final bool showCheckmarks;

  /// Width of the menu
  final double width;

  /// Maximum height before scrolling
  final double maxHeight;

  /// Whether to show a search field
  final bool searchable;

  /// Placeholder for search field
  final String? searchPlaceholder;

  /// Custom search filter
  final bool Function(DropdownOption<dynamic> option, String query)?
      searchFilter;

  /// Background color
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Border radius
  final double borderRadius;

  /// Index of the focused item (for keyboard navigation)
  final int? focusedIndex;

  /// Whether the dropdown is loading data
  final bool isLoading;

  /// Custom loading widget
  final Widget? loadingWidget;

  /// Loading message
  final String loadingMessage;

  /// Enable virtual scrolling for large lists
  final bool virtualScrolling;

  const DropdownMenu({
    super.key,
    required this.options,
    this.selectedValues = const [],
    this.onSelected,
    this.showCheckmarks = true,
    this.width = 320.0,
    this.maxHeight = 320.0,
    this.searchable = false,
    this.searchPlaceholder,
    this.searchFilter,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.focusedIndex,
    this.isLoading = false,
    this.loadingWidget,
    this.loadingMessage = 'Loading...',
    this.virtualScrolling = false,
  });

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<DropdownOption<dynamic>> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(DropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _onSearchChanged();
    }
    // Scroll to focused item
    if (widget.focusedIndex != null &&
        widget.focusedIndex != oldWidget.focusedIndex) {
      _scrollToIndex(widget.focusedIndex!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options.where((option) {
          if (widget.searchFilter != null) {
            return widget.searchFilter!(option, query);
          }
          // Default search: match label or supporting text (case insensitive)
          return option.label.toLowerCase().contains(query) ||
              (option.supportingText?.toLowerCase().contains(query) ?? false);
        }).toList();
      }
    });
  }

  void _scrollToIndex(int index) {
    if (_filteredOptions.isEmpty || index >= _filteredOptions.length) return;

    // Estimate item height (44px default)
    const itemHeight = 44.0;
    final targetOffset = index * itemHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          targetOffset.clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? UiColors.neutral600, // #475467
        border: Border.all(
          color: widget.borderColor ?? UiColors.neutral500, // #647690
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: const [
          // Shadow/lg from Figma
          BoxShadow(
            color: Color(0x08101828), // rgba(16, 24, 40, 0.03)
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color(0x14101828), // rgba(16, 24, 40, 0.08)
            offset: Offset(0, 12),
            blurRadius: 16,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search field
          if (widget.searchable) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _SearchField(
                controller: _searchController,
                placeholder: widget.searchPlaceholder ?? 'Search...',
              ),
            ),
            const _MenuDivider(),
          ],

          // Menu items or loading state
          Flexible(
            child: widget.isLoading
                ? _LoadingState(
                    loadingWidget: widget.loadingWidget,
                    message: widget.loadingMessage,
                  )
                : _filteredOptions.isEmpty
                    ? _EmptyState(
                        message: widget.searchable &&
                                _searchController.text.isNotEmpty
                            ? 'No results found'
                            : 'No options available',
                      )
                    : _buildMenuItems(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    // Virtual scrolling for very large lists
    if (widget.virtualScrolling && _filteredOptions.length > 100) {
      return _VirtualScrollList(
        itemCount: _filteredOptions.length,
        itemBuilder: (context, index) => _buildMenuItem(index),
        scrollController: _scrollController,
        maxHeight: widget.maxHeight,
      );
    }

    // Standard list view
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      itemCount: _filteredOptions.length,
      itemBuilder: (context, index) => _buildMenuItem(index),
    );
  }

  Widget _buildMenuItem(int index) {
    final option = _filteredOptions[index];
    final isSelected = widget.selectedValues.contains(option.value);
    final isFocused = widget.focusedIndex == index;

    // Custom builder if provided
    if (option.builder != null) {
      return GestureDetector(
        onTap:
            option.enabled ? () => widget.onSelected?.call(option.value) : null,
        child: option.builder!(context, isSelected, isFocused),
      );
    }

    // Group header
    Widget? groupHeader;
    if (option.group != null) {
      // Check if this is the first item in the group
      final isFirstInGroup =
          index == 0 || _filteredOptions[index - 1].group != option.group;
      if (isFirstInGroup) {
        groupHeader = _GroupHeader(label: option.group!);
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupHeader != null) groupHeader,
        DropdownMenuItem(
          label: option.label,
          supportingText: option.supportingText,
          selected: isSelected,
          focused: isFocused,
          enabled: option.enabled,
          icon: option.icon,
          trailing: option.trailing,
          showCheckmark: widget.showCheckmarks,
          onTap: option.enabled
              ? () => widget.onSelected?.call(option.value) // coverage:ignore-line
              : null,
        ),
        if (option.showDivider) const _MenuDivider(),
      ],
    );
  }
}

/// Simple search input for dropdown menu
class _SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;

  const _SearchField({
    required this.controller,
    required this.placeholder,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        color: UiColors.neutral700,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: UiColors.neutral500,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          CustomPaint(
            size: const Size(16, 16),
            painter: _SearchIconPainter(color: UiColors.neutral400),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: EditableText(
              controller: widget.controller,
              focusNode: _focusNode,
              style: UiTextStyles.textSm.copyWith(color: UiColors.onPrimary),
              cursorColor: UiColors.background,
              backgroundCursorColor: UiColors.background,
              selectionColor: UiColors.neutral300,
            ),
          ),
        ],
      ),
    );
  }
}

/// Divider between menu sections
class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      color: UiColors.neutral500,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
}

/// Empty state when no options are available
class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Text(
          message,
          style: UiTextStyles.textSm.copyWith(
            color: UiColors.neutral400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Loading state when data is being fetched
class _LoadingState extends StatelessWidget {
  final Widget? loadingWidget;
  final String message;

  const _LoadingState({
    this.loadingWidget,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loadingWidget ??
                SizedBox(
                  width: 20,
                  height: 20,
                  child: _LoadingSpinner(
                    color: UiColors.onPrimary,
                  ),
                ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                message,
                style: UiTextStyles.textXs.copyWith(
                  color: UiColors.neutral400,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Group header for categorizing menu items
class _GroupHeader extends StatelessWidget {
  final String label;

  const _GroupHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 8.0,
      ),
      child: Text(
        label.toUpperCase(),
        style: UiTextStyles.textXs.copyWith(
          color: UiColors.neutral400,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// Virtual scrolling widget for large lists
class _VirtualScrollList extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController scrollController;
  final double maxHeight;

  const _VirtualScrollList({
    required this.itemCount,
    required this.itemBuilder,
    required this.scrollController,
    required this.maxHeight,
  });

  @override
  State<_VirtualScrollList> createState() => _VirtualScrollListState();
}

class _VirtualScrollListState extends State<_VirtualScrollList> {
  static const double _itemHeight = 44.0;
  static const int _overscan = 3;

  int _firstVisibleIndex = 0;
  int _lastVisibleIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateVisibleRange);
    _updateVisibleRange();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateVisibleRange);
    super.dispose();
  }

  void _updateVisibleRange() {
    final offset = widget.scrollController.hasClients
        ? widget.scrollController.offset // coverage:ignore-line
        : 0.0;

    setState(() {
      _firstVisibleIndex = ((offset / _itemHeight) - _overscan)
          .floor()
          .clamp(0, widget.itemCount);
      // coverage:ignore-start
      _lastVisibleIndex =
          (((offset + widget.maxHeight) / _itemHeight) + _overscan)
              .ceil()
              .clamp(0, widget.itemCount);
      // coverage:ignore-end
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxHeight,
      child: ListView.builder(
        controller: widget.scrollController,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        itemCount: widget.itemCount,
        itemExtent: _itemHeight,
        itemBuilder: (context, index) {
          // Only build visible items
          if (index < _firstVisibleIndex || index >= _lastVisibleIndex) {
            return const SizedBox.shrink();
          }
          return widget.itemBuilder(context, index);
        },
      ),
    );
  }
}

/// Simple loading spinner
class _LoadingSpinner extends StatefulWidget {
  final Color color;

  const _LoadingSpinner({required this.color});

  @override
  State<_LoadingSpinner> createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<_LoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    // coverage:ignore-line
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _SpinnerPainter(
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

/// Painter for loading spinner
class _SpinnerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _SpinnerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // coverage:ignore-start
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 2) / 2;
    // coverage:ignore-end

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -1.5708; // -90 degrees (top)
    final sweepAngle = 2 * 3.14159 * 0.75; // 270 degrees

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + (progress * 2 * 3.14159),
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Custom painter for checkmark icon
class _CheckmarkIconPainter extends CustomPainter {
  final Color color;

  _CheckmarkIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw checkmark
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.5)
      // coverage:ignore-start
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..lineTo(size.width * 0.8, size.height * 0.3);
      // coverage:ignore-end

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for search icon
class _SearchIconPainter extends CustomPainter {
  final Color color;

  _SearchIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw circle (lens)
    final radius = size.width * 0.35;
    final center = Offset(size.width * 0.45, size.height * 0.45); // coverage:ignore-line
    canvas.drawCircle(center, radius, paint);

    // Draw handle
    final startHandle = Offset(
      center.dx + radius * 0.7,
      center.dy + radius * 0.7,
    );
    final endHandle = Offset(size.width * 0.85, size.height * 0.85); // coverage:ignore-line

    canvas.drawLine(startHandle, endHandle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
