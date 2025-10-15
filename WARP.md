# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Unping-UI is a Flutter component library similar to shadcn/ui for React. It provides copy-paste ready widgets designed for Desktop & Web first applications. The library is distributed via both pub.dev and fpx (Flutter Paste X) for maximum flexibility.

## Development Commands

### Core Development
```powershell
# Install dependencies
dart pub get

# Run tests
flutter test

# Analyze code (required before commits)
dart analyze

# Format code (required before commits)
dart format --line-length 80 lib test
```

### Widgetbook Development
```powershell
# Install widgetbook dependencies
cd widgetbook
dart pub get

# Generate widgetbook code (required after adding new widgets)
dart run build_runner build -d

# Run widgetbook app locally
flutter run

# Build widgetbook for web deployment
flutter build web
```

### Running Single Tests
```powershell
# Run a specific test file
flutter test test/src/components/base_button_test.dart

# Run tests matching a name pattern
flutter test --name "button test description"
```

## Architecture Overview

### Component Structure Pattern

Components follow a **Base + Variants** pattern:

1. **Base Components** (`base_*.dart`): Fully configurable widgets with all possible properties exposed. These provide maximum flexibility and are the foundation for all variants.
   - Example: `BaseButton`, `BaseInput`, `BaseTooltip`
   - Located in: `lib/src/components/{component_name}/base_*.dart`

2. **Variant Components** (`*_variants.dart`): Pre-configured factory methods that create base components with commonly used configurations.
   - Example: `Buttons.filled()`, `Buttons.outline()`, `Inputs.text()`, `Inputs.password()`
   - Located in: `lib/src/components/{component_name}/*_variants.dart`

3. **Type Definitions** (`*_types.dart`): Enums, data classes, and shared types for the component.
   - Located in: `lib/src/components/{component_name}/*_types.dart`

### Foundation System (Design Tokens)

All components use values from the foundation system in `lib/src/foundation/`:

- **UiColors**: Complete color palette with semantic scales (primary, neutral, success, warning, error) in shades 25-950
- **UiTextStyles**: Typography scale (textXs, textSm, textMd, etc.)
- **UiSpacing**: Spacing scale (xs, sm, md, lg, xl, etc.)
- **UiRadius**: Border radius values (xs, sm, md, lg, xl, full)

**Critical Rule**: Never hardcode colors, spacings, or text styles. Always use foundation values. If a needed value is missing, add it to the appropriate foundation file.

### Export Pattern

All public APIs are exported through `lib/unping_ui.dart`:
- Components must be added to the main export file
- Foundation system is exported via `src/foundation/foundation.dart`
- This ensures clean imports: `import 'package:unping_ui/unping_ui.dart';`

### Widgetbook Integration

Every component requires two Widgetbook stories in `widgetbook/lib/components/{component_name}/`:

1. **Showcase Story** (`*.showcase.widgetbook.dart`): Demonstrates real-world usage with multiple configurations side-by-side
2. **Configurable Story** (`*.configurable.widgetbook.dart`): Interactive story with knobs for all properties

After adding stories, regenerate Widgetbook with: `cd widgetbook && dart run build_runner build -d`

### Testing Requirements

- Widget tests are mandatory for all components in `test/src/components/`
- Test all states: normal, hovered, focused, disabled, error
- Test user interactions and animations
- Follow the existing test structure: mirror the `lib/` directory in `test/`

## Key Development Guidelines

### Component Development Rules

- **No Material Design**: Don't use Material widgets. Build components from scratch using Flutter primitives
- **No External Themes**: Use the foundation system, not external styling themes
- **Modular Components**: Follow single-responsibility principle; compose complex widgets from simpler ones
- **State Management**: Use widget state for UI state, Cubit/Bloc only when needed for complex business logic

### Styling Approach

Components are styled using:
- Foundation values (UiColors, UiTextStyles, UiSpacing, UiRadius)
- State-based variants (normal, hover, focus, disabled)
- Direct color/size properties passed to Flutter widgets
- NO Material ThemeData or external CSS-like systems

### Adding New Components

1. Create base component in `lib/src/components/{name}/base_{name}.dart`
2. Create variants in `lib/src/components/{name}/{name}_variants.dart`
3. Create types if needed in `lib/src/components/{name}/{name}_types.dart`
4. Export in `lib/unping_ui.dart`
5. Write tests in `test/src/components/{name}/`
6. Create showcase story in `widgetbook/lib/components/{name}/{name}.showcase.widgetbook.dart`
7. Create configurable story in `widgetbook/lib/components/{name}/{name}.configurable.widgetbook.dart`
8. Generate Widgetbook: `cd widgetbook && dart run build_runner build -d`
9. Run tests: `flutter test`
10. Format and analyze: `dart format --line-length 80 lib test && dart analyze`

### Before Every Commit

Run these checks (they will fail CI if skipped):
```powershell
flutter test           # All tests must pass
dart analyze          # No analysis errors
dart format --line-length 80 lib test  # Code must be formatted
```

### fpx Integration

Components are configured for copy-paste distribution via fpx (Flutter Paste X):
- Configuration: `fpx.yaml`
- Component source: `lib/src/components/`
- Foundation files are referenced for variable substitution

Users can add components to their projects:
```bash
fpx repository add --url https://github.com/unping/unping-ui --name unping-ui
fpx add button
```

## Component Examples

### Creating a Button Variant
```dart
// In button_variants.dart
static BaseButton filled({
  required String text,
  required VoidCallback? onPressed,
  // ... other params
}) {
  return BaseButton(
    text: text,
    onPressed: onPressed,
    backgroundColor: UiColors.primary,  // Use foundation
    textColor: UiColors.onPrimary,
    borderRadius: UiRadius.sm,
    padding: EdgeInsets.symmetric(
      horizontal: UiSpacing.md,
      vertical: UiSpacing.sm,
    ),
  );
}
```

### Using State-based Styling
```dart
// Components support multiple state colors
BaseButton(
  text: 'Button',
  backgroundColor: UiColors.primary,
  hoverBackgroundColor: UiColors.primary700,
  focusBackgroundColor: UiColors.primary800,
  disabledBackgroundColor: UiColors.neutral300,
  // ...
)
```
