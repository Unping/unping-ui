This is a widget library for Flutter, similar to shadcn/ui for React. Unping-UI provides copy & paste ready widgets that can be used in Flutter projects. It is designed to be customizable, extendable, and tested.
We use pub.dev for managing our Dart dependencies.
We use fpx (Flutter Paste X) for managing our Flutter components, allowing easy addition of components to projects.
We use Widgetbook for developing and testing new widgets in isolation. And especially we use widgetbook to showcase our widgets to the world. Make sure to add new widgets to widgetbook. We need to keep the widgetbook app in sync with our available widgets.

# Required before each commit
- run "dart test" successfully
- make sure all components are without errors
- when adding new functionality, make sure to update the README.md
- Ensure all tests pass by running "dart test"
- Run "dart analyze" to ensure code quality
- Run "dart format ." to format code consistently

# Software development patterns
- Follow Flutter/Dart best practices
- Use proper State management techniques (widget state, Cubit, or Bloc as appropriate)
- Components should be modular and follow single-responsibility principle
- Avoid duplicate code, re-use components when possible, if needed add small adjustments to components
- Avoid huge refactors, prefer smaller easy to review changes, even when it's adding some tech debt
- Use proper widget composition patterns

# Styling
- Do not use external Styling themes
- Do not use Material Design components
- Use Flutter's built-in theming system
- Create reusable theme configurations
- Use consistent color schemes and typography
- Leverage Flutter's widget system for styling rather than external Styles

# Development flow
- Install dependencies: dart pub get
- Development/testing: dart test
- Format code: dart format .
- Analyze code: dart analyze
- Build widgetbook web: cd widgetbook && flutter build web
- Run widgetbook: cd widgetbook && flutter run
- We always add proper widget tests to new UI functionalities

# Key Guidelines
- Use proper error handling with try-catch blocks
- For loading states, use Flutter's built-in loading indicators or create consistent loading widgets
- For error states, create reusable error display widgets
- Always add widgets to the main library export in lib/unping_ui.dart
- Create corresponding widgetbook stories for new widgets in widgetbook/lib/
- Follow Dart naming conventions (camelCase for variables, PascalCase for classes)
- Use proper documentation comments (///) for public APIs
- Ensure widgets are accessible and follow Flutter accessibility guidelines

# Testing
- Write widget tests for all new components
- Use flutter_test package for testing
- Test different widget states (loading, error, success)
- Test user interactions and animations
- Ensure proper test coverage

# Widgetbook Integration
- Every new widget must have a corresponding widgetbook story
- Use @UseCase annotations for widgetbook stories
- Show different variants and states of widgets
- Include knobs for interactive properties when relevant