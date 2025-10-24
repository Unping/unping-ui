// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Avatar helpers', () {
    test('ColorGenerator.fromString is deterministic and uses palette', () {
      final a = ColorGenerator.fromString('alice');
      final b = ColorGenerator.fromString('alice');
      final c = ColorGenerator.fromString('bob');
      expect(a, equals(b));
      expect(a, isA<Color>());
      expect(c, isNot(equals(a)));
    });

    group('InitialsHelper.getInitials', () {
      test('single name', () {
        expect(InitialsHelper.getInitials('Jane'), 'J');
      });

      test('first and last', () {
        expect(InitialsHelper.getInitials('John Doe'), 'JD');
      });

      test('multiple words uses first and last', () {
        expect(InitialsHelper.getInitials('Mary Jane Watson'), 'MW');
      });

      test('empty string', () {
        expect(InitialsHelper.getInitials(''), '?');
      });
    });

    group('AvatarSizeHelper.getIconSize - ', () {
      test('xs size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.xs);
        expect(result, 12);
      });
      test('sm size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.sm);
        expect(result, 14);
      });
      test('md size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.md);
        expect(result, 16);
      });
      test('lg size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.lg);
        expect(result, 18);
      });
      test('xl size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.xl);
        expect(result, 20);
      });
      test('xxl size', () {
        final result = AvatarSizeHelper.getIconSize(AvatarSize.xxl);
        expect(result, 24);
      });
    });

    group('AvatarSizeHelper.getBorderRadius', () {
      test('xs size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.xs);
        expect(result, 4);
      });
      test('sm size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.sm);
        expect(result, 4);
      });
      test('md size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.md);
        expect(result, 8);
      });
      test('lg size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.lg);
        expect(result, 8);
      });
      test('xl size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.xl);
        expect(result, 12);
      });
      test('xxl size', () {
        final result = AvatarSizeHelper.getBorderRadius(AvatarSize.xxl);
        expect(result, 12);
      });
    });
  });
}
