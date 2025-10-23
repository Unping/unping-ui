# Unping UI

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL_2.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

Desktop & Web first flutter components to build your component library with. Customizable, extendable, tested.

## 🌟 Live Demo

Explore our component library in action at [widgetbook.unping-ui.com](https://widgetbook.unping-ui.com) to see all components and their variations!

![Unping UI Components Demo](assets/images/widgetbook-demo.gif)

## Design Resources 🎨

Check out our complete design system and component library in Figma:

[![Figma Design System](https://img.shields.io/badge/Figma-Design%20System-F24E1E?style=for-the-badge&logo=figma&logoColor=white)](https://www.figma.com/community/file/1545817431010952080)

## Installation 💻

**❗ In order to start using Unping Ui you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Unping UI can be used in two ways:

### Option 1: Using fpx (Recommended for customization)

Use [fpx][fpx_link] (Flutter Paste X) to copy and paste components directly into your project for maximum customization:

1. **Install fpx globally:**
   ```sh
   dart pub global activate fpx
   ```

2. **Add the unping-ui repository to fpx:**
   ```sh
   fpx repository add --url https://github.com/unping/unping-ui --name unping-ui
   ```

3. **Use fpx to paste components from unping-ui into your project:**
   ```sh
   fpx add <component_name>
   ```

### Option 2: Using as a pub.dev dependency

Add Unping UI as a dependency to use pre-built components directly:

1. **Add unping_ui to your pubspec.yaml:**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     unping_ui: ^0.2.0
   ```

2. **Install the package:**
   ```sh
   flutter pub get
   ```

3. **Import and use components in your code:**
   ```dart
   import 'package:flutter/material.dart';
   import 'package:unping_ui/unping_ui.dart';

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: Scaffold(
           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 // Filled button
                 Buttons.filled(
                   text: 'Click me',
                   onPressed: () {
                     print('Button pressed!');
                   },
                 ),
                 SizedBox(height: 16),
                 // Outline button with icon
                 Buttons.outline(
                   text: 'Outline Button',
                   icon: Icon(Icons.star, size: 16),
                   iconPosition: IconPosition.leading,
                   onPressed: () {
                     print('Outline button pressed!');
                   },
                 ),
                 SizedBox(height: 16),
                 // Ghost button
                 Buttons.ghost(
                   text: 'Ghost Button',
                   onPressed: () {
                     print('Ghost button pressed!');
                   },
                 ),
               ],
             ),
           ),
         ),
       );
     }
   }
   ```

**💡 Pro tip:** Check out our [widgetbook examples](https://github.com/unping/unping-ui/tree/main/widgetbook) for more comprehensive usage examples and component configurations!

## Examples & Documentation 📚

### Widgetbook Examples
The `widgetbook/` folder in this repository serves as a comprehensive example collection. It contains:

- **Showcase examples**: Demonstrating real-world usage patterns for each component
- **Configurable examples**: Interactive examples showing all available properties and customization options
- **Foundation examples**: Typography, colors, spacing, and other design system tokens

You can explore these examples in several ways:

1. **Online**: Visit [widgetbook.unping-ui.com](https://widgetbook.unping-ui.com) to see all components in action
2. **Locally**: Clone the repository and run the widgetbook app:
   ```sh
   git clone https://github.com/unping/unping-ui.git
   cd unping-ui/widgetbook
   flutter run
   ```
3. **Code reference**: Browse the [widgetbook source code](https://github.com/unping/unping-ui/tree/main/widgetbook/lib) for implementation details

## Usage 🚀

### With fpx (Copy & Paste)

Once fpx is set up, you can browse and add any component from the unping-ui library:

```sh
# List all available components
fpx list

# Add a specific component to your project
fpx add button
fpx add card
fpx add input_field
```

### With pub.dev dependency

Import the package and use components directly:

```dart
import 'package:unping_ui/unping_ui.dart';

// Use predefined button styles
Buttons.filled(text: 'Save', onPressed: () {});
Buttons.outline(text: 'Cancel', onPressed: () {});
Buttons.ghost(text: 'Learn More', onPressed: () {});

// Or create custom BaseButton configurations
BaseButton(
  text: 'Custom Button',
  backgroundColor: UiColors.primary,
  textColor: UiColors.onPrimary,
  onPressed: () {},
)
```

## Develop new widgets

For adding new widgets, place them in lib/ folder. And don't forget to add them to th widgetbook app. Add a wrapper in widgetbook/lib for your new widget.
After adding a widget, don't forget to trigger the code generation for widgetbook:
```sh
cd widgetbook && dart run build_runner build -d
```

To see Widgetbook in action:
```sh
cd widgetbook && flutter run
```

The components will be copied directly into your project, ready to use and customize!

## Contributing 🤝

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on how to submit pull requests, report issues, and contribute to the project.

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[fpx_link]: https://pub.dev/packages/fpx
[license_link]: https://opensource.org/license/mpl-2-0
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
