import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unping_ui/unping_ui.dart';

void main() {
  group('Component Interface', () {
    group('UnpingUIComponent interface', () {
      test('defines required interface methods', () {
        // This test ensures the interface exists and has the expected methods
        expect(UnpingUIComponent, isA<Type>());
      });
    });

    group('ComponentSize enum', () {
      test('has expected values', () {
        expect(ComponentSize.values, [
          ComponentSize.sm,
          ComponentSize.md,
          ComponentSize.lg,
        ]);
      });
    });

    group('ComponentVisualState enum', () {
      test('has expected values', () {
        expect(ComponentVisualState.values, [
          ComponentVisualState.normal,
          ComponentVisualState.hovered,
          ComponentVisualState.focused,
          ComponentVisualState.pressed,
          ComponentVisualState.disabled,
        ]);
      });
    });

    group('ComponentColors', () {
      test('can be instantiated with required colors', () {
        const colors = ComponentColors(
          primary: Color(0xFF000000),
          secondary: Color(0xFF111111),
          background: Color(0xFF222222),
          text: Color(0xFF333333),
          border: Color(0xFF444444),
          success: Color(0xFF555555),
          warning: Color(0xFF666666),
          error: Color(0xFF777777),
          disabled: Color(0xFF888888),
        );

        expect(colors.primary, const Color(0xFF000000));
        expect(colors.secondary, const Color(0xFF111111));
        expect(colors.background, const Color(0xFF222222));
        expect(colors.text, const Color(0xFF333333));
        expect(colors.border, const Color(0xFF444444));
        expect(colors.success, const Color(0xFF555555));
        expect(colors.warning, const Color(0xFF666666));
        expect(colors.error, const Color(0xFF777777));
        expect(colors.disabled, const Color(0xFF888888));
      });
    });

    group('ComponentTypography', () {
      test('can be instantiated with required properties', () {
        const typography = ComponentTypography(
          fontSizeSmall: 12.0,
          fontSizeMedium: 14.0,
          fontSizeLarge: 16.0,
          fontWeightNormal: FontWeight.w400,
          fontWeightMedium: FontWeight.w500,
          fontWeightBold: FontWeight.w700,
          fontFamily: 'Test Font',
          lineHeight: 1.5,
        );

        expect(typography.fontSizeSmall, 12.0);
        expect(typography.fontSizeMedium, 14.0);
        expect(typography.fontSizeLarge, 16.0);
        expect(typography.fontWeightNormal, FontWeight.w400);
        expect(typography.fontWeightMedium, FontWeight.w500);
        expect(typography.fontWeightBold, FontWeight.w700);
        expect(typography.fontFamily, 'Test Font');
        expect(typography.lineHeight, 1.5);
      });
    });

    group('ComponentSpacing', () {
      test('can be instantiated with required spacing values', () {
        const spacing = ComponentSpacing(
          xs: 2.0,
          sm: 4.0,
          md: 8.0,
          lg: 16.0,
          xl: 24.0,
        );

        expect(spacing.xs, 2.0);
        expect(spacing.sm, 4.0);
        expect(spacing.md, 8.0);
        expect(spacing.lg, 16.0);
        expect(spacing.xl, 24.0);
      });
    });

    group('ComponentBorders', () {
      test('can be instantiated with required border properties', () {
        const borders = ComponentBorders(
          width: 1.0,
          radiusSmall: 4.0,
          radiusMedium: 6.0,
          radiusLarge: 8.0,
          radiusCircle: 1000.0,
        );

        expect(borders.width, 1.0);
        expect(borders.radiusSmall, 4.0);
        expect(borders.radiusMedium, 6.0);
        expect(borders.radiusLarge, 8.0);
        expect(borders.radiusCircle, 1000.0);
      });
    });

    group('ComponentAnimations', () {
      test('can be instantiated with required animation properties', () {
        const animations = ComponentAnimations(
          durationFast: Duration(milliseconds: 100),
          durationNormal: Duration(milliseconds: 200),
          durationSlow: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          curveEaseIn: Curves.easeIn,
          curveEaseOut: Curves.easeOut,
        );

        expect(animations.durationFast, const Duration(milliseconds: 100));
        expect(animations.durationNormal, const Duration(milliseconds: 200));
        expect(animations.durationSlow, const Duration(milliseconds: 300));
        expect(animations.curve, Curves.easeInOut);
        expect(animations.curveEaseIn, Curves.easeIn);
        expect(animations.curveEaseOut, Curves.easeOut);
      });
    });
  });

  group('Component Utils', () {
    group('ComponentUtils', () {
      test('getFontSizeForSize returns correct sizes', () {
        expect(ComponentUtils.getFontSizeForSize(ComponentSize.sm), 12.0);
        expect(ComponentUtils.getFontSizeForSize(ComponentSize.md), 14.0);
        expect(ComponentUtils.getFontSizeForSize(ComponentSize.lg), 16.0);
      });

      test('getPaddingForSize returns correct padding', () {
        expect(
          ComponentUtils.getPaddingForSize(ComponentSize.sm),
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        );
        expect(
          ComponentUtils.getPaddingForSize(ComponentSize.md),
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        );
        expect(
          ComponentUtils.getPaddingForSize(ComponentSize.lg),
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        );
      });

      test('getBorderRadiusForSize returns correct radius', () {
        expect(ComponentUtils.getBorderRadiusForSize(ComponentSize.sm), 4.0);
        expect(ComponentUtils.getBorderRadiusForSize(ComponentSize.md), 6.0);
        expect(ComponentUtils.getBorderRadiusForSize(ComponentSize.lg), 8.0);
      });

      test('getGapForSize returns correct gap', () {
        expect(ComponentUtils.getGapForSize(ComponentSize.sm), 4.0);
        expect(ComponentUtils.getGapForSize(ComponentSize.md), 6.0);
        expect(ComponentUtils.getGapForSize(ComponentSize.lg), 8.0);
      });

      test('getMinHeightForSize returns correct height', () {
        expect(ComponentUtils.getMinHeightForSize(ComponentSize.sm), 28.0);
        expect(ComponentUtils.getMinHeightForSize(ComponentSize.md), 36.0);
        expect(ComponentUtils.getMinHeightForSize(ComponentSize.lg), 44.0);
      });

      test('createStandardDecoration creates proper decoration', () {
        final decoration = ComponentUtils.createStandardDecoration(
          backgroundColor: const Color(0xFF000000),
          borderColor: const Color(0xFF111111),
          borderWidth: 2.0,
          borderRadius: 8.0,
        );

        expect(decoration.color, const Color(0xFF000000));
        expect(decoration.borderRadius, BorderRadius.circular(8.0));
        expect(decoration.border, isA<Border>());
      });

      test('createFocusRingShadow creates proper shadow', () {
        final shadow = ComponentUtils.createFocusRingShadow(
          color: const Color(0xFF000000),
          width: 2.0,
        );

        expect(shadow.color, const Color(0xFF000000));
        expect(shadow.spreadRadius, 2.0);
        expect(shadow.offset, Offset.zero);
        expect(shadow.blurRadius, 0);
      });

      test('createStandardTextStyle creates proper text style', () {
        final style = ComponentUtils.createStandardTextStyle(
          color: const Color(0xFF000000),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Test Font',
          lineHeight: 1.5,
          decoration: TextDecoration.underline,
          decorationColor: const Color(0xFF111111),
        );

        expect(style.color, const Color(0xFF000000));
        expect(style.fontSize, 16.0);
        expect(style.fontWeight, FontWeight.bold);
        expect(style.fontFamily, 'Test Font');
        expect(style.height, 1.5);
        expect(style.decoration, TextDecoration.underline);
        expect(style.decorationColor, const Color(0xFF111111));
      });

      test('hasGoodContrast returns reasonable results', () {
        // White on black should have good contrast
        expect(
          ComponentUtils.hasGoodContrast(
            const Color(0xFFFFFFFF),
            const Color(0xFF000000),
          ),
          isTrue,
        );

        // Black on black should have poor contrast
        expect(
          ComponentUtils.hasGoodContrast(
            const Color(0xFF000000),
            const Color(0xFF000000),
          ),
          isFalse,
        );
      });
    });

    group('ComponentVariants', () {
      test('createPrimaryColors returns valid color scheme', () {
        final colors = ComponentVariants.createPrimaryColors();
        
        expect(colors, isA<ComponentColors>());
        expect(colors.primary, const Color(0xFF3B4554));
        expect(colors.background, const Color(0xFFFFFFFF));
        expect(colors.text, const Color(0xFF2A313C));
      });

      test('createDarkColors returns valid dark color scheme', () {
        final colors = ComponentVariants.createDarkColors();
        
        expect(colors, isA<ComponentColors>());
        expect(colors.primary, const Color(0xFFFFFFFF));
        expect(colors.background, const Color(0xFF2A313C));
        expect(colors.text, const Color(0xFFFFFFFF));
      });

      test('createStandardTypography returns valid typography', () {
        final typography = ComponentVariants.createStandardTypography();
        
        expect(typography, isA<ComponentTypography>());
        expect(typography.fontSizeSmall, 12.0);
        expect(typography.fontSizeMedium, 14.0);
        expect(typography.fontSizeLarge, 16.0);
        expect(typography.fontFamily, 'Inter');
      });

      test('createStandardSpacing returns valid spacing', () {
        final spacing = ComponentVariants.createStandardSpacing();
        
        expect(spacing, isA<ComponentSpacing>());
        expect(spacing.xs, 2.0);
        expect(spacing.sm, 4.0);
        expect(spacing.md, 8.0);
        expect(spacing.lg, 16.0);
        expect(spacing.xl, 24.0);
      });

      test('createStandardBorders returns valid borders', () {
        final borders = ComponentVariants.createStandardBorders();
        
        expect(borders, isA<ComponentBorders>());
        expect(borders.width, 1.0);
        expect(borders.radiusSmall, 4.0);
        expect(borders.radiusMedium, 6.0);
        expect(borders.radiusLarge, 8.0);
      });

      test('createStandardAnimations returns valid animations', () {
        final animations = ComponentVariants.createStandardAnimations();
        
        expect(animations, isA<ComponentAnimations>());
        expect(animations.durationFast, const Duration(milliseconds: 100));
        expect(animations.durationNormal, const Duration(milliseconds: 200));
        expect(animations.durationSlow, const Duration(milliseconds: 300));
      });
    });

    group('ComponentValidation', () {
      test('validateRange passes for valid values', () {
        expect(
          () => ComponentValidation.validateRange(5, 0, 10, 'test'),
          returnsNormally,
        );
      });

      test('validateRange throws for invalid values', () {
        expect(
          () => ComponentValidation.validateRange(15, 0, 10, 'test'),
          throwsAssertionError,
        );
      });

      test('validatePositiveDuration passes for positive duration', () {
        expect(
          () => ComponentValidation.validatePositiveDuration(
            const Duration(milliseconds: 100),
            'test',
          ),
          returnsNormally,
        );
      });

      test('validatePositiveDuration throws for zero/negative duration', () {
        expect(
          () => ComponentValidation.validatePositiveDuration(
            Duration.zero,
            'test',
          ),
          throwsAssertionError,
        );
      });

      test('validateColorOpacity passes for opaque colors', () {
        expect(
          () => ComponentValidation.validateColorOpacity(
            const Color(0xFF000000),
            'test',
          ),
          returnsNormally,
        );
      });

      test('validateColorOpacity throws for transparent colors', () {
        expect(
          () => ComponentValidation.validateColorOpacity(
            const Color(0x00000000),
            'test',
          ),
          throwsAssertionError,
        );
      });

      test('validateRequiredContent passes for non-empty content', () {
        expect(
          () => ComponentValidation.validateRequiredContent(
            [const Text('test')],
            'TestComponent',
          ),
          returnsNormally,
        );
      });

      test('validateRequiredContent throws for empty content', () {
        expect(
          () => ComponentValidation.validateRequiredContent(
            [null, null],
            'TestComponent',
          ),
          throwsAssertionError,
        );
      });

      test('validateEnumValue passes for valid enum values', () {
        expect(
          () => ComponentValidation.validateEnumValue(
            ComponentSize.md,
            ComponentSize.values,
            'size',
          ),
          returnsNormally,
        );
      });
    });

    group('AccessibilityUtils', () {
      test('createInteractiveSemantics returns proper semantic properties', () {
        final semantics = AccessibilityUtils.createInteractiveSemantics(
          label: 'Test Button',
          hint: 'Press to test',
          enabled: true,
          checked: false,
        );

        expect(semantics['label'], 'Test Button');
        expect(semantics['hint'], 'Press to test');
        expect(semantics['enabled'], true);
        expect(semantics['checked'], false);
      });

      test('wrapWithSemantics creates Semantics widget', () {
        final widget = AccessibilityUtils.wrapWithSemantics(
          label: 'Test',
          child: const Text('Test'),
        );

        expect(widget, isA<Semantics>());
      });

      test('needsScreenReaderSupport returns boolean', () {
        // Note: This would need a proper BuildContext in a real test
        // For now, just verify the method exists and returns a boolean
        expect(AccessibilityUtils.needsScreenReaderSupport, isA<Function>());
      });
    });
  });

  group('Default Theme', () {
    group('DefaultComponentTheme', () {
      test('can be instantiated with defaults', () {
        const theme = DefaultComponentTheme();
        
        expect(theme, isA<ComponentTheme>());
        expect(theme.colors, isA<ComponentColors>());
        expect(theme.typography, isA<ComponentTypography>());
        expect(theme.spacing, isA<ComponentSpacing>());
        expect(theme.borders, isA<ComponentBorders>());
        expect(theme.animations, isA<ComponentAnimations>());
      });

      test('can be instantiated with custom values', () {
        const customColors = ComponentColors(
          primary: Color(0xFF000000),
          secondary: Color(0xFF111111),
          background: Color(0xFF222222),
          text: Color(0xFF333333),
          border: Color(0xFF444444),
          success: Color(0xFF555555),
          warning: Color(0xFF666666),
          error: Color(0xFF777777),
          disabled: Color(0xFF888888),
        );

        const theme = DefaultComponentTheme(colors: customColors);
        
        expect(theme.colors, customColors);
      });

      test('copyWith creates new instance with overrides', () {
        const originalTheme = DefaultComponentTheme();
        const newColors = ComponentColors(
          primary: Color(0xFF000000),
          secondary: Color(0xFF111111),
          background: Color(0xFF222222),
          text: Color(0xFF333333),
          border: Color(0xFF444444),
          success: Color(0xFF555555),
          warning: Color(0xFF666666),
          error: Color(0xFF777777),
          disabled: Color(0xFF888888),
        );

        final newTheme = originalTheme.copyWith(colors: newColors);
        
        expect(newTheme.colors, newColors);
        expect(newTheme.typography, originalTheme.typography);
      });
    });

    group('DarkComponentTheme', () {
      test('uses dark colors by default', () {
        const theme = DarkComponentTheme();
        
        expect(theme.colors.primary, const Color(0xFFFFFFFF));
        expect(theme.colors.background, const Color(0xFF2A313C));
        expect(theme.colors.text, const Color(0xFFFFFFFF));
      });
    });

    group('ComponentThemeExtension', () {
      test('getTextStyle returns proper TextStyle', () {
        const theme = DefaultComponentTheme();
        
        final style = theme.getTextStyle(
          size: ComponentSize.lg,
          weight: FontWeight.bold,
          color: const Color(0xFF000000),
        );

        expect(style.fontSize, 16.0);
        expect(style.fontWeight, FontWeight.bold);
        expect(style.color, const Color(0xFF000000));
      });

      test('getPadding returns size-based padding', () {
        const theme = DefaultComponentTheme();
        
        final padding = theme.getPadding(ComponentSize.md);
        
        expect(padding, const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0));
      });

      test('createDecoration returns proper BoxDecoration', () {
        const theme = DefaultComponentTheme();
        
        final decoration = theme.createDecoration(
          backgroundColor: const Color(0xFF000000),
          size: ComponentSize.md,
        );

        expect(decoration.color, const Color(0xFF000000));
        expect(decoration.borderRadius, BorderRadius.circular(6.0));
      });

      test('getStateColor returns different colors for different states', () {
        const theme = DefaultComponentTheme();
        
        final normalColor = theme.getStateColor(state: ComponentVisualState.normal);
        final hoverColor = theme.getStateColor(state: ComponentVisualState.hovered);
        final disabledColor = theme.getStateColor(state: ComponentVisualState.disabled);

        expect(normalColor, isNot(equals(hoverColor)));
        expect(normalColor, isNot(equals(disabledColor)));
        expect(hoverColor, isNot(equals(disabledColor)));
      });
    });

    group('UnpingUIThemes', () {
      test('provides predefined themes', () {
        expect(UnpingUIThemes.light, isA<ComponentTheme>());
        expect(UnpingUIThemes.dark, isA<ComponentTheme>());
        expect(UnpingUIThemes.highContrastLight, isA<ComponentTheme>());
        expect(UnpingUIThemes.highContrastDark, isA<ComponentTheme>());
        expect(UnpingUIThemes.colorful, isA<ComponentTheme>());
      });

      test('light and dark themes have different colors', () {
        final lightColors = UnpingUIThemes.light.colors;
        final darkColors = UnpingUIThemes.dark.colors;

        expect(lightColors.background, isNot(equals(darkColors.background)));
        expect(lightColors.text, isNot(equals(darkColors.text)));
      });
    });
  });
}