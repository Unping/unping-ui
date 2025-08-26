import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_background.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_description.dart';
import 'package:widgetbook_workspace/widgetbook/unping_ui_widgetbook_header.dart';

@UseCase(
  name: 'Typography System',
  type: UnpingTextStyles,
  designLink: 'https://www.figma.com/design/unping-ui-typography',
)
Widget buildUnpingTextStylesUseCase(BuildContext context) {
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
                  breadcrumbs: const ['Foundation', 'Typography'],
                  title: "Typography",
                ),
                const SizedBox(height: UnpingSpacing.spacing4),
                
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
                  ('Display 2xl', 'Regular', UnpingTextStyles.display2xl),
                  ('Display 2xl', 'Medium', UnpingTextStyles.display2xlMedium),
                  ('Display 2xl', 'Semibold', UnpingTextStyles.display2xlSemibold),
                  ('Display 2xl', 'Bold', UnpingTextStyles.display2xlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display xl',
                subtitle: 'Font size: 60px / 3.75rem | Line height: 72px / 4.625rem | Tracking: -2%',
                styles: [
                  ('Display xl', 'Regular', UnpingTextStyles.displayXl),
                  ('Display xl', 'Medium', UnpingTextStyles.displayXlMedium),
                  ('Display xl', 'Semibold', UnpingTextStyles.displayXlSemibold),
                  ('Display xl', 'Bold', UnpingTextStyles.displayXlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display lg',
                subtitle: 'Font size: 48px / 3rem | Line height: 60px / 3.75rem | Tracking: -2%',
                styles: [
                  ('Display lg', 'Regular', UnpingTextStyles.displayLg),
                  ('Display lg', 'Medium', UnpingTextStyles.displayLgMedium),
                  ('Display lg', 'Semibold', UnpingTextStyles.displayLgSemibold),
                  ('Display lg', 'Bold', UnpingTextStyles.displayLgBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display md',
                subtitle: 'Font size: 36px / 2.25rem | Line height: 44px / 2.75rem | Tracking: -2%',
                styles: [
                  ('Display md', 'Regular', UnpingTextStyles.displayMd),
                  ('Display md', 'Medium', UnpingTextStyles.displayMdMedium),
                  ('Display md', 'Semibold', UnpingTextStyles.displayMdSemibold),
                  ('Display md', 'Bold', UnpingTextStyles.displayMdBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display sm',
                subtitle: 'Font size: 30px / 1.875rem | Line height: 38px / 2.375rem',
                styles: [
                  ('Display sm', 'Regular', UnpingTextStyles.displaySm),
                  ('Display sm', 'Medium', UnpingTextStyles.displaySmMedium),
                  ('Display sm', 'Semibold', UnpingTextStyles.displaySmSemibold),
                  ('Display sm', 'Bold', UnpingTextStyles.displaySmBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Display xs',
                subtitle: 'Font size: 24px / 1.5rem | Line height: 32px / 2rem',
                styles: [
                  ('Display xs', 'Regular', UnpingTextStyles.displayXs),
                  ('Display xs', 'Medium', UnpingTextStyles.displayXsMedium),
                  ('Display xs', 'Semibold', UnpingTextStyles.displayXsSemibold),
                  ('Display xs', 'Bold', UnpingTextStyles.displayXsBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text xl',
                subtitle: 'Font size: 20px / 1.25rem | Line height: 30px / 1.875rem',
                styles: [
                  ('Text xl', 'Regular', UnpingTextStyles.textXl),
                  ('Text xl', 'Medium', UnpingTextStyles.textXlMedium),
                  ('Text xl', 'Semibold', UnpingTextStyles.textXlSemibold),
                  ('Text xl', 'Bold', UnpingTextStyles.textXlBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text lg',
                subtitle: 'Font size: 18px / 1.125rem | Line height: 28px / 1.75rem',
                styles: [
                  ('Text lg', 'Regular', UnpingTextStyles.textLg),
                  ('Text lg', 'Medium', UnpingTextStyles.textLgMedium),
                  ('Text lg', 'Semibold', UnpingTextStyles.textLgSemibold),
                  ('Text lg', 'Bold', UnpingTextStyles.textLgBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text md',
                subtitle: 'Font size: 16px / 1rem | Line height: 24px / 1.5rem',
                styles: [
                  ('Text md', 'Regular', UnpingTextStyles.textMd),
                  ('Text md', 'Medium', UnpingTextStyles.textMdMedium),
                  ('Text md', 'Semibold', UnpingTextStyles.textMdSemibold),
                  ('Text md', 'Bold', UnpingTextStyles.textMdBold),
                ],
              ),
              
              _TypeScaleSection(
                title: 'Text small',
                subtitle: 'Font size: 14px / 0.875rem | Line height: 20px / 1.25rem',
                styles: [
                  ('Text sm', 'Regular', UnpingTextStyles.textSm),
                  ('Text sm', 'Medium', UnpingTextStyles.textSmMedium),
                  ('Text sm', 'Semibold', UnpingTextStyles.textSmSemibold),
                  ('Text sm', 'Bold', UnpingTextStyles.textSmBold),
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
                      style: UnpingTextStyles.textSm.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Regular Underline',
                      style: UnpingTextStyles.textSm.copyWith(
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
                  ('Text xs', 'Regular', UnpingTextStyles.textXs),
                  ('Text xs', 'Medium', UnpingTextStyles.textXsMedium),
                  ('Text xs', 'Semibold', UnpingTextStyles.textXsSemibold),
                  ('Text xs', 'Bold', UnpingTextStyles.textXsBold),
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
                style: UnpingTextStyles.displayLg.copyWith(
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
            style: UnpingTextStyles.displayLg.copyWith(
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
                    style: UnpingTextStyles.textMd.copyWith(
                      color: const Color(0xFF667085),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: UnpingTextStyles.textMd.copyWith(
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
