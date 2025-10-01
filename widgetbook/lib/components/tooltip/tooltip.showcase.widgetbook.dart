// widgetbook/components/tooltip/tooltip.showcase.widgetbook.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/background.widgetbook.dart';
import 'package:widgetbook_workspace/utils/header.widgetbook.dart';
import 'package:widgetbook_workspace/l10n/language_extension.dart';

// import the interaction helper (configurable UseCase is in that file)
import 'tooltip.configurable.widgetbook.dart';

@UseCase(
  name: 'Tooltip – placements & variants',
  type: UiTooltip,
  path: 'Components/Tooltip',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4938-63907',
)
Widget tooltipShowcase(BuildContext context) {
  return UnpingUIWidgetbookBackground(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: UiSpacing.allXxl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnpingUiWidgetbookHeader(
                  breadcrumbs: ['Components', 'Tooltip'],
                  title: context.lang.tooltipTitle,
                ),
                const SizedBox(height: UiSpacing.spacing4),
                _TooltipBodyText(),
              ],
            ),
          ),
          // GALLERY
          Padding(
            padding: UiSpacing.allXxl,
            child: _TooltipGallery(),
          ),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Body copy
// ─────────────────────────────────────────────────────────────────────────────
class _TooltipBodyText extends StatelessWidget {
  const _TooltipBodyText();

  @override
  Widget build(BuildContext context) {
    final body = UiTextStyles.textSm.copyWith(
      height: 1.5,
      color: Colors.white.withValues(alpha: .92),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1024),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.lang.tooltipDescription,
            style: body,
          ),
          const SizedBox(height: UiSpacing.spacing6),
          _SectionTitle(context.lang.tooltipCategories),
          const SizedBox(height: UiSpacing.spacing3),
          _NumberedLine(1,
              bold: context.lang.tooltipBasicCategory,
              rest: context.lang.tooltipBasicCategoryDesc),
          _NumberedLine(2,
              bold: context.lang.tooltipExtendedCategory,
              rest: context.lang.tooltipExtendedCategoryDesc),
          const SizedBox(height: UiSpacing.spacing6),
          _SectionTitle(context.lang.tooltipUsageTips),
          const SizedBox(height: UiSpacing.spacing3),
          _SubsectionTitle(context.lang.tooltipBasicUsageTitle),
          _BulletLine(
            bold: context.lang.tooltipConciseInfo,
            rest: context.lang.tooltipConciseInfoDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipContextualHelp,
            rest: context.lang.tooltipContextualHelpDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipConsistentStyling,
            rest: context.lang.tooltipConsistentStylingDesc,
          ),
          const SizedBox(height: UiSpacing.spacing4),
          _SubsectionTitle(context.lang.tooltipExtendedUsageTitle),
          _BulletLine(
            bold: context.lang.tooltipDetailedInfo,
            rest: context.lang.tooltipDetailedInfoDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipUserGuidance,
            rest: context.lang.tooltipUserGuidanceDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipClearFormatting,
            rest: context.lang.tooltipClearFormattingDesc,
          ),
          const SizedBox(height: UiSpacing.spacing4),
          _SectionTitle(context.lang.tooltipGeneralTips),
          _BulletLine(
            bold: context.lang.tooltipPlacement,
            rest: context.lang.tooltipPlacementDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipTrigger,
            rest: context.lang.tooltipTriggerDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipDismissal,
            rest: context.lang.tooltipDismissalDesc,
          ),
          _BulletLine(
            bold: context.lang.tooltipAccessibility,
            rest: context.lang.tooltipAccessibilityDesc,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: UiTextStyles.textMdBold.copyWith(color: Colors.white, height: 1.4),
    );
  }
}

class _SubsectionTitle extends StatelessWidget {
  const _SubsectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: UiSpacing.spacing2, bottom: 6),
      child: Text(
        text,
        style:
            UiTextStyles.textSmBold.copyWith(color: Colors.white, height: 1.4),
      ),
    );
  }
}

