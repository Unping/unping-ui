// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
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
  });
}
