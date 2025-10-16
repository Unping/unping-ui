import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Avatars', () {
    testWidgets('image avatar renders with fallback', (tester) async {
      final widget = Avatars.image(
        imageUrl: 'https://invalid_url',
        size: AvatarSize.lg,
        fallback: Avatars.initials(name: 'John Doe', size: AvatarSize.lg),
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      // await tester.pumpAndSettle(Duration(seconds: 30));
      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(BaseAvatar), findsOneWidget);
    });

    testWidgets('initials avatar renders with auto color', (tester) async {
      final widget = Avatars.initials(name: 'Jane Smith', size: AvatarSize.md);
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(BaseAvatar), findsOneWidget);
      expect(find.text('JS'), findsOneWidget);
    });

    testWidgets('icon avatar renders with icon', (tester) async {
      final widget = Avatars.icon(icon: Icons.person, size: AvatarSize.sm);
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(BaseAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('avatar group renders stacked avatars', (tester) async {
      final widget = Avatars.group(
        avatars: [
          Avatars.initials(name: 'Alice'),
          Avatars.initials(name: 'Bob'),
          Avatars.initials(name: 'Carol'),
        ],
        maxVisible: 2,
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(AvatarGroup), findsOneWidget);
    });

    testWidgets('image avatar applies custom border and radius',
        (tester) async {
      final widget = Avatars.image(
        imageUrl: 'invalid_url',
        size: AvatarSize.md,
        borderColor: Colors.red,
        borderWidth: 3.0,
        shape: AvatarShape.roundedRectangle,
        borderRadius: 12.0,
        fallback: Avatars.initials(name: 'Border Test'),
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
      expect(baseAvatar.borderColor, Colors.red);
      expect(baseAvatar.borderWidth, 3.0);
      expect(baseAvatar.shape, AvatarShape.roundedRectangle);
      expect(baseAvatar.borderRadius, 12.0);
    });

    testWidgets('initials avatar applies custom text style', (tester) async {
      final style = TextStyle(fontSize: 22, color: Colors.purple);
      final widget = Avatars.initials(
        name: 'Custom Style',
        textStyle: style,
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      final text = tester.widget<Text>(find.text('CS'));
      expect(text.style?.fontSize, 22);
      expect(text.style?.color, Colors.purple);
    });

    testWidgets('icon avatar supports all shape variants', (tester) async {
      for (final shape in AvatarShape.values) {
        final widget = Avatars.icon(
          icon: Icons.person,
          shape: shape,
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
        expect(baseAvatar.shape, shape);
      }
    });

    testWidgets('initials avatar handles empty name', (tester) async {
      final widget = Avatars.initials(name: '');
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(BaseAvatar), findsOneWidget);
    });

    testWidgets('icon avatar handles missing icon', (tester) async {
      final widget = BaseAvatar(
        size: AvatarSize.md,
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(BaseAvatar), findsOneWidget);
    });
  });

  // border side width and color tests
  testWidgets('border side width and color', (tester) async {
    final widget = Avatars.initials(
      name: 'Border Test',
      borderColor: Colors.red,
      borderWidth: 3.0,
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.borderColor, Colors.red);
    expect(baseAvatar.borderWidth, 3.0);
  });

  // badge tests
  testWidgets('badge status', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge.status(
        status: UserStatus.online,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.status, UserStatus.online);
  });

  testWidgets('badge status - offline', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge.status(
        status: UserStatus.offline,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.status, UserStatus.offline);
  });

  testWidgets('badge status - busy', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge.status(
        status: UserStatus.busy,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.status, UserStatus.busy);
  });

  testWidgets('badge status - away', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge.status(
        status: UserStatus.away,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.status, UserStatus.away);
  });

  //badge with notification
  testWidgets('Badge with notification', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge.notification(
        count: 4,
        size: 12.0,
      ),
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.notificationCount, 4);
    final notificationText = tester.widget<Text>(find.text('4'));
    expect(notificationText, isNotNull);
    expect(notificationText.data, '4');
  });

  // badge with custom child
  testWidgets('Badge with custom child', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      badge: AvatarBadge(
        child: Icon(Icons.mic_off),
        size: 12.0,
      ),
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badge!.child, isNotNull);
    final icon = tester.widget<Icon>(find.byIcon(Icons.mic_off));
    expect(icon, isNotNull);
  });

  // badge position tests
  testWidgets('badge position - top left', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      shape: AvatarShape.roundedRectangle,
      badgePosition: BadgePosition.topLeft,
      badge: AvatarBadge.status(
        status: UserStatus.online,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badgePosition, BadgePosition.topLeft);
  });

  testWidgets('badge position - top right', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      shape: AvatarShape.roundedRectangle,
      badgePosition: BadgePosition.topRight,
      badge: AvatarBadge.status(
        status: UserStatus.online,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badgePosition, BadgePosition.topRight);
  });

  testWidgets('badge position - bottom left', (tester) async {
    final widget = Avatars.initials(
      name: 'Badge Test',
      shape: AvatarShape.roundedRectangle,
      badgePosition: BadgePosition.bottomLeft,
      badge: AvatarBadge.status(
        status: UserStatus.online,
        size: 12.0,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.badge, isNotNull);
    expect(baseAvatar.badgePosition, BadgePosition.bottomLeft);
  });

  // icon size test based on avatar size
  testWidgets('icon size based on avatar size - xs', (tester) async {
    final widget = Avatars.icon(
      icon: Icons.person,
      size: AvatarSize.xs,
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.icon, Icons.person);
    expect(baseAvatar.size, AvatarSize.xs);
  });
  testWidgets('icon size based on avatar size - lg', (tester) async {
    final widget = Avatars.icon(
      icon: Icons.person,
      size: AvatarSize.lg,
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.icon, Icons.person);
    expect(baseAvatar.size, AvatarSize.lg);
  });
  testWidgets('icon size based on avatar size - xl', (tester) async {
    final widget = Avatars.icon(
      icon: Icons.person,
      size: AvatarSize.xl,
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.icon, Icons.person);
    expect(baseAvatar.size, AvatarSize.xl);
  });
  testWidgets('icon size based on avatar size - xxl', (tester) async {
    final widget = Avatars.icon(
      icon: Icons.person,
      size: AvatarSize.xxl,
    );
    await tester.pumpWidget(MaterialApp(home: widget));
    final baseAvatar = tester.widget<BaseAvatar>(find.byType(BaseAvatar));
    expect(baseAvatar.icon, Icons.person);
    expect(baseAvatar.size, AvatarSize.xxl);
  });
}
