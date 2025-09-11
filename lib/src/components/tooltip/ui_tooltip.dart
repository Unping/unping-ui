import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

enum UiTooltipPlacement { top, bottom, left, right, auto }
enum UiTooltipVariant { neutral, info, success, warning, error }

// Figma-aligned defaults
const _kShow = Duration(milliseconds: 140);
const _kHide = Duration(milliseconds: 120);
const _kDelay = Duration(milliseconds: 350);
const _kPad = EdgeInsets.symmetric(horizontal: 10, vertical: 6);
const _kRadius = BorderRadius.all(Radius.circular(6));
const _kShadow = [BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 4))];
const _kGap = 8.0;
const _kMaxW = 280.0;

@immutable
class UiTooltipStyle {
  const UiTooltipStyle({
    required this.background,
    required this.textStyle,
    this.padding = _kPad,
    this.radius = _kRadius,
    this.shadow = _kShadow,
    this.gap = _kGap,
    this.maxWidth = _kMaxW,
    this.showDuration = _kShow,
    this.hideDuration = _kHide,
    this.showDelay = _kDelay,
  });

  final Color background;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final BorderRadius radius;
  final List<BoxShadow> shadow;
  final double gap;
  final double maxWidth;
  final Duration showDuration;
  final Duration hideDuration;
  final Duration showDelay;

  UiTooltipStyle copyWith({
    Color? background,
    TextStyle? textStyle,
    EdgeInsets? padding,
    BorderRadius? radius,
    List<BoxShadow>? shadow,
    double? gap,
    double? maxWidth,
    Duration? showDuration,
    Duration? hideDuration,
    Duration? showDelay,
  }) {
    return UiTooltipStyle(
      background: background ?? this.background,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
      shadow: shadow ?? this.shadow,
      gap: gap ?? this.gap,
      maxWidth: maxWidth ?? this.maxWidth,
      showDuration: showDuration ?? this.showDuration,
      hideDuration: hideDuration ?? this.hideDuration,
      showDelay: showDelay ?? this.showDelay,
    );
  }
}

// Build style WITHOUT touching context. We pass width in later.
UiTooltipStyle _styleFor(UiTooltipVariant variant, double viewportWidth) {
  final base = UiTextStyles.textXs.fontSize ?? 12.0;
  double fontSize = base;
  if (viewportWidth <= 360) fontSize = (base - 2).clamp(10, base).toDouble();
  else if (viewportWidth <= 480) fontSize = (base - 1).clamp(10, base).toDouble();

  final txt = UiTextStyles.textXs.copyWith(
    fontSize: fontSize,
    height: 1.25,
    color: Colors.white,
  );

  switch (variant) {
    case UiTooltipVariant.info:    return UiTooltipStyle(background: UiColors.primary600, textStyle: txt);
    case UiTooltipVariant.success: return UiTooltipStyle(background: UiColors.success600,  textStyle: txt);
    case UiTooltipVariant.warning: return UiTooltipStyle(background: UiColors.warning600,  textStyle: txt);
    case UiTooltipVariant.error:   return UiTooltipStyle(background: UiColors.error600,    textStyle: txt);
    case UiTooltipVariant.neutral:
    default:                       return UiTooltipStyle(background: UiColors.neutral900,  textStyle: txt);
  }
}

class UiTooltip extends StatefulWidget {
  const UiTooltip({
    super.key,
    required this.child,
    required this.message,
    this.variant = UiTooltipVariant.neutral,
    this.placement = UiTooltipPlacement.auto,
    this.enabled = true,
    this.style,
    this.triggerOnLongPress = true,
    this.triggerOnHover = true,
    this.enableSemantics = true,
  });

  final Widget child;
  final String message;
  final UiTooltipVariant variant;
  final UiTooltipPlacement placement;
  final bool enabled;
  final UiTooltipStyle? style;
  final bool triggerOnHover;
  final bool triggerOnLongPress;
  final bool enableSemantics;

  @override
  State<UiTooltip> createState() => _UiTooltipState();
}

