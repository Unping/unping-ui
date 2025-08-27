import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_background.dart';
import '../../widgetbook/unping_ui_widgetbook_header.dart';
import '../../widgetbook/unping_ui_widgetbook_description.dart';

@UseCase(
  name: 'Spacing System',
  type: UiSpacing,
  designLink: 'https://www.figma.com/design/unping-ui-spacing',
  path: '[UI]/Foundation',
)
Widget buildUiSpacingUseCase(BuildContext context) {
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
                  breadcrumbs: const ['Foundation', 'Spacing'],
                  title: "Spacing",
                ),
                const SizedBox(height: UiSpacing.spacing4),
                
                // Description section using the reusable component
                UnpingUiWidgetbookDescription(
                  description: 'Consistent and well-defined spacing is crucial for creating a visually balanced and user-friendly interface. Our design system includes a comprehensive set of spacing guidelines to ensure consistency and clarity across all user interfaces. These guidelines help maintain a cohesive layout and improve the overall user experience.\n\n',
                  lists: {
                    'Spacing Scale:': [
                      'Based on a 4px base unit for mathematical consistency.',
                      'Ranges from 0px to 1,920px to cover all design needs.',
                      'Follows a logical progression for predictable scaling.',
                      'Includes fractional values (0.5, 1, 2, 3) for fine-tuned control.',
                    ],
                    'Usage Guidelines:': [
                      'Use smaller values (0-24px) for component-level spacing.',
                      'Use medium values (32-96px) for section and layout spacing.',
                      'Use larger values (120px+) for page-level margins and major sections.',
                      'Maintain consistency by using predefined spacing values.',
                    ],
                  }
                ),
              ],
          ),
        ),
        
        // Spacing table
        Container(
          width: double.infinity,
          padding: UiSpacing.allXxl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Table header
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE4E7EC), width: 1),
                  ),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 112, // Min width from Figma
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 64),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            height: 1.5, // 18/12
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 128, // Min width from Figma
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 64),
                        child: Text(
                          'Size (16px base)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            height: 1.5, // 18/12
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 128, // Min width from Figma
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 64),
                        child: Text(
                          'Pixel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            height: 1.5, // 18/12
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 64),
                        child: Text(
                          'Spacing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            height: 1.5, // 18/12
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12), // Spacer between header and content
              // Table content
              ..._buildSpacingRows(),
            ],
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildSpacingRows() {
  // All spacing values from the Figma design and UiSpacing class
  final spacingData = [
    {'name': '0', 'rem': '0rem', 'px': '0px', 'value': UiSpacing.spacing0},
    {'name': '0.5', 'rem': '0.125rem', 'px': '2px', 'value': UiSpacing.spacing0_5},
    {'name': '1', 'rem': '0.25rem', 'px': '4px', 'value': UiSpacing.spacing1},
    {'name': '2', 'rem': '0.5rem', 'px': '8px', 'value': UiSpacing.spacing2},
    {'name': '3', 'rem': '0.75rem', 'px': '12px', 'value': UiSpacing.spacing3},
    {'name': '4', 'rem': '1rem', 'px': '16px', 'value': UiSpacing.spacing4},
    {'name': '5', 'rem': '1.25rem', 'px': '20px', 'value': UiSpacing.spacing5},
    {'name': '6', 'rem': '1.5rem', 'px': '24px', 'value': UiSpacing.spacing6},
    {'name': '8', 'rem': '2rem', 'px': '32px', 'value': UiSpacing.spacing8},
    {'name': '10', 'rem': '2.5rem', 'px': '40px', 'value': UiSpacing.spacing10},
    {'name': '12', 'rem': '3rem', 'px': '48px', 'value': UiSpacing.spacing12},
    {'name': '16', 'rem': '4rem', 'px': '64px', 'value': UiSpacing.spacing16},
    {'name': '20', 'rem': '5rem', 'px': '80px', 'value': UiSpacing.spacing20},
    {'name': '24', 'rem': '6rem', 'px': '96px', 'value': UiSpacing.spacing24},
    {'name': '32', 'rem': '8rem', 'px': '128px', 'value': UiSpacing.spacing32},
    {'name': '40', 'rem': '10rem', 'px': '160px', 'value': UiSpacing.spacing40},
    {'name': '48', 'rem': '12rem', 'px': '192px', 'value': UiSpacing.spacing48},
    {'name': '56', 'rem': '14rem', 'px': '224px', 'value': UiSpacing.spacing56},
    {'name': '64', 'rem': '16rem', 'px': '256px', 'value': UiSpacing.spacing64},
    {'name': '80', 'rem': '20rem', 'px': '320px', 'value': UiSpacing.spacing80},
    {'name': '96', 'rem': '24rem', 'px': '384px', 'value': UiSpacing.spacing96},
    {'name': '120', 'rem': '30rem', 'px': '480px', 'value': UiSpacing.spacing120},
    {'name': '140', 'rem': '35rem', 'px': '560px', 'value': UiSpacing.spacing140},
    {'name': '160', 'rem': '40rem', 'px': '640px', 'value': UiSpacing.spacing160},
    {'name': '180', 'rem': '45rem', 'px': '720px', 'value': UiSpacing.spacing180},
    {'name': '192', 'rem': '48rem', 'px': '768px', 'value': UiSpacing.spacing192},
    {'name': '256', 'rem': '64rem', 'px': '1,024px', 'value': UiSpacing.spacing256},
    {'name': '320', 'rem': '80rem', 'px': '1,280px', 'value': UiSpacing.spacing320},
    {'name': '360', 'rem': '90rem', 'px': '1,440px', 'value': UiSpacing.spacing360},
    {'name': '400', 'rem': '100rem', 'px': '1,600px', 'value': UiSpacing.spacing400},
    {'name': '480', 'rem': '120rem', 'px': '1,920px', 'value': UiSpacing.spacing480},
  ];

  return spacingData.map((data) => _SpacingRow(
    name: data['name'] as String,
    rem: data['rem'] as String,
    px: data['px'] as String,
    value: data['value'] as double,
  )).toList();
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow({
    required this.name,
    required this.rem,
    required this.px,
    required this.value,
  });

  final String name;
  final String rem;
  final String px;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE4E7EC), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Name column with badge
          SizedBox(
            width: 112,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0).copyWith(right: 64),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B4554), // BG lighter from Figma
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE4E7EC)),
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    height: 1.5, // 24/16
                  ),
                ),
              ),
            ),
          ),
          // Rem size column
          SizedBox(
            width: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0).copyWith(right: 64),
              child: Text(
                rem,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  height: 1.5, // 24/16
                ),
              ),
            ),
          ),
          // Pixel size column
          SizedBox(
            width: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0).copyWith(right: 64),
              child: Text(
                px,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  height: 1.5, // 24/16
                ),
              ),
            ),
          ),
          // Spacing visualization column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0).copyWith(right: 64),
              child: _SpacingVisualization(value: value),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpacingVisualization extends StatelessWidget {
  const _SpacingVisualization({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    // Create a visual representation of the spacing
    // For very small values, ensure minimum visibility
    final displayWidth = value == 0 ? 0.0 : (value < 4 ? 4.0 : value);
    
    return SizedBox(
      height: 16,
      child: Stack(
        children: [
          // Background track (full width, light)
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1), // Primary color background
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // Foreground bar (actual spacing width)
          if (value > 0)
            Container(
              width: displayWidth.clamp(0, 400), // Clamp to reasonable max width for display
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1), // Primary color
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
