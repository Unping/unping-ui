import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:unping_ui/src/foundation/unping_text_styles.dart';

/// A header that matches the Figma design: left-aligned logo + breadcrumbs,
/// right-aligned URL. Typography and spacing follow the design tokens.
class BaseHeader extends StatelessWidget {
  /// The navigation breadcrumbs to display (e.g., ["Foundation", "Colors"]).
  /// All items except the last use Medium; the last uses SemiBold.
  final List<String> breadcrumbs;

  /// Optional logo widget to display before the breadcrumbs (36x36 suggested).
  final Widget? logo;

  /// Optional URL displayed on the right.
  final String? url;

  /// Optional background decoration for the container.
  final BoxDecoration? backgroundDecoration;

  const BaseHeader({
    super.key,
    required this.breadcrumbs,
    this.logo,
    this.url,
    this.backgroundDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration,
      color: Colors.transparent, // Ensure background is transparent
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                if (logo != null) ...[
                  logo!,
                  const SizedBox(width: 16), // gap-4
                ],
                Flexible(
                  child: _buildBreadcrumbs(context),
                ),
              ],
            ),
          ),
          if (url != null)
            Flexible(
              child: Text(
                url!,
                style: UnpingTextStyles.textXlMedium.copyWith(
                  color: Colors.white, // White #FFFFFF
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < breadcrumbs.length; i++) ...[
          Flexible(
            child: Text(
              breadcrumbs[i],
              style: (i == breadcrumbs.length - 1
                      ? UnpingTextStyles.displayXsSemibold
                      : UnpingTextStyles.displayXsMedium)
                  .copyWith(
                color: Colors.white, // White #FFFFFF
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (i < breadcrumbs.length - 1) ...[
            const SizedBox(width: 8), // gap-2
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8), // gap-2
          ],
        ],
      ],
    );
  }
}

/// A default logo widget that can be used with BaseHeader.
class DefaultLogo extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget? child;

  const DefaultLogo({
    super.key,
    this.size = 36,
    this.backgroundColor = Colors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(27), // rounded-[27px]
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            blurRadius: 12.111,
            spreadRadius: 0,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: const Color(0xFF101828).withOpacity(0.1),
            blurRadius: 3.375,
            offset: const Offset(0, 1.125),
          ),
          BoxShadow(
            color: const Color(0xFF101828).withOpacity(0.06),
            blurRadius: 2.25,
            offset: const Offset(0, 1.125),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

// Widgetbook use cases
@widgetbook.UseCase(name: 'Default', type: BaseHeader)
Widget buildBaseHeaderDefault(BuildContext context) {
  return Container(
    color: Colors.grey[900],
    padding: const EdgeInsets.all(20),
    child: const BaseHeader(
      breadcrumbs: ['Foundation', 'Colors'],
      url: 'https://www.unping-ui.com',
    ),
  );
}

@widgetbook.UseCase(name: 'With Logo', type: BaseHeader)
Widget buildBaseHeaderWithLogo(BuildContext context) {
  return Container(
    color: Colors.grey[900],
    padding: const EdgeInsets.all(20),
    child: BaseHeader(
      breadcrumbs: const ['Components', 'Buttons'],
      url: 'https://www.unping-ui.com',
      logo: const DefaultLogo(
        child: Icon(
          Icons.widgets,
          color: Colors.blue,
          size: 20,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Background', type: BaseHeader)
Widget buildBaseHeaderCustomBackground(BuildContext context) {
  return Container(
    color: Colors.grey[900],
    padding: const EdgeInsets.all(20),
    child: BaseHeader(
      breadcrumbs: const ['Design System', 'Typography'],
      url: 'https://www.unping-ui.com',
      backgroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[800]!,
            Colors.purple[800]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
