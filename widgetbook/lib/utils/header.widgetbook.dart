import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

/// A top bar component that contains logo, breadcrumbs, and URL with proper padding.
/// Used as part of the UnpingUiWidgetbookHeader.
class UnpingUiWidgetbookHeaderTopBar extends StatelessWidget {
  /// The navigation breadcrumbs to display (e.g., ["Foundation", "Colors"]).
  /// All items except the last use Medium; the last uses SemiBold.
  final List<String> breadcrumbs;

  /// Optional logo widget to display before the breadcrumbs (36x36 suggested).
  final Widget? logo;

  /// Optional URL displayed on the right.
  final String? url;

  const UnpingUiWidgetbookHeaderTopBar({
    super.key,
    required this.breadcrumbs,
    this.logo = const UnpingUiWidgetbookHeaderLogo(),
    this.url = 'https://www.unping-ui.com',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Flexible(
            child: Row(
              children: [
                if (logo != null) ...[
                  logo!,
                  SizedBox(width: UiSpacing.spacing4), // gap-4
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
                style: UiTextStyles.textXs.copyWith(
                  color: Colors.white, // White #FFFFFF
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
        ],
      );
  }

  Widget _buildBreadcrumbs(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < breadcrumbs.length; i++) {
      widgets.add(
        Flexible(
          child: Text(
            breadcrumbs[i],
            style: UiTextStyles.textSm.copyWith(
              color: Colors.white, // White #FFFFFF
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
      if (i < breadcrumbs.length - 1) {
        widgets.add(SizedBox(width: UiSpacing.spacing2));
        widgets.add(const Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 14,
        ));
        widgets.add(SizedBox(width: UiSpacing.spacing2));
      }
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }
}

/// A header that matches the Figma design: left-aligned logo + breadcrumbs,
/// right-aligned URL. Typography and spacing follow the design tokens.
class UnpingUiWidgetbookHeader extends StatelessWidget {
  /// The navigation breadcrumbs to display (e.g., ["Foundation", "Colors"]).
  /// All items except the last use Medium; the last uses SemiBold.
  final List<String> breadcrumbs;

  /// Optional logo widget to display before the breadcrumbs (36x36 suggested).
  final Widget? logo;

  /// Optional URL displayed on the right.
  final String? url;

  /// Optional background decoration for the container.
  final BoxDecoration? backgroundDecoration;

  /// Optional title to display below the header image with spacing6.
  /// Uses Figma design specifications: Outfit Bold, 72px, white with text shadow.
  final String? title;

  const UnpingUiWidgetbookHeader({
    super.key,
    required this.breadcrumbs,
    this.logo = const UnpingUiWidgetbookHeaderLogo(),
    this.url = 'https://www.unping-ui.com',
    this.backgroundDecoration,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration,
      color: Colors.transparent, // Ensure background is transparent
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnpingUiWidgetbookHeaderTopBar(
            breadcrumbs: breadcrumbs,
            logo: logo,
            url: url,
          ),
          SizedBox(height: UiSpacing.spacing8),
          Image.asset(
            'web/icons/header_presentation.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          if (title != null) ...[
            SizedBox(height: UiSpacing.spacing10),
            _buildTitle(),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title!,
      style: UiTextStyles.displayLgBold.copyWith(
        color: Colors.white,
        letterSpacing: -1.44,
        shadows: [
          Shadow(
            color: Color(0x66FFFFFF), // rgba(255,255,255,0.4)
            blurRadius: 12.111,
            offset: Offset.zero,
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}

/// A default logo widget that can be used with UnpingUiWidgetbookHeader.
class UnpingUiWidgetbookHeaderLogo extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget? child;
  final bool useDefaultLogo;

  const UnpingUiWidgetbookHeaderLogo({
    super.key,
    this.size = 24,
    this.backgroundColor = Colors.white,
    this.child,
    this.useDefaultLogo = true,
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
            blurRadius: 8.111,
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
      child: child ?? (useDefaultLogo ? _buildDefaultLogo() : null),
    );
  }

  Widget _buildDefaultLogo() {
    return Image(
      image: const AssetImage('web/icons/icon_presentation.png'),
      width: size, // 24px for 36px container, scales proportionally
      height: size,
      fit: BoxFit.contain,
    );
  }
}

