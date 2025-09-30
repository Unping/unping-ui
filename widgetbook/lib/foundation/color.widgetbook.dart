import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/background.widgetbook.dart';
import '../utils/header.widgetbook.dart';
import '../utils/description.widgetbook.dart';

@UseCase(
  name: 'Color Palette',
  type: UiColors,
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7271&p=f&t=fMXcYIOzZi7Elvf6-0',
  path: 'Foundation',
)
Widget buildUiColorsUseCase(BuildContext context) {
  return UnpingUIWidgetbookBackground(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          padding: UiSpacing.allXxl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation breadcrumb using predefined header
              UnpingUiWidgetbookHeader(
                breadcrumbs: const ['Foundation', 'Colors'],
                title: "Colors",
              ),
              const SizedBox(height: UiSpacing.spacing4),

              // Description section using the reusable component
              UnpingUiWidgetbookDescription(
                  description:
                      'Our color palette is meticulously designed to be both vibrant and functional, offering a cohesive aesthetic across all projects. Each hue has been thoughtfully selected and tested to ensure it complements our typographic styles and enhances overall readability. By prioritizing accessibility, we ensure that our color choices are inclusive, enabling all users to engage with our interface comfortably and effectively.\n\n',
                  lists: {
                    'Categories:': [
                      'Gray: Neutral colors used for backgrounds, text, and secondary elements.',
                      'Success: Used to denote successful actions or positive feedback.',
                      'Warning: Used to highlight warnings or non-critical issues.',
                      'Error: Used to indicate errors or problematic actions.',
                    ],
                    'Usage Tips:': [
                      'Gray: Employ for backgrounds, borders, and secondary text to maintain a clean and uncluttered interface.',
                      'Success: Utilize for positive feedback and completed actions.',
                      'Warning: Apply to non-critical alerts that require user attention.',
                      'Error: Use sparingly to draw attention to critical issues.',
                    ],
                  }),
            ],
          ),
        ),

        // Color palette section
        Container(
          padding: UiSpacing.allXxl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gray column
              Expanded(
                child: _ColorColumn(
                  title: 'Gray',
                  colors: [
                    _ColorData('25', UiColors.neutral25),
                    _ColorData('50', UiColors.neutral50),
                    _ColorData('100', UiColors.neutral100),
                    _ColorData('200', UiColors.neutral200),
                    _ColorData('300', UiColors.neutral300),
                    _ColorData('400', UiColors.neutral400),
                    _ColorData('500', UiColors.neutral500),
                    _ColorData('600', UiColors.neutral600),
                    _ColorData('700', UiColors.neutral700),
                    _ColorData('800', UiColors.neutral800),
                    _ColorData('900', UiColors.neutral900),
                    _ColorData('950', UiColors.neutral950),
                  ],
                ),
              ),
              UiSpacing.horizontalGapXl,

              // Success column
              Expanded(
                child: _ColorColumn(
                  title: 'Success',
                  colors: [
                    _ColorData('25', UiColors.success25),
                    _ColorData('50', UiColors.success50),
                    _ColorData('100', UiColors.success100),
                    _ColorData('200', UiColors.success200),
                    _ColorData('300', UiColors.success300),
                    _ColorData('400', UiColors.success400),
                    _ColorData('500', UiColors.success500),
                    _ColorData('600', UiColors.success600),
                    _ColorData('700', UiColors.success700),
                    _ColorData('800', UiColors.success800),
                    _ColorData('900', UiColors.success900),
                    _ColorData('950', UiColors.success950),
                  ],
                ),
              ),
              UiSpacing.horizontalGapXl,

              // Warning column
              Expanded(
                child: _ColorColumn(
                  title: 'Warning',
                  colors: [
                    _ColorData('25', UiColors.warning25),
                    _ColorData('50', UiColors.warning50),
                    _ColorData('100', UiColors.warning100),
                    _ColorData('200', UiColors.warning200),
                    _ColorData('300', UiColors.warning300),
                    _ColorData('400', UiColors.warning400),
                    _ColorData('500', UiColors.warning500),
                    _ColorData('600', UiColors.warning600),
                    _ColorData('700', UiColors.warning700),
                    _ColorData('800', UiColors.warning800),
                    _ColorData('900', UiColors.warning900),
                    _ColorData('950', UiColors.warning950),
                  ],
                ),
              ),
              UiSpacing.horizontalGapXl,

              // Error column
              Expanded(
                child: _ColorColumn(
                  title: 'Error',
                  colors: [
                    _ColorData('25', UiColors.error25),
                    _ColorData('50', UiColors.error50),
                    _ColorData('100', UiColors.error100),
                    _ColorData('200', UiColors.error200),
                    _ColorData('300', UiColors.error300),
                    _ColorData('400', UiColors.error400),
                    _ColorData('500', UiColors.error500),
                    _ColorData('600', UiColors.error600),
                    _ColorData('700', UiColors.error700),
                    _ColorData('800', UiColors.error800),
                    _ColorData('900', UiColors.error900),
                    _ColorData('950', UiColors.error950),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ColorData {
  const _ColorData(this.weight, this.color);

  final String weight;
  final Color color;
}

class _ColorColumn extends StatelessWidget {
  const _ColorColumn({
    required this.title,
    required this.colors,
  });

  final String title;
  final List<_ColorData> colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...colors.map((colorData) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ColorSwatch(
                weight: colorData.weight,
                color: colorData.color,
              ),
            )),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.weight,
    required this.color,
  });

  final String weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 12),
            blurRadius: 16,
            spreadRadius: -4,
            color: const Color(0xFF101828).withValues(alpha: 0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -2,
            color: const Color(0xFF101828).withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left half - Color display
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          // Right half - Text information
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weight,
                    style: UiTextStyles.textXsMedium.copyWith(
                      color: UiColors.neutral900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 2), // Reduced spacing
                  SelectableText(
                      '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
                      style: UiTextStyles.textXs.copyWith(
                        color: UiColors.neutral500,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
