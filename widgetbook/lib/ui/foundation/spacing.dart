import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Spacing System',
  type: UiSpacing,
  designLink: 'https://www.figma.com/design/unping-ui-spacing',
)
Widget buildUiSpacingUseCase(BuildContext context) {
  return Container(
    color: const Color(0xFF2A313C), // Background from Figma
    child: Column(
      children: [
        // Header section with background and title
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(80), // From Figma design
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content with gradient background
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(48), // From Figma design
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // From Figma design
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B9D), Color(0xFF4FB3D9)], // Figma gradient colors
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Logo placeholder
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.4),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Navigation breadcrumb
                            const Text(
                              'Foundation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Spacing',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Outfit',
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'https://www.unping-ui.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    // Main title and description
                    const Text(
                      'Spacing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                        height: 1.25, // 90/72
                        shadows: [
                          Shadow(
                            color: Colors.white24,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Consistent and well-defined spacing is crucial for creating a visually balanced and user-friendly interface. Our design system includes a comprehensive set of spacing guidelines to ensure consistency and clarity across all user interfaces. These guidelines help maintain a cohesive layout and improve the overall user experience.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        height: 1.5, // 30/20
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Spacing table
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(80), // From Figma design
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
                Expanded(
                  child: ListView(
                    children: _buildSpacingRows(),
                  ),
                ),
              ],
            ),
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
