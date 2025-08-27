import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Border Radius System',
  type: UiRadius,
  designLink: 'https://www.figma.com/design/unping-ui-radius',
)
Widget buildUiRadiusUseCase(BuildContext context) {
  return Container(
    color: const Color(0xFF2A313C), // Dark background like Figma
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          _HeaderSection(),

          // Radius showcase section
          _RadiusShowcaseSection(),
        ],
      ),
    ),
  );
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF6B9D), // Pink
              Color(0xFF3B82F6), // Blue
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Logo
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Navigation
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
                      'Border Radius',
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

            // Main title
            const Text(
              'Border Radius',
              style: TextStyle(
                color: Colors.white,
                fontSize: 72,
                fontWeight: FontWeight.w700,
                fontFamily: 'Outfit',
                height: 1.25,
                shadows: [
                  Shadow(
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              'Border radius values define the curvature of element corners, creating visual consistency and hierarchy across the design system. Our radius scale provides a comprehensive range from sharp edges to fully rounded elements.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Categories
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: 'Categories:\n\n',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: '1. ',
                  ),
                  TextSpan(
                    text: 'NONE',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ': Sharp corners with no radius (0px).\n',
                  ),
                  TextSpan(
                    text: '2. ',
                  ),
                  TextSpan(
                    text: 'XS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        ' (Extra Small): Subtle rounding for minimal softness (4px).\n',
                  ),
                  TextSpan(
                    text: '3. ',
                  ),
                  TextSpan(
                    text: 'SM',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        ' (Small): Light rounding for gentle corners (8px).\n',
                  ),
                  TextSpan(
                    text: '4. ',
                  ),
                  TextSpan(
                    text: 'MD',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        ' (Medium): Standard rounding for most components (12px).\n',
                  ),
                  TextSpan(
                    text: '5. ',
                  ),
                  TextSpan(
                    text: 'LG',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ' (Large): Prominent rounding for emphasis (16px).\n',
                  ),
                  TextSpan(
                    text: '6. ',
                  ),
                  TextSpan(
                    text: 'XL',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        ' (Extra Large): Strong rounding for standout elements (28px).\n',
                  ),
                  TextSpan(
                    text: '7. ',
                  ),
                  TextSpan(
                    text: 'XXL',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ' (Double Extra Large): Maximum rounding (32px).\n',
                  ),
                  TextSpan(
                    text: '8. ',
                  ),
                  TextSpan(
                    text: 'FULL',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ': Fully rounded for pills and circular elements.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadiusShowcaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(80),
      child: Container(
        width: double.infinity,
        height: 392,
        color: Colors.white,
        padding: const EdgeInsets.all(64),
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
          ],
        ),
      ),
    );
  }
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
          color: const Color(0xFF3B4554), // BG lighter from Figma
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
