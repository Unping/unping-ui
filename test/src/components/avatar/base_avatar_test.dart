import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('BaseAvatar', () {
    Widget _wrap(Widget child) => Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        );

    testWidgets('renders initials avatar for all sizes', (tester) async {
      for (final size in AvatarSize.values) {
        await tester.pumpWidget(
          _wrap(
            BaseAvatar(
              initials: 'JD',
              size: size,
              shape: AvatarShape.circle,
              backgroundColor: UiColors.neutral500,
              foregroundColor: UiColors.onPrimary,
            ),
          ),
        );

        expect(find.text('JD'), findsOneWidget);
        // Container should have tight width/height matching AvatarSizeHelper
        final container =
            tester.widget<Container>(find.byType(Container).first);
        final c = container.constraints!;
        final expected = AvatarSizeHelper.getSize(size);
        expect(c.hasTightWidth && c.hasTightHeight, isTrue);
        expect(c.maxWidth, expected);
        expect(c.maxHeight, expected);
      }
    });

    testWidgets('renders icon avatar', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BaseAvatar(
            icon: IconData(0xe047, fontFamily: 'MaterialIcons'),
            size: AvatarSize.md,
            backgroundColor: UiColors.neutral300,
            foregroundColor: UiColors.neutral600,
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    // testWidgets('renders image avatar and shows placeholder while loading', (
    //   tester,
    // ) async {
    //   await tester.runAsync(() async {
    //     await mockNetworkImages(
    //       () async {
    //         await tester.pumpWidget(
    //           _wrap(
    //             BaseAvatar(
    //               imageUrl: 'https://placehold.co/600x400.png',
    //               size: AvatarSize.md,
    //               backgroundColor: UiColors.neutral300,
    //               foregroundColor: UiColors.neutral600,
    //             ),
    //           ),
    //         );
    //       },
    //       loadingDelay: const Duration(milliseconds: 100),
    //       chunkCount: 30,
    //     );
    //     // await tester.pumpAndSettle(
    //     //   Duration(milliseconds: 1000),
    //     // );
    //     await Future.delayed(const Duration(milliseconds: 1000));
    //     await tester.pump(null, EnginePhase.build);
    //     // await tester.pump(null, EnginePhase.build);
    //     // await tester.pump(null, EnginePhase.build);
    //     // await tester.pump(null, EnginePhase.build);

    //     expect(find.byType(ShaderMask), findsOneWidget);
    //   });

    //   // Placeholder should be visible during loading
    //   // }, additionalTime: Duration(seconds: 3));
    // });

    testWidgets(
      'falls back when image errors',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            BaseAvatar(
              imageUrl: 'bad://url',
              size: AvatarSize.md,
              backgroundColor: UiColors.neutral300,
              foregroundColor: UiColors.neutral600,
              fallback: Text('FB'),
            ),
          ),
        );

        // Give time for image load to fail and errorBuilder to render
        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(find.text('FB'), findsOneWidget);
      },
    );

    testWidgets('applies badge and positions it', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BaseAvatar(
            initials: 'AB',
            size: AvatarSize.md,
            backgroundColor: UiColors.neutral500,
            foregroundColor: UiColors.onPrimary,
            badge: AvatarBadge.status(status: UserStatus.online),
            badgePosition: BadgePosition.bottomRight,
          ),
        ),
      );

      expect(find.byType(AvatarBadge), findsOneWidget);
    });

    testWidgets('adds semantics label automatically', (tester) async {
      await tester.pumpWidget(
        _wrap(
          BaseAvatar(
            initials: 'XY',
            size: AvatarSize.sm,
            backgroundColor: UiColors.neutral500,
            foregroundColor: UiColors.onPrimary,
          ),
        ),
      );

      final semantics = tester.widget<Semantics>(find.byType(Semantics).first);
      expect(semantics.properties.label, isNotEmpty);
    });
  });
}
