// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('AvatarGroup', () {
    Widget _wrap(Widget child) => Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        );

    BaseAvatar _avatar(String initials) => BaseAvatar(
          initials: initials,
          backgroundColor: UiColors.neutral500,
          foregroundColor: UiColors.onPrimary,
        );

    testWidgets('renders nothing when empty', (tester) async {
      await tester.pumpWidget(_wrap(AvatarGroup(avatars: const [])));
      expect(find.byType(AvatarGroup), findsOneWidget);
      // SizedBox.shrink is returned, so no children
    });

    testWidgets('shows up to maxVisible avatars and +N overflow', (
      tester,
    ) async {
      final avatars = [
        _avatar('AA'),
        _avatar('BB'),
        _avatar('CC'),
        _avatar('DD'),
        _avatar('EE'),
      ];

      await tester.pumpWidget(
        _wrap(
          AvatarGroup(
            avatars: avatars,
            maxVisible: 3,
            size: AvatarSize.md,
          ),
        ),
      );

      // 3 visible + 1 more indicator
      expect(find.byType(BaseAvatar), findsNWidgets(4));
      expect(find.text('+2'), findsOneWidget);
    });

    testWidgets('applies spacing overlap and border', (tester) async {
      final avatars = [
        _avatar('AA'),
        _avatar('BB'),
        _avatar('CC'),
      ];

      await tester.pumpWidget(
        _wrap(
          AvatarGroup(
            avatars: avatars,
            spacing: -6,
            borderColor: UiColors.background,
            borderWidth: 2,
          ),
        ),
      );

      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('adds semantics when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AvatarGroup(
            avatars: [_avatar('AA'), _avatar('BB')],
            semanticsLabel: 'Team avatars',
          ),
        ),
      );

      final semanticsWidget =
          tester.widgetList(find.byType(Semantics)).first as Semantics;
      expect(semanticsWidget.properties.label, 'Team avatars');
    });
  });
}