class _UiTooltipState extends State<UiTooltip> with TickerProviderStateMixin {
  final _link = LayerLink();
  OverlayEntry? _entry;
  Timer? _delay;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.style?.showDuration ?? _kShow,
    reverseDuration: widget.style?.hideDuration ?? _kHide,
  );
  bool _visible = false;

  @override
  void didUpdateWidget(covariant UiTooltip old) {
    super.didUpdateWidget(old);
    if (!widget.enabled) _hide(immediate: true);

    // keep timings in sync if style changed
    _controller.duration = widget.style?.showDuration ?? _kShow;
    _controller.reverseDuration = widget.style?.hideDuration ?? _kHide;

    // if identity changes (label/child), close to avoid reparenting glitches
    if (old.message != widget.message || old.child.key != widget.child.key) {
      _hide(immediate: true);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if theme/mediaquery changes while shown, close cleanly
    _hide(immediate: true);
  }

  @override
  void reassemble() {
    super.reassemble();
    // hot reload safety
    _hide(immediate: true);
  }

  @override
  void dispose() {
    _delay?.cancel();
    _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _scheduleShow() {
    if (!widget.enabled || _visible) return;
    _delay?.cancel();
    _delay = Timer(widget.style?.showDelay ?? _kDelay, _show);
  }

  void _show() {
    if (!mounted || _visible || !widget.enabled) return;
    _entry = OverlayEntry(builder: _buildOverlay);
    Overlay.of(context).insert(_entry!);
    _visible = true;
    _controller.forward(from: 0);
  }

  void _hide({bool immediate = false}) async {
    _delay?.cancel();
    if (!_visible) return;
    if (immediate) {
      _removeEntry();
      return;
    }
    try {
      await _controller.reverse();
    } finally {
      _removeEntry();
    }
  }

  void _removeEntry() {
    _entry?.remove();
    _entry = null;
    _visible = false;
  }

  UiTooltipPlacement _resolvedPlacement() {
    if (widget.placement != UiTooltipPlacement.auto) return widget.placement;

    final rb = context.findRenderObject() as RenderBox?;
    if (rb == null || !rb.hasSize) return UiTooltipPlacement.top;

    final size = rb.size;
    final topLeft = rb.localToGlobal(Offset.zero);
    final bottomRight = rb.localToGlobal(Offset(size.width, size.height));
    final screen = MediaQuery.sizeOf(context);

    final spaceTop = topLeft.dy;
    final spaceBottom = screen.height - bottomRight.dy;
    final spaceLeft = topLeft.dx;
    final spaceRight = screen.width - bottomRight.dx;

    if (spaceTop >= 56) return UiTooltipPlacement.top;
    if (spaceBottom >= 56) return UiTooltipPlacement.bottom;
    if (spaceRight >= 120) return UiTooltipPlacement.right;
    if (spaceLeft >= 120) return UiTooltipPlacement.left;
    return UiTooltipPlacement.top;
  }

  Widget _buildOverlay(BuildContext _) {
    final placement = _resolvedPlacement();

    Alignment targetAnchor, followerAnchor;
    Offset offset;
    switch (placement) {
      case UiTooltipPlacement.top:
        targetAnchor = Alignment.topCenter;    followerAnchor = Alignment.bottomCenter; offset = const Offset(0, -_kGap); break;
      case UiTooltipPlacement.bottom:
        targetAnchor = Alignment.bottomCenter; followerAnchor = Alignment.topCenter;    offset = const Offset(0, _kGap);  break;
      case UiTooltipPlacement.left:
        targetAnchor = Alignment.centerLeft;   followerAnchor = Alignment.centerRight;  offset = const Offset(-_kGap, 0); break;
      case UiTooltipPlacement.right:
        targetAnchor = Alignment.centerRight;  followerAnchor = Alignment.centerLeft;   offset = const Offset(_kGap, 0);  break;
      case UiTooltipPlacement.auto:
        targetAnchor = Alignment.bottomCenter; followerAnchor = Alignment.topCenter;    offset = const Offset(0, _kGap);  break;
    }

    // Build style *now* using current viewport width
    final vw = MediaQuery.sizeOf(context).width;
    final style = (widget.style ?? _styleFor(widget.variant, vw));

    final bubble = FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.98, end: 1.0)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: Material(
          type: MaterialType.transparency,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: style.maxWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: style.radius,
                boxShadow: style.shadow,
              ),
              child: Padding(
                padding: style.padding,
                child: Text(
                  widget.message,
                  softWrap: true,
                  textScaler: MediaQuery.textScalerOf(context),
                  style: style.textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: true,
        child: CompositedTransformFollower(
          link: _link,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          offset: offset,
          child: bubble,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget core = CompositedTransformTarget(link: _link, child: widget.child);

    if (widget.enableSemantics) {
      core = Semantics(tooltip: widget.message, child: core);
    }

    return FocusableActionDetector(
      onShowHoverHighlight: widget.triggerOnHover ? (h) => h ? _scheduleShow() : _hide() : null,
      onShowFocusHighlight: (f) => f ? _scheduleShow() : _hide(),
      child: MouseRegion(
        onEnter: widget.triggerOnHover ? (_) => _scheduleShow() : null,
        onExit: (_) => _hide(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPress: widget.triggerOnLongPress ? _scheduleShow : null,
          onLongPressEnd: (_) => _hide(),
          onTapDown: (_) {
            if (!widget.triggerOnLongPress && defaultTargetPlatform == TargetPlatform.android) {
              _scheduleShow();
            }
          },
          onTapCancel: _hide,
          onTapUp: (_) => _hide(),
          child: core,
        ),
      ),
    );
  }
}
