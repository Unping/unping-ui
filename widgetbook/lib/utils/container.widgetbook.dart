import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

import 'background.widgetbook.dart';
import 'header.widgetbook.dart';

/// A reusable container that wraps widgetbook components with the standard
/// UnpingUI background pattern and optional header.
class UnpingUIContainer extends StatelessWidget {
  /// The child widget to display within the container.
  final Widget child;

  /// The navigation breadcrumbs to display in the header (e.g., ["Components", "Button"]).
  /// If null, no header will be displayed.
  final List<String>? breadcrumbs;

  /// Optional logo widget to display before the breadcrumbs (36x36 suggested).
  final Widget? logo;

  /// Optional URL displayed on the right side of the header.
  final String? url;

  /// Whether to show the header. Defaults to true if breadcrumbs are provided.
  final bool showHeader;

  const UnpingUIContainer({
    super.key,
    required this.child,
    this.breadcrumbs,
    this.logo = const UnpingUiWidgetbookHeaderLogo(),
    this.url = 'https://www.unping-ui.com',
    this.showHeader = true,
  });

  /// Creates a container with the standard Components/[componentName] breadcrumbs.
  const UnpingUIContainer.component({
    super.key,
    required this.child,
    required String componentName,
    this.logo = const UnpingUiWidgetbookHeaderLogo(),
    this.url = 'https://www.unping-ui.com',
    this.showHeader = true,
  }) : breadcrumbs = const ['Components'];

  @override
  Widget build(BuildContext context) {
    return UnpingUIWidgetbookBackground(
      child: Container(
        padding: UiSpacing.allXxl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader && breadcrumbs != null) ...[
              UnpingUiWidgetbookHeaderTopBar(
                breadcrumbs: breadcrumbs!,
                logo: logo,
                url: url,
              ),
              SizedBox(height: UiSpacing.spacing12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

/// A simple container with just the background pattern and padding, no header.
class UnpingUISimpleContainer extends StatelessWidget {
  /// The child widget to display within the container.
  final Widget child;

  const UnpingUISimpleContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return UnpingUIWidgetbookBackground(
      child: Container(
        padding: UiSpacing.allXxl,
        child: child,
      ),
    );
  }
}