class _NumberedLine extends StatelessWidget {
  const _NumberedLine(this.n, {required this.bold, required this.rest});
  final int n;
  final String bold;
  final String rest;

  @override
  Widget build(BuildContext context) {
    final base = UiTextStyles.textMd.copyWith(
      color: Colors.white.withValues(alpha: .92),
      height: 1.6,
    );
    return RichText(
      text: TextSpan(
        style: base,
        children: [
          TextSpan(
            text: '$n. $bold: ',
            style: base.copyWith(fontWeight: UiTextStyles.semiBold),
          ),
          TextSpan(text: rest),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.bold, required this.rest});
  final String bold;
  final String rest;

  @override
  Widget build(BuildContext context) {
    final base = UiTextStyles.textSm.copyWith(
      color: Colors.white.withValues(alpha: .92),
      height: 1.6,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: Colors.white, height: 1.6)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: base,
                children: [
                  TextSpan(
                    text: '$bold: ',
                    style: base.copyWith(fontWeight: UiTextStyles.semiBold),
                  ),
                  TextSpan(text: rest),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Gallery
// ─────────────────────────────────────────────────────────────────────────────

class _TooltipGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UiRadius.lg),
        border: Border.all(color: UiColors.neutral700.withValues(alpha: .6)),
      ),
      child: LayoutBuilder(
        builder: (_, __) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: _TooltipColumn(light: true)),
              SizedBox(width: UiSpacing.spacing6),
              Expanded(child: _TooltipColumn(light: false)),
            ],
          );
        },
      ),
    );
  }
}

// map tail side to tooltip placement
UiTooltipPlacement _mapPlacement(_TailSide side) {
  switch (side) {
    case _TailSide.top:
      return UiTooltipPlacement.top;
    case _TailSide.bottom:
      return UiTooltipPlacement.bottom;
    case _TailSide.left:
      return UiTooltipPlacement.left;
    case _TailSide.right:
      return UiTooltipPlacement.right;
    case _TailSide.none:
      return UiTooltipPlacement.auto;
  }
}

class _TooltipColumn extends StatelessWidget {
  const _TooltipColumn({required this.light});
  final bool light;

  @override
  Widget build(BuildContext context) {
    final chips = <_TooltipChip>[
      _TooltipChip(text: 'This is a tooltip', light: light, tail: _Tail.none),
      _TooltipChip(
          text: 'This is a tooltip',
          light: light,
          tail: const _Tail.bottom(.50)),
      _TooltipChip(
          text: 'This is a tooltip',
          light: light,
          tail: const _Tail.bottom(.15)),
      _TooltipChip(
          text: 'This is a tooltip',
          light: light,
          tail: const _Tail.bottom(.85)),
      _TooltipChip(
          text: 'This is a tooltip', light: light, tail: const _Tail.top(.50)),
      _TooltipChip(
          text: 'This is a tooltip', light: light, tail: const _Tail.left(.50)),
      _TooltipChip(
          text: 'This is a tooltip',
          light: light,
          tail: const _Tail.right(.50)),
    ];

    final extendedTails = <_Tail>[
      _Tail.none,
      const _Tail.bottom(.18),
      const _Tail.bottom(.82),
      const _Tail.right(.50),
      const _Tail.top(.50),
      const _Tail.left(.50),
      const _Tail.bottom(.50),
      const _Tail.right(.85),
    ];

    const variant = UiTooltipVariant.neutral;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in chips)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            // ▼ attach interactions here using the helper from the config file
            child: TooltipConfigurable(
              message: c.text,
              placement: _mapPlacement(c.tail.side),
              variant: variant,
              triggerOnHover: false,
              triggerOnLongPress: false,
              child: c,
            ),
          ),
        const SizedBox(height: 24),
        for (final t in extendedTails)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TooltipConfigurable(
              message: 'This is a tooltip',
              placement: _mapPlacement(t.side),
              variant: variant,
              triggerOnHover: false,
              triggerOnLongPress: false,
              child: _TooltipExtendedCard(light: light, tail: t),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tail + Presentational widgets (unchanged)
// ─────────────────────────────────────────────────────────────────────────────

class _Tail {
  const _Tail._(this.side, this.align);
  final _TailSide side;
  final double align;

  static const none = _Tail._(_TailSide.none, .5);
  const _Tail.top(double a) : this._(_TailSide.top, a);
  const _Tail.bottom(double a) : this._(_TailSide.bottom, a);
  const _Tail.left(double a) : this._(_TailSide.left, a);
  const _Tail.right(double a) : this._(_TailSide.right, a);
}

enum _TailSide { none, top, bottom, left, right }

// chips
class _TooltipChip extends StatelessWidget {
  const _TooltipChip({
    required this.text,
    required this.light,
    this.tail = _Tail.none,
  });

  final String text;
  final bool light;
  final _Tail tail;

  @override
  Widget build(BuildContext context) {
    final bg = light ? Colors.white : UiColors.neutral900;
    final fg = light ? UiColors.neutral900 : Colors.white;
    final textStyle =
        UiTextStyles.textXsMedium.copyWith(height: 1.25, color: fg);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(text, style: textStyle),
          ),
        ),
        if (tail.side != _TailSide.none)
          _TailPainter(color: bg, side: tail.side, align: tail.align),
      ],
    );
  }
}

