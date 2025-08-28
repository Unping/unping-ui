import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

/// A description component that displays main content text with multiple lists of items.
/// Each list can have its own heading and bullet point format.
class UnpingUiWidgetbookDescription extends StatelessWidget {
  /// The main description text to display.
  final String description;

  /// Map of list items with their headings. Key is the heading text, value is the list of items.
  /// Example: {'Categories:': ['Item 1', 'Item 2'], 'Usage Tips:': ['Tip 1', 'Tip 2']}
  final Map<String, List<String>> lists;

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
    this.lists = const {},
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
          
          // Dynamic lists sections
          ...lists.entries.map((entry) {
            final heading = entry.key;
            final items = entry.value;
            
            if (items.isEmpty) return const SizedBox.shrink();
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: UiSpacing.spacing5),
                Text(
                  heading,
                  style: headingStyle ?? _defaultHeadingStyle,
                ),
                const SizedBox(height: UiSpacing.spacing2),
                ...items.asMap().entries.map((itemEntry) {
                  final index = itemEntry.key;
                  final item = itemEntry.value;
                  // Use numbered bullets for most lists, but use bullet points for items starting with bullet
                  final bulletText = item.startsWith('•') 
                      ? item 
                      : '${index + 1}. $item';
                  return _buildBulletPoint(bulletText);
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: UiSpacing.spacing1),
      child: Text(
        text,
        style: bulletPointStyle ?? _defaultBulletPointStyle,
      ),
    );
  }

  TextStyle get _defaultDescriptionStyle => UiTextStyles.textXs.copyWith(
    color: Colors.white, // White #FFFFFF
  );

  TextStyle get _defaultHeadingStyle => UiTextStyles.textXsSemibold.copyWith(
    color: Colors.white, // White #FFFFFF
  );

  TextStyle get _defaultBulletPointStyle => UiTextStyles.textXs.copyWith(
    color: Colors.white, // White #FFFFFF
  );
}
