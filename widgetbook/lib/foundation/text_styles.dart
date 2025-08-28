import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/unping_ui_widgetbook_background.dart';
import 'package:widgetbook_workspace/utils/unping_ui_widgetbook_description.dart';
import 'package:widgetbook_workspace/utils/unping_ui_widgetbook_header.dart';

@UseCase(
  name: 'Typography System',
  type: UiTextStyles,
  designLink: 'https://www.figma.com/design/unping-ui-typography',
  path: 'Foundation',
)
Widget buildUiTextStylesUseCase(BuildContext context) {
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
                  breadcrumbs: const ['Foundation', 'Typography'],
                  title: "Typography",
                ),
                const SizedBox(height: UiSpacing.spacing4),
                
                // Description section using the reusable component
                UnpingUiWidgetbookDescription(
                  description: 'Our typography is designed to be clean, legible, and versatile across all screen sizes and devices. We have carefully selected a range of typographic styles to ensure consistency and readability in various contexts. Our font choices are optimized for both digital and print media, making sure that our text is always readable and well-emphasized.\n\n Font Family: Outfit',
                ),
              ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Typeface showcase
              _TypefaceShowcase(),
              
              const SizedBox(height: 64),
              
              // Typography scale sections
              _TypeScaleSection(
                title: 'Display 2xl',
                subtitle: 'Font size: 72px / 4.5rem | Line height: 90px / 5.625rem | Tracking: -2%',
                styles: [
                  ('Display 2xl', 'Regular', UiTextStyles.display2xl),
                  ('Display 2xl', 'Medium', UiTextStyles.display2xlMedium),
                  ('Display 2xl', 'Semibold', UiTextStyles.display2xlSemibold),
                  ('Display 2xl', 'Bold', UiTextStyles.display2xlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display xl',
                subtitle: 'Font size: 60px / 3.75rem | Line height: 72px / 4.625rem | Tracking: -2%',
                styles: [
                  ('Display xl', 'Regular', UiTextStyles.displayXl),
                  ('Display xl', 'Medium', UiTextStyles.displayXlMedium),
                  ('Display xl', 'Semibold', UiTextStyles.displayXlSemibold),
                  ('Display xl', 'Bold', UiTextStyles.displayXlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display lg',
                subtitle: 'Font size: 48px / 3rem | Line height: 60px / 3.75rem | Tracking: -2%',
                styles: [
                  ('Display lg', 'Regular', UiTextStyles.displayLg),
                  ('Display lg', 'Medium', UiTextStyles.displayLgMedium),
                  ('Display lg', 'Semibold', UiTextStyles.displayLgSemibold),
                  ('Display lg', 'Bold', UiTextStyles.displayLgBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display md',
                subtitle: 'Font size: 36px / 2.25rem | Line height: 44px / 2.75rem | Tracking: -2%',
                styles: [
                  ('Display md', 'Regular', UiTextStyles.displayMd),
                  ('Display md', 'Medium', UiTextStyles.displayMdMedium),
                  ('Display md', 'Semibold', UiTextStyles.displayMdSemibold),
                  ('Display md', 'Bold', UiTextStyles.displayMdBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display sm',
                subtitle: 'Font size: 30px / 1.875rem | Line height: 38px / 2.375rem',
                styles: [
                  ('Display sm', 'Regular', UiTextStyles.displaySm),
                  ('Display sm', 'Medium', UiTextStyles.displaySmMedium),
                  ('Display sm', 'Semibold', UiTextStyles.displaySmSemibold),
                  ('Display sm', 'Bold', UiTextStyles.displaySmBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display xs',
                subtitle: 'Font size: 24px / 1.5rem | Line height: 32px / 2rem',
                styles: [
                  ('Display xs', 'Regular', UiTextStyles.displayXs),
                  ('Display xs', 'Medium', UiTextStyles.displayXsMedium),
                  ('Display xs', 'Semibold', UiTextStyles.displayXsSemibold),
                  ('Display xs', 'Bold', UiTextStyles.displayXsBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text xl',
                subtitle: 'Font size: 20px / 1.25rem | Line height: 30px / 1.875rem',
                styles: [
                  ('Text xl', 'Regular', UiTextStyles.textXl),
                  ('Text xl', 'Medium', UiTextStyles.textXlMedium),
                  ('Text xl', 'Semibold', UiTextStyles.textXlSemibold),
                  ('Text xl', 'Bold', UiTextStyles.textXlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text lg',
                subtitle: 'Font size: 18px / 1.125rem | Line height: 28px / 1.75rem',
                styles: [
                  ('Text lg', 'Regular', UiTextStyles.textLg),
                  ('Text lg', 'Medium', UiTextStyles.textLgMedium),
                  ('Text lg', 'Semibold', UiTextStyles.textLgSemibold),
                  ('Text lg', 'Bold', UiTextStyles.textLgBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text md',
                subtitle: 'Font size: 16px / 1rem | Line height: 24px / 1.5rem',
                styles: [
                  ('Text md', 'Regular', UiTextStyles.textMd),
                  ('Text md', 'Medium', UiTextStyles.textMdMedium),
                  ('Text md', 'Semibold', UiTextStyles.textMdSemibold),
                  ('Text md', 'Bold', UiTextStyles.textMdBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text small',
                subtitle: 'Font size: 14px / 0.875rem | Line height: 20px / 1.25rem',
                styles: [
                  ('Text sm', 'Regular', UiTextStyles.textSm),
                  ('Text sm', 'Medium', UiTextStyles.textSmMedium),
                  ('Text sm', 'Semibold', UiTextStyles.textSmSemibold),
                  ('Text sm', 'Bold', UiTextStyles.textSmBold),
                ],
              ),
              
              // Text sm underline variant
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text sm',
                      style: UiTextStyles.textSm.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Regular Underline',
                      style: UiTextStyles.textSm.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              
              _TypeScaleSection(
                title: 'Text xs',
                subtitle: 'Font size: 12px / 0.75rem | Line height: 18px / 1.125rem',
                styles: [
                  ('Text xs', 'Regular', UiTextStyles.textXs),
                  ('Text xs', 'Medium', UiTextStyles.textXsMedium),
                  ('Text xs', 'Semibold', UiTextStyles.textXsSemibold),
                  ('Text xs', 'Bold', UiTextStyles.textXsBold),
                ],
              ),
              
              const SizedBox(height: 225), // Bottom padding
            ],
          ),
        ),
      ],
      ),
  );
}

// Typeface showcase widget
class _TypefaceShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Outfit',
                style: UiTextStyles.displayLg.copyWith(
                  color: Colors.white,
                  letterSpacing: -0.96,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ag',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 112,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),
          Text(
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n'
            'abcdefghijklmnopqrstuvwxyz\n'
            '0123456789 !@#\$%^&*()',
            style: UiTextStyles.displayLg.copyWith(
              color: Colors.white,
              letterSpacing: -0.96,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

// Type scale section widget
class _TypeScaleSection extends StatelessWidget {
  const _TypeScaleSection({
    required this.title,
    required this.subtitle,
    required this.styles,
  });

  final String title;
  final String subtitle;
  final List<(String, String, TextStyle)> styles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2240,
      margin: const EdgeInsets.only(bottom: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and specs
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: UiTextStyles.textMd.copyWith(
                      color: const Color(0xFF667085),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: UiTextStyles.textMd.copyWith(
                      color: const Color(0xFF667085),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFF667085).withValues(alpha: 0.3),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Style examples row
          Row(
            children: styles.map((style) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style.$1,
                      style: style.$3.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: style.$3.fontSize! * 1.0),
                    Text(
                      style.$2,
                      style: style.$3.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