// diamond tail painter
class _TailPainter extends StatelessWidget {
  const _TailPainter({
    required this.color,
    required this.side,
    required this.align,
    this.size = 12,
    this.protrusion = 6,
  });

  final Color color;
  final _TailSide side;
  final double align;
  final double size;
  final double protrusion;

  @override
  Widget build(BuildContext context) {
    final diamond = Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: size,
        height: size,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      ),
    );

    switch (side) {
      case _TailSide.top:
        return Positioned.fill(
          child: Align(
            alignment: Alignment(_lerp(-1, 1, align), -1),
            child: Transform.translate(
                offset: Offset(0, -protrusion), child: diamond),
          ),
        );
      case _TailSide.bottom:
        return Positioned.fill(
          child: Align(
            alignment: Alignment(_lerp(-1, 1, align), 1),
            child: Transform.translate(
                offset: Offset(0, protrusion), child: diamond),
          ),
        );
      case _TailSide.left:
        return Positioned.fill(
          child: Align(
            alignment: Alignment(-1, _lerp(-1, 1, align)),
            child: Transform.translate(
                offset: Offset(-protrusion, 0), child: diamond),
          ),
        );
      case _TailSide.right:
        return Positioned.fill(
          child: Align(
            alignment: Alignment(1, _lerp(-1, 1, align)),
            child: Transform.translate(
                offset: Offset(protrusion, 0), child: diamond),
          ),
        );
      case _TailSide.none:
        return const SizedBox.shrink();
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}

// extended card
class _TooltipExtendedCard extends StatelessWidget {
  const _TooltipExtendedCard({
    required this.light,
    this.tail = _Tail.none,
  });

  final bool light;
  final _Tail tail;

  @override
  Widget build(BuildContext context) {
    final bg = light ? Colors.white : UiColors.neutral900;
    final titleColor = light ? UiColors.neutral900 : Colors.white;
    final bodyColor =
        light ? UiColors.neutral600 : Colors.white.withValues(alpha: .88);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 12,
                  offset: Offset(0, 6)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('This is a tooltip',
                    style: UiTextStyles.textSmBold
                        .copyWith(color: titleColor, height: 1.25)),
                const SizedBox(height: 6),
                Text(
                  'Tooltips are used to describe or identify an element. In most scenarios, '
                  'tooltips help the user understand the meaning, function or alt-text of an element.',
                  style: UiTextStyles.textSm
                      .copyWith(color: bodyColor, height: 1.5),
                ),
              ],
            ),
          ),
        ),
        if (tail.side != _TailSide.none)
          _TailPainter(
            color: bg,
            side: tail.side,
            align: tail.align,
            size: 14,
            protrusion: 7,
          ),
      ],
    );
  }
}
