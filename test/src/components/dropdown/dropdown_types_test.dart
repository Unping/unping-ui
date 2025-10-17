// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('DropdownOption', () {
    test('copyWith creates new instance with updated values', () {
      final original = DropdownOption(
        value: 'test',
        label: 'Test Label',
        supportingText: 'Helper',
        enabled: true,
        showDivider: false,
      );

      final copied = original.copyWith(
        label: 'New Label',
        enabled: false,
      );

      expect(copied.value, equals('test'));
      expect(copied.label, equals('New Label'));
      expect(copied.supportingText, equals('Helper'));
      expect(copied.enabled, isFalse);
      expect(copied.showDivider, isFalse);
    });

    test('copyWith preserves original values when not specified', () {
      final original = DropdownOption(
        value: 42,
        label: 'Answer',
        icon: Icon(Icons.star),
        trailing: Text('Badge'),
      );

      final copied = original.copyWith(
        label: 'Updated Answer',
      );

      expect(copied.value, equals(42));
      expect(copied.label, equals('Updated Answer'));
      expect(copied.icon, equals(original.icon));
      expect(copied.trailing, equals(original.trailing));
    });

    test('copyWith can update all fields', () {
      final original = DropdownOption(
        value: 'old',
        label: 'Old',
      );

      final copied = original.copyWith(
        value: 'new',
        label: 'New Label',
        supportingText: 'New Helper',
        icon: Icon(Icons.check),
        trailing: Text('New Badge'),
        enabled: false,
        showDivider: true,
        group: 'Group A',
        builder: (context, selected, focused) => Container(),
      );

      expect(copied.value, equals('new'));
      expect(copied.label, equals('New Label'));
      expect(copied.supportingText, equals('New Helper'));
      expect(copied.icon, isNotNull);
      expect(copied.trailing, isNotNull);
      expect(copied.enabled, isFalse);
      expect(copied.showDivider, isTrue);
      expect(copied.group, equals('Group A'));
      expect(copied.builder, isNotNull);
    });

    test('equality operator compares by value', () {
      final option1 = DropdownOption(value: 'a', label: 'Option A');
      final option2 = DropdownOption(value: 'a', label: 'Different Label');
      final option3 = DropdownOption(value: 'b', label: 'Option B');

      expect(option1 == option2, isTrue);
      expect(option1 == option3, isFalse);
    });

    test('identical instances are equal', () {
      final option = DropdownOption(value: 'test', label: 'Test');

      expect(option == option, isTrue);
    });

    test('hashCode is based on value', () {
      final option1 = DropdownOption(value: 'a', label: 'Option A');
      final option2 = DropdownOption(value: 'a', label: 'Different Label');
      final option3 = DropdownOption(value: 'b', label: 'Option B');

      expect(option1.hashCode, equals(option2.hashCode));
      expect(option1.hashCode, isNot(equals(option3.hashCode)));
    });
  });

  group('DropdownConfig', () {
    test('copyWith creates new instance with updated values', () {
      final original = DropdownConfig(
        menuWidth: 200,
        menuMaxHeight: 300,
        closeOnSelect: true,
        searchable: false,
      );

      final copied = original.copyWith(
        menuWidth: 250,
        searchable: true,
      );

      expect(copied.menuWidth, equals(250));
      expect(copied.menuMaxHeight, equals(300));
      expect(copied.closeOnSelect, isTrue);
      expect(copied.searchable, isTrue);
    });

    test('copyWith preserves original values when not specified', () {
      final original = DropdownConfig(
        menuMaxHeight: 400,
        menuPosition: DropdownMenuPosition.above,
        showCheckmarks: false,
        virtualScrolling: true,
      );

      final copied = original.copyWith(
        menuMaxHeight: 500,
      );

      expect(copied.menuMaxHeight, equals(500));
      expect(copied.menuPosition, equals(DropdownMenuPosition.above));
      expect(copied.showCheckmarks, isFalse);
      expect(copied.virtualScrolling, isTrue);
    });

    test('copyWith can update all fields', () {
      final original = DropdownConfig();

      final copied = original.copyWith(
        menuWidth: 300,
        menuMaxHeight: 400,
        menuMinWidth: 250,
        menuPosition: DropdownMenuPosition.below,
        closeOnSelect: false,
        searchable: true,
        searchPlaceholder: 'Type here...',
        showCheckmarks: false,
        virtualScrolling: true,
        menuOffset: 8.0,
        isLoading: true,
        loadingWidget: Container(),
        loadingMessage: 'Please wait...',
      );

      expect(copied.menuWidth, equals(300));
      expect(copied.menuMaxHeight, equals(400));
      expect(copied.menuMinWidth, equals(250));
      expect(copied.menuPosition, equals(DropdownMenuPosition.below));
      expect(copied.closeOnSelect, isFalse);
      expect(copied.searchable, isTrue);
      expect(copied.searchPlaceholder, equals('Type here...'));
      expect(copied.showCheckmarks, isFalse);
      expect(copied.virtualScrolling, isTrue);
      expect(copied.menuOffset, equals(8.0));
      expect(copied.isLoading, isTrue);
      expect(copied.loadingWidget, isNotNull);
      expect(copied.loadingMessage, equals('Please wait...'));
    });

    test('copyWith can update searchFilter', () {
      final original = DropdownConfig();

      bool customFilter(DropdownOption option, String query) {
        return option.label.contains(query);
      }

      final copied = original.copyWith(
        searchFilter: customFilter,
      );

      expect(copied.searchFilter, isNotNull);
    });
  });

  group('DropdownSizeTokens', () {
    test('forSize returns correct tokens for small size', () {
      final tokens = DropdownSizeTokens.forSize(DropdownSize.sm);

      expect(tokens.minHeight, equals(36.0));
      expect(tokens.textStyle.fontSize, equals(14.0));
      expect(tokens.iconSize, equals(16.0));
    });

    test('forSize returns correct tokens for medium size', () {
      final tokens = DropdownSizeTokens.forSize(DropdownSize.md);

      expect(tokens.minHeight, equals(44.0));
      expect(tokens.textStyle.fontSize, equals(16.0));
      expect(tokens.iconSize, equals(20.0));
    });

    test('forSize returns correct tokens for large size', () {
      final tokens = DropdownSizeTokens.forSize(DropdownSize.lg);

      expect(tokens.minHeight, equals(52.0));
      expect(tokens.textStyle.fontSize, equals(18.0));
      expect(tokens.iconSize, equals(24.0));
    });
  });

  group('DropdownMenuAction', () {
    test('creates action with all properties', () {
      final action = DropdownMenuAction(
        label: 'Delete',
        icon: Icon(Icons.delete),
        onTap: () {},
        destructive: true,
        enabled: false,
        showDivider: true,
        shortcut: '⌘D',
      );

      expect(action.label, equals('Delete'));
      expect(action.icon, isNotNull);
      expect(action.onTap, isNotNull);
      expect(action.destructive, isTrue);
      expect(action.enabled, isFalse);
      expect(action.showDivider, isTrue);
      expect(action.shortcut, equals('⌘D'));
    });

    test('creates action with defaults', () {
      final action = DropdownMenuAction(
        label: 'Edit',
      );

      expect(action.label, equals('Edit'));
      expect(action.icon, isNull);
      expect(action.onTap, isNull);
      expect(action.destructive, isFalse);
      expect(action.enabled, isTrue);
      expect(action.showDivider, isFalse);
      expect(action.shortcut, isNull);
    });
  });

  group('Enums', () {
    test('DropdownSize has correct values', () {
      expect(DropdownSize.values.length, equals(3));
      expect(DropdownSize.values, contains(DropdownSize.sm));
      expect(DropdownSize.values, contains(DropdownSize.md));
      expect(DropdownSize.values, contains(DropdownSize.lg));
    });

    test('DropdownState has correct values', () {
      expect(DropdownState.values.length, equals(5));
      expect(DropdownState.values, contains(DropdownState.normal));
      expect(DropdownState.values, contains(DropdownState.focused));
      expect(DropdownState.values, contains(DropdownState.open));
      expect(DropdownState.values, contains(DropdownState.disabled));
      expect(DropdownState.values, contains(DropdownState.error));
    });

    test('DropdownType has correct values', () {
      expect(DropdownType.values.length, equals(4));
      expect(DropdownType.values, contains(DropdownType.select));
      expect(DropdownType.values, contains(DropdownType.multiSelect));
      expect(DropdownType.values, contains(DropdownType.combobox));
      expect(DropdownType.values, contains(DropdownType.menu));
    });

    test('DropdownMenuPosition has correct values', () {
      expect(DropdownMenuPosition.values.length, equals(3));
      expect(DropdownMenuPosition.values, contains(DropdownMenuPosition.below));
      expect(DropdownMenuPosition.values, contains(DropdownMenuPosition.above));
      expect(DropdownMenuPosition.values, contains(DropdownMenuPosition.auto));
    });
  });
}
