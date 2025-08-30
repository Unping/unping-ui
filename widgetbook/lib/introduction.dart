import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:unping_ui/unping_ui.dart';
import 'utils/background.widgetbook.dart';
import 'utils/header.widgetbook.dart';
import 'utils/description.widgetbook.dart';

class IntroductionWidgetbook extends StatefulWidget {
  const IntroductionWidgetbook({
    super.key, 
    required this.readme,
    this.title = 'Unping UI',
  });
  final String readme;
  final String title;

  @override
  State<IntroductionWidgetbook> createState() => _IntroductionWidgetbookState();
}

class _IntroductionWidgetbookState extends State<IntroductionWidgetbook> {
  late String readme;
  @override
  void initState() {
    super.initState();
    readme = widget.readme
        .replaceAll('# Unping UI', '') // Remove main title
        .replaceAll(RegExp(r'\[!\[.*?\]\[.*?\]\]\[.*?\]'), '') // Remove badge links like [![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
        .replaceAll(RegExp(r'\[.*?_badge\]:.*'), '') // Remove badge reference definitions
        .replaceAll(RegExp(r'\[.*?_link\]:.*'), '') // Remove link reference definitions
        .replaceAll(RegExp(r'\n\s*\n\s*\n'), '\n\n') // Clean up excessive newlines
        .trim();
  }

  @override
  Widget build(BuildContext context) {
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
                  breadcrumbs: const ['Introduction'],
                  title: widget.title,
                ),
                const SizedBox(height: UiSpacing.spacing4),
                
                // Description section using the reusable component
                UnpingUiWidgetbookDescription(
                  description: 'Welcome to unping_ui, a comprehensive Flutter widget library designed to accelerate your development process. Our collection of carefully crafted components follows modern design principles while maintaining consistency and accessibility across all implementations.\n\n',
                  lists: {
                    'Key Features:': [
                      'Copy & paste ready widgets for rapid development',
                      'Customizable and extendable components',
                      'Comprehensive test coverage for reliability',
                      'Modern design system with consistent styling',
                      'Full accessibility support',
                    ],
                    'Getting Started:': [
                      'Browse components in the left sidebar',
                      'View live examples and interact with knobs',
                      'Copy code directly into your Flutter project',
                      'Customize components to match your brand',
                    ],
                  }
                ),
              ],
            ),
          ),
          
          // Content section with markdown
          Container(
            padding: UiSpacing.allXxl,
            child: MarkdownWidget(
              data: readme,
              shrinkWrap: true,
              config: MarkdownConfig(
                configs: [
                  PConfig(
                    textStyle: UiTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  LinkConfig(
                    style: UiTextStyles.bodyMedium.copyWith(
                      color: UiColors.primary500,
                      decoration: TextDecoration.underline,
                    ),
                    onTap: (url) {
                      try {
                        final uri = Uri.tryParse(url);
                        if (uri != null && uri.isAbsolute) {
                          launchUrl(uri);
                        }
                      } catch (e) {
                        debugPrint('Failed to launch URL: $url');
                      }
                    },
                  ),
                  CodeConfig(
                    style: GoogleFonts.courierPrime(
                      color: UiColors.neutral900,
                      backgroundColor: UiColors.neutral200,
                    ),
                  ),
                  PreConfig(
                    decoration: BoxDecoration(
                      color: UiColors.neutral900,
                      borderRadius: UiRadius.allSm,
                    ),
                    textStyle: GoogleFonts.courierPrime(
                      color: UiColors.neutral100,
                    ),
                    wrapper: (child, _, language) => 
                        _CodeWrapperWidget(child, language),
                  ),
                  H1Config(
                    style: UiTextStyles.headlineLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  H2Config(
                    style: UiTextStyles.headlineMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  H3Config(
                    style: UiTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
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
}

class _CodeWrapperWidget extends StatelessWidget {
  const _CodeWrapperWidget(this.child, this.language);
  final Widget child;
  final String? language;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTextStyle(
          style: GoogleFonts.courierPrime(color: UiColors.neutral100),
          child: child,
        ),
        if (language != null && language!.isNotEmpty)
          Positioned(
            top: UiSpacing.xs,
            right: 0,
            child: SelectionContainer.disabled(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: UiSpacing.xxs,
                  horizontal: UiSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: UiColors.neutral700,
                  borderRadius: UiRadius.allSm,
                ),
                child: Text(
                  language!,
                  style: UiTextStyles.textXs.copyWith(
                    color: UiColors.neutral100,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}