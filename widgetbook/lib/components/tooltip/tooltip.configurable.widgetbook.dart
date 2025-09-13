import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/utils/background.widgetbook.dart';
import 'package:widgetbook_workspace/utils/header.widgetbook.dart';

@widgetbook.UseCase(
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
                  breadcrumbs: const ['Components', 'Tooltip'],
                  title: 'Tooltips',
                ),
                const SizedBox(height: UiSpacing.spacing4),

                // === REPLACE the old description with this ===
                const _TooltipBodyText(),
              ],
            ),
          ),

// EXAMPLES
          Padding(
            padding: UiSpacing.allXxl,
            child: _TooltipGallery(),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------

class _TooltipBodyText extends StatelessWidget {
  const _TooltipBodyText();

  @override
  Widget build(BuildContext context) {
    final body = UiTextStyles.textSm.copyWith(
      // Figma: Text xl / 700

      height: 1.5,
      color: Colors.white.withValues(alpha: .92),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1024),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supporting paragraph
          Text(
            'Tooltips are essential for providing contextual information and guidance to users within an application. '
            'Our design system includes a variety of tooltip styles to ensure consistency and clarity across all user interfaces. '
            'These components are designed to be easily recognizable and to provide quick, helpful information without disrupting '
            'the user’s workflow.',
            style: body,
          ),
          const SizedBox(height: UiSpacing.spacing6),

          const _SectionTitle('Categories:'),
          const SizedBox(height: UiSpacing.spacing3),
          const _NumberedLine(1,
              bold: 'Basic Tooltip',
              rest:
                  'Simple tooltips that provide brief information or descriptions.'),
          const _NumberedLine(2,
              bold: 'Extended Tooltip',
              rest: 'Tooltips with additional details or instructions.'),
          const SizedBox(height: UiSpacing.spacing6),

          const _SectionTitle('Usage Tips:'),
          const SizedBox(height: UiSpacing.spacing3),

          const _SubsectionTitle('Basic Tooltip:'),
          const _BulletLine(
            bold: 'Concise Information',
            rest:
                'Use basic tooltips to provide brief, concise information or descriptions.',
          ),
          const _BulletLine(
            bold: 'Contextual Help',
            rest:
                'Place tooltips near the relevant UI elements to offer immediate contextual help.',
          ),
          const _BulletLine(
            bold: 'Consistent Styling',
            rest:
                'Ensure that all basic tooltips have a consistent style, including font, color, and background.',
          ),
          const SizedBox(height: UiSpacing.spacing4),

          const _SubsectionTitle('Extended Tooltip:'),
          const _BulletLine(
            bold: 'Detailed Information',
            rest:
                'Use extended tooltips to provide more detailed information or instructions.',
          ),
          const _BulletLine(
            bold: 'User Guidance',
            rest:
                'Place extended tooltips near complex UI elements to guide users through their interactions.',
          ),
          const _BulletLine(
            bold: 'Clear Formatting',
            rest:
                'Ensure that extended tooltips are well-formatted, with clear headings, bullet points, or steps as needed.',
          ),
          const SizedBox(height: UiSpacing.spacing4),

          const _SectionTitle('General Tips:'),
          const _BulletLine(
            bold: 'Placement',
            rest:
                'Position tooltips close to the relevant UI elements to maintain context and usability.',
          ),
          const _BulletLine(
            bold: 'Trigger',
            rest:
                'Use hover or focus states to trigger tooltips, ensuring they appear when users need them.',
          ),
          const _BulletLine(
            bold: 'Dismissal',
            rest:
                'Allow users to dismiss tooltips easily, either by clicking away or after a short delay.',
          ),
          const _BulletLine(
            bold: 'Accessibility',
            rest:
                'Ensure tooltips are accessible to screen readers and keyboard users.',
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
      style: UiTextStyles.textMdBold.copyWith(
        color: Colors.white,
        height: 1.4,
      ),
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
        style: UiTextStyles.textSmBold.copyWith(
          color: Colors.white,
          height: 1.4,
        ),
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
            children: [
              // LEFT: Light tooltips
              Expanded(child: _TooltipColumn(light: true)),
              UiSpacing.horizontalGapXl,
              // RIGHT: Dark tooltips
              Expanded(child: _TooltipColumn(light: false)),
            ],
          );
        },
      ),
    );
  }
}

class _TooltipColumn extends StatelessWidget {
  const _TooltipColumn({required this.light});
  final bool light;

  @override
  Widget build(BuildContext context) {
    // chips (unchanged)
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

    // extended (big) cards — 8 items with varied tails like figma
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in chips)
          Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: c),
        const SizedBox(height: 24),
        for (final t in extendedTails)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _TooltipExtendedCard(light: light, tail: t),
          ),
      ],
    );
  }
}

// Tail descriptor -------------------------------------------------------------
class _Tail {
  const _Tail._(this.side, this.align);
  final _TailSide side; // which side the tail sits on
  final double align; // 0..1 along that side

  static const none = _Tail._(_TailSide.none, .5);
  const _Tail.top(double a) : this._(_TailSide.top, a);
  const _Tail.bottom(double a) : this._(_TailSide.bottom, a);
  const _Tail.left(double a) : this._(_TailSide.left, a);
  const _Tail.right(double a) : this._(_TailSide.right, a);
}

enum _TailSide { none, top, bottom, left, right }

// Chip with speech-bubble tail -----------------------------------------------
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
        // bubble
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
        // tail
        if (tail.side != _TailSide.none)
          _TailPainter(color: bg, side: tail.side, align: tail.align),
      ],
    );
  }
}

// The “diamond” tail, positioned outside the bubble --------------------------

class _TailPainter extends StatelessWidget {
  const _TailPainter({
    required this.color,
    required this.side,
    required this.align,
    this.size = 12, // square before rotate (chips default)
    this.protrusion = 6, // how far it sticks out
  });

  final Color color;
  final _TailSide side;
  final double align; // 0..1 along that side
  final double size;
  final double protrusion;

  @override
  Widget build(BuildContext context) {
    final diamond = Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
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

        // larger tail for the card
        if (tail.side != _TailSide.none)
          _TailPainter(
            color: bg,
            side: tail.side,
            align: tail.align,
            size: 14, // a bit bigger than chips
            protrusion: 7, // match figma inset
          ),
      ],
    );
  }
}
