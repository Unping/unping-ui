import 'package:flutter/material.dart';
import 'package:unping_ui/src/foundation/unping_text_styles.dart';

/// A description component that displays main content text with categories and usage tips.
/// Follows the same structure pattern as UnpingUiWidgetbookHeader.
class UnpingUiWidgetbookDescription extends StatelessWidget {
  /// The main description text to display.
  final String description;

  /// List of category items to display under "Categories:" heading.
  final List<String> categories;

  /// List of usage tip items to display under "Usage Tips:" heading.
  final List<String> usageTips;

  /// Width factor for the description container (default: 0.6 of screen width).
  final double widthFactor;

  /// Text style for the main description text.
  final TextStyle? descriptionStyle;

  /// Text style for the category and usage tip headings.
  final TextStyle? headingStyle;

  /// Text style for the bullet points.
  final TextStyle? bulletPointStyle;

  const UnpingUiWidgetbookDescription({
    super.key,
    required this.description,
    this.categories = const [],
    this.usageTips = const [],
    this.widthFactor = 0.6,
    this.descriptionStyle,
    this.headingStyle,
    this.bulletPointStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main description text
          Text(
            description,
            style: descriptionStyle ?? _defaultDescriptionStyle,
          ),
          
          // Categories section
          if (categories.isNotEmpty) ...[
            Text(
              'Categories:',
              style: headingStyle ?? _defaultHeadingStyle,
            ),
            const SizedBox(height: 8),
            ...categories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              return _buildBulletPoint('${index + 1}. $category');
            }),
            const SizedBox(height: 20),
          ],
          
          // Usage Tips section
          if (usageTips.isNotEmpty) ...[
            Text(
              'Usage Tips:',
              style: headingStyle ?? _defaultHeadingStyle,
            ),
            const SizedBox(height: 8),
            ...usageTips.map((tip) => _buildBulletPoint('• $tip')),
          ],
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: bulletPointStyle ?? _defaultBulletPointStyle,
      ),
    );
  }

  TextStyle get _defaultDescriptionStyle => UnpingTextStyles.textXs.copyWith(
    color: Colors.white, // White #FFFFFF
  );

  TextStyle get _defaultHeadingStyle => UnpingTextStyles.textXsSemibold.copyWith(
    color: Colors.white, // White #FFFFFF
  );

  TextStyle get _defaultBulletPointStyle => UnpingTextStyles.textXs.copyWith(
    color: Colors.white, // White #FFFFFF
  );
}
