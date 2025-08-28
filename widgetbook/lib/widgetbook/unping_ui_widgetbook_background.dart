import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

class UnpingUIWidgetbookBackground extends StatelessWidget {
  const UnpingUIWidgetbookBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePatternPainter(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: child,
      ),
    );
  }
}

class RectanglePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background color (slightly brighter than the original)
    final backgroundPaint = Paint()
      ..color = const Color(0xFF2B313B); // Brighter than 0xFF2A313C

    // Fill the entire canvas with background
    final layerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(layerRect, backgroundPaint);

    // Pattern color (slightly brighter than background)
    final patternPaint = Paint()
      ..color = const Color(0xFF303440); // Brighter than background

    // Pattern specifications
    const dotSize = 2.0;
    const spacing = 9.0;
    const totalSpacing = dotSize + spacing; // 11 pixels between dot centers

    // Draw pattern to an offscreen layer so we can mask it with a fade
    canvas.saveLayer(layerRect, Paint());

    // Calculate how many dots we need in each direction
    final dotsX = (size.width / totalSpacing).ceil() + 1;
    final dotsY = (size.height / totalSpacing).ceil() + 1;

    // Draw the rectangle pattern
    for (int x = 0; x < dotsX; x++) {
      for (int y = 0; y < dotsY; y++) {
        final left = x * totalSpacing;
        final top = y * totalSpacing;

        // Draw rectangle dot
        canvas.drawRect(
          Rect.fromLTWH(left, top, dotSize, dotSize),
          patternPaint,
        );
      }
    }

    // Create a vertical alpha mask to fade the pattern in over the first 300px
    const fadeInHeight = 300.0;
    final fadeStop = size.height == 0
        ? 0.0
        : (fadeInHeight / size.height).clamp(0.0, 1.0);

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [
        Color(0x00000000), // transparent at the top
        Color(0xFFFFFFFF), // fully visible by fadeStop
        Color(0xFFFFFFFF), // remain visible afterwards
      ],
      stops: [
        0.0,
        fadeStop.toDouble(),
        1.0,
      ],
    );

    final maskPaint = Paint()
      ..shader = gradient.createShader(layerRect)
      ..blendMode = BlendMode.dstIn;

    // Apply the mask over the pattern layer
    canvas.drawRect(layerRect, maskPaint);

    // Restore to composite the masked pattern onto the background
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UnpingUIWidgetbookGradientHeader extends StatelessWidget {
  const UnpingUIWidgetbookGradientHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.description,
    this.categories,
    this.usageTips,
  });

  final String title;
  final String subtitle;
  final String? description;
  final List<String>? categories;
  final List<String>? usageTips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UiSpacing.allXxl,
      child: Container(
        padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
        decoration: BoxDecoration(
          borderRadius: UiRadius.allXl,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE879F9),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumb(subtitle),
            SizedBox(height: UiSpacing.spacing12),
            _buildTitle(title),
            SizedBox(height: UiSpacing.spacing5),
            if (description != null) ...[
              _buildDescription(description!),
              SizedBox(height: UiSpacing.spacing5),
            ],
            if (categories != null && categories!.isNotEmpty) ...[
              _buildSection('Categories:', categories!),
              SizedBox(height: UiSpacing.spacing5),
            ],
            if (usageTips != null && usageTips!.isNotEmpty) ...[
              _buildSection('Usage Tips:', usageTips!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb(String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
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
            UiSpacing.horizontalGapM,
            Text(
              'Foundation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 32 / 24,
              ),
            ),
            UiSpacing.horizontalGapSm,
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
            UiSpacing.horizontalGapSm,
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 32 / 24,
              ),
            ),
          ],
        ),
        Text(
          'https://www.unping-ui.com',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 30 / 20,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 72,
        fontWeight: FontWeight.bold,
        height: 90 / 72,
        letterSpacing: -1.44,
        shadows: [
          Shadow(
            color: Colors.white.withOpacity(0.4),
            blurRadius: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          height: 30 / 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            height: 30 / 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: UiSpacing.spacing2),
        ...items.map((item) => _buildBulletPoint(item)),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          height: 30 / 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
