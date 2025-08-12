# Unping UI

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Desktop & Web first flutter components to build your component library with. Customizable, extendable, tested.

## Component Interface System 🎯

Unping UI now includes a comprehensive component interface system that ensures consistency and quality across all components. This system provides:

- **Standardized interfaces** for all component types
- **Consistent theming** and styling patterns
- **Built-in accessibility** support
- **Comprehensive validation** and error checking
- **Flexible animation** and interaction patterns
- **Developer-friendly templates** for creating new components

### Key Features

- ✅ **Interface-driven development** - All components implement consistent interfaces
- ✅ **Theming system** - Light, dark, and custom themes out of the box
- ✅ **Accessibility first** - Screen reader support, keyboard navigation, focus management
- ✅ **Type-safe validation** - Comprehensive property validation with helpful error messages
- ✅ **Animation support** - Consistent animation patterns across components
- ✅ **Size variants** - Standardized small, medium, and large sizes
- ✅ **State management** - Consistent handling of hover, focus, disabled, and loading states

## Installation 💻

**❗ In order to start using Unping Ui you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

### Prerequisites

Before you can use Unping UI components in your project, you need to install and set up [fpx][fpx_link] (Flutter Paste X):

1. **Install fpx globally:**
   ```sh
   dart pub global activate fpx
   ```

2. **Add the unping-ui repository to fpx:**
   ```sh
   fpx repository add https://github.com/unping/unping-ui
   ```

3. **Use fpx to paste components from unping-ui into your project:**
   ```sh
   fpx add <component_name>
   ```

That's it! You're now ready to use Unping UI components in your Flutter project. 🎉

## Usage 🚀

Once installed, you can browse and add any component from the unping-ui library:

```sh
# List all available components
fpx list

# Add a specific component to your project
fpx add button
fpx add card
fpx add input_field
```

### Using the Component Interface

All Unping UI components implement consistent interfaces. Here's how to use them:

```dart
import 'package:unping_ui/unping_ui.dart';

// Use predefined themes
UnpingUITheme(
  theme: UnpingUIThemes.dark, // or .light, .highContrastLight, etc.
  child: MyApp(),
)

// Create custom themes
UnpingUITheme(
  theme: DefaultComponentTheme(
    colors: ComponentVariants.createDarkColors(),
    typography: ComponentVariants.createStandardTypography(),
  ),
  child: MyApp(),
)

// Components automatically inherit theme
BaseButton(
  text: 'Click me',
  size: ComponentSize.lg,
  onPressed: () => print('Pressed'),
)

// Components support all standard states
BaseCheckbox(
  state: CheckboxState.checked,
  size: ComponentSize.md,
  onChanged: (state) => print('Changed to $state'),
)
```

### Creating Custom Components

Use the component template to create new components that automatically follow Unping UI patterns:

```dart
// 1. Extend the appropriate base class
class MyCustomComponent extends BaseInteractiveComponent 
    with StateVariantMixin<MyComponentState> {
  
  // 2. Implement required interface methods
  @override
  String get componentType => 'MyCustomComponent';
  
  @override
  bool get isDisabled => onPressed == null;
  
  // 3. Use provided utilities for consistency
  @override
  void validateProperties() {
    super.validateProperties();
    ComponentValidation.validateRange(someValue, 0, 100, 'someValue');
  }
}

// 4. Create factory methods for common variants
class MyComponents {
  static MyCustomComponent primary({String? text, VoidCallback? onPressed}) {
    return MyCustomComponent(
      text: text,
      onPressed: onPressed,
      backgroundColor: const Color(0xFF3B4554),
      textColor: const Color(0xFFFFFFFF),
    );
  }
}
```

## Develop new widgets

### Component Development Guidelines

When creating new components, follow the Unping UI interface system:

1. **Choose the right base class:**
   - `BaseInteractiveComponent` for buttons, inputs, etc.
   - `BaseDisplayComponent` for labels, badges, etc.
   - `BaseContainerComponent` for layouts, cards, etc.

2. **Implement required interfaces:**
   - Define `componentType` for debugging
   - Implement `validateProperties()` for property validation
   - Use appropriate mixins for common functionality

3. **Follow the template:**
   - See `lib/src/core/component_template.dart` for a complete example
   - Use `ComponentUtils` for consistent sizing and styling
   - Implement factory methods in a helper class

4. **Add comprehensive tests:**
   - Test interface compliance
   - Test all component states and interactions
   - Test accessibility features

5. **Create Widgetbook stories:**
   - Add your component to the Widgetbook app
   - Show different states and variants
   - Include interactive knobs for properties

### Development Workflow

For adding new widgets, place them in lib/src/ folder following the interface patterns:

```dart
// lib/src/my_new_component.dart
class MyNewComponent extends BaseInteractiveComponent 
    with StateVariantMixin<MyComponentState> {
  // Implementation following the interface
}

// Create factory methods
class MyNewComponents {
  static MyNewComponent primary({...}) => MyNewComponent(...);
  static MyNewComponent secondary({...}) => MyNewComponent(...);
}
```

Add your component to the main library export in `lib/unping_ui.dart`:

```dart
export 'src/my_new_component.dart';
```

Add a wrapper in widgetbook/lib for your new widget:

```dart
// widgetbook/lib/my_new_component.dart
@UseCase(name: 'Primary', type: MyNewComponent)
Widget myNewComponentPrimary(BuildContext context) {
  return MyNewComponents.primary(text: 'Hello World');
}
```

After adding a widget, trigger the code generation for widgetbook:
```
cd widgetbook && dart run build_runner build -d
```

To see Widgetbook in action:
```
cd widgetbook && flutter run
```

### Required Testing

Before committing new components:

```bash
# Run all tests (must pass)
flutter test

# Run code analysis (must pass)
dart analyze

# Format code consistently
dart format --line-length 80 lib test

# Build widgetbook for visual testing
cd widgetbook && flutter build web
```

The components will be copied directly into your project, ready to use and customize!

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[fpx_link]: https://pub.dev/packages/fpx
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
