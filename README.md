# Unping UI

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Desktop & Web first flutter components to build your component library with. Customizable, extendable, tested.

## Design Resources 🎨

Check out our complete design system and component library in Figma:

[![Figma Design System](https://img.shields.io/badge/Figma-Design%20System-F24E1E?style=for-the-badge&logo=figma&logoColor=white)](https://www.figma.com/community/file/1545817431010952080)

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

## Develop new widgets

For adding new widgets, place them in lib/ folder. And don't forget to add them to th widgetbook app. Add a wrapper in widgetbook/lib for your new widget.
After adding a widget, don't forget to trigger the code generation for widgetbook:
```
cd widgetbook && dart run build_runner build -d
```

To see Widgetbook in action:
```
cd widgetbook && flutter run
```

The components will be copied directly into your project, ready to use and customize!

## Contributing 🤝

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on how to submit pull requests, report issues, and contribute to the project.

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[fpx_link]: https://pub.dev/packages/fpx
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
