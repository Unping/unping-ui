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
      child: child,
    );
  }
}

class RectanglePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background color (slightly brighter than the original)
    final backgroundPaint = Paint()
      ..color = const Color(0xFF3A424F); // Brighter than 0xFF2A313C

    // Fill the entire canvas with background
    final layerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(layerRect, backgroundPaint);

    // Pattern color (slightly brighter than background)
    final patternPaint = Paint()
      ..color = const Color(0xFF4A5568); // Brighter than background

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
      padding: UnpingSpacing.allXxl,
      child: Container(
        padding: const EdgeInsets.fromLTRB(48, 48, 48, 64),
        decoration: BoxDecoration(
          borderRadius: UnpingRadius.allXl,
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
            const SizedBox(height: 48),
            _buildTitle(title),
            const SizedBox(height: 20),
            if (description != null) ...[
              _buildDescription(description!),
              const SizedBox(height: 20),
            ],
            if (categories != null && categories!.isNotEmpty) ...[
              _buildSection('Categories:', categories!),
              const SizedBox(height: 20),
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
            UnpingSpacing.horizontalGapM,
            Text(
              'Foundation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 32 / 24,
              ),
            ),
            UnpingSpacing.horizontalGapSm,
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
            UnpingSpacing.horizontalGapSm,
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
        const SizedBox(height: 8),
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
