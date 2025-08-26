import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_background.dart';
import '../../widgetbook/unping_ui_widgetbook_header.dart';
import '../../widgetbook/unping_ui_widgetbook_description.dart';

@UseCase(
  name: 'Color Palette',
  type: UnpingColors,
  designLink: 'https://www.figma.com/design/unping-ui-colors',
)
Widget buildUnpingColorsUseCase(BuildContext context) {
  return UnpingUIWidgetbookBackground(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          padding: UnpingSpacing.allXxl,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Navigation breadcrumb using predefined header
                UnpingUiWidgetbookHeader(
                  breadcrumbs: const ['Foundation', 'Colors'],
                  title: "Colors",
                ),
                const SizedBox(height: UnpingSpacing.spacing4),
                
                // Description section using the reusable component
                UnpingUiWidgetbookDescription(
                  description: 'Our color palette is meticulously designed to be both vibrant and functional, offering a cohesive aesthetic across all projects. Each hue has been thoughtfully selected and tested to ensure it complements our typographic styles and enhances overall readability. By prioritizing accessibility, we ensure that our color choices are inclusive, enabling all users to engage with our interface comfortably and effectively.\n\n',
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
                  }
                ),
              ],
          ),
        ),
        
        // Color palette section
        Container(
          padding: UnpingSpacing.allXxl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gray column
              Expanded(
                child: _ColorColumn(
                  title: 'Gray',
                  colors: [
                    _ColorData('25', UnpingColors.neutral25),
                    _ColorData('50', UnpingColors.neutral50),
                    _ColorData('100', UnpingColors.neutral100),
                    _ColorData('200', UnpingColors.neutral200),
                    _ColorData('300', UnpingColors.neutral300),
                    _ColorData('400', UnpingColors.neutral400),
                    _ColorData('500', UnpingColors.neutral500),
                    _ColorData('600', UnpingColors.neutral600),
                    _ColorData('700', UnpingColors.neutral700),
                    _ColorData('800', UnpingColors.neutral800),
                    _ColorData('900', UnpingColors.neutral900),
                    _ColorData('950', UnpingColors.neutral950),
                  ],
                ),
              ),
              UnpingSpacing.horizontalGapXl,
              
              // Success column
              Expanded(
                child: _ColorColumn(
                  title: 'Success',
                  colors: [
                    _ColorData('25', UnpingColors.success25),
                    _ColorData('50', UnpingColors.success50),
                    _ColorData('100', UnpingColors.success100),
                    _ColorData('200', UnpingColors.success200),
                    _ColorData('300', UnpingColors.success300),
                    _ColorData('400', UnpingColors.success400),
                    _ColorData('500', UnpingColors.success500),
                    _ColorData('600', UnpingColors.success600),
                    _ColorData('700', UnpingColors.success700),
                    _ColorData('800', UnpingColors.success800),
                    _ColorData('900', UnpingColors.success900),
                    _ColorData('950', UnpingColors.success950),
                  ],
                ),
              ),
              UnpingSpacing.horizontalGapXl,
              
              // Warning column
              Expanded(
                child: _ColorColumn(
                  title: 'Warning',
                  colors: [
                    _ColorData('25', UnpingColors.warning25),
                    _ColorData('50', UnpingColors.warning50),
                    _ColorData('100', UnpingColors.warning100),
                    _ColorData('200', UnpingColors.warning200),
                    _ColorData('300', UnpingColors.warning300),
                    _ColorData('400', UnpingColors.warning400),
                    _ColorData('500', UnpingColors.warning500),
                    _ColorData('600', UnpingColors.warning600),
                    _ColorData('700', UnpingColors.warning700),
                    _ColorData('800', UnpingColors.warning800),
                    _ColorData('900', UnpingColors.warning900),
                    _ColorData('950', UnpingColors.warning950),
                  ],
                ),
              ),
              UnpingSpacing.horizontalGapXl,
              
              // Error column
              Expanded(
                child: _ColorColumn(
                  title: 'Error',
                  colors: [
                    _ColorData('25', UnpingColors.error25),
                    _ColorData('50', UnpingColors.error50),
                    _ColorData('100', UnpingColors.error100),
                    _ColorData('200', UnpingColors.error200),
                    _ColorData('300', UnpingColors.error300),
                    _ColorData('400', UnpingColors.error400),
                    _ColorData('500', UnpingColors.error500),
                    _ColorData('600', UnpingColors.error600),
                    _ColorData('700', UnpingColors.error700),
                    _ColorData('800', UnpingColors.error800),
                    _ColorData('900', UnpingColors.error900),
                    _ColorData('950', UnpingColors.error950),
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
            color: const Color(0xFF101828).withOpacity(0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -2,
            color: const Color(0xFF101828).withOpacity(0.05),
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
                    style: UnpingTextStyles.textXsMedium.copyWith(
                      color: UnpingColors.neutral900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 2), // Reduced spacing
                  SelectableText(
                    '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
                    style: UnpingTextStyles.textXs.copyWith(
                      color: UnpingColors.neutral500,
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

