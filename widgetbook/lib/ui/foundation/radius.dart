import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_background.dart';
import '../../widgetbook/unping_ui_widgetbook_header.dart';
import '../../widgetbook/unping_ui_widgetbook_description.dart';

@UseCase(
  name: 'Border Radius System',
  type: UiRadius,
  designLink: 'https://www.figma.com/design/unping-ui-radius',
  path: '[UI]/Foundation',
)
Widget buildUiRadiusUseCase(BuildContext context) {
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
                breadcrumbs: const ['Foundation', 'Border Radius'],
                title: "Border Radius",
              ),
              const SizedBox(height: UiSpacing.spacing4),
              
              // Description section using the reusable component
              UnpingUiWidgetbookDescription(
                description: 'Border radius values define the curvature of element corners, creating visual consistency and hierarchy across the design system. Our radius scale provides a comprehensive range from sharp edges to fully rounded elements.\n\n',
                lists: {
                  'Categories:': [
                    'NONE: Sharp corners with no radius (0px).',
                    'XS (Extra Small): Subtle rounding for minimal softness (4px).',
                    'SM (Small): Light rounding for gentle corners (8px).',
                    'MD (Medium): Standard rounding for most components (12px).',
                    'LG (Large): Prominent rounding for emphasis (16px).',
                    'XL (Extra Large): Strong rounding for standout elements (28px).',
                    'XXL (Double Extra Large): Maximum rounding (32px).',
                    'FULL: Fully rounded for pills and circular elements.',
                  ],
                }
              ),
            ],
          ),
        ),
        
        // Radius showcase section
        Container(
          padding: UiSpacing.allXxl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RadiusCard(name: 'radius-none', radius: UiRadius.none),
              _RadiusCard(name: 'radius-xs', radius: UiRadius.xs),
              _RadiusCard(name: 'radius-sm', radius: UiRadius.sm),
              _RadiusCard(name: 'radius-md', radius: UiRadius.md),
              _RadiusCard(name: 'radius-lg', radius: UiRadius.lg),
              _RadiusCard(name: 'radius-xl', radius: UiRadius.xl),
              _RadiusCard(name: 'radius-xxl', radius: UiRadius.xxl),
              _RadiusCard(name: 'radius-full', radius: UiRadius.full),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RadiusCard extends StatelessWidget {
  const _RadiusCard({
    required this.name,
    required this.radius,
  });

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 240,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF3B4554),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFD0D5DD),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}