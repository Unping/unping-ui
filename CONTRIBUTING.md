# Contributing to Unping UI

Thank you for your interest in contributing to Unping UI! We welcome contributions from everyone. This document outlines the process for contributing to our Flutter widget library.

## 🤝 How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check if the issue already exists in our [GitHub Issues](https://github.com/unping/unping-ui/issues)
2. If not, create a new issue with:
   - A clear, descriptive title
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Flutter version and platform information
   - Screenshots or code examples when relevant

### Contributing Code

We follow the standard GitHub workflow:

1. **Fork the repository** to your GitHub account
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/unping-ui.git
   cd unping-ui
   ```
3. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes** following our development guidelines
5. **Test your changes** thoroughly
6. **Commit your changes** with descriptive commit messages
7. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```
8. **Create a Pull Request** from your fork to our main repository

## 🛠️ Development Setup

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)

### Getting Started

1. **Install dependencies:**
   ```bash
   dart pub get
   ```

3. **Set up Widgetbook for development:**
   ```bash
   cd widgetbook
   dart pub get
   dart run build_runner build -d
   ```

3. **Run Widgetbook for testing:**
   ```bash
   cd widgetbook
   flutter run
   ```

## 📋 Development Guidelines

### Required Before Each Commit

- ✅ Run `flutter test` successfully
- ✅ Ensure all components are without errors
- ✅ Run `dart analyze` to ensure code quality
- ✅ Run `dart format --line-length 80 lib test` to format code consistently
- ✅ Update README.md when adding new functionality
- ✅ Add new widgets to Widgetbook

### Code Standards

**Styling Guidelines:**
- Do not use external styling themes or Material Design components
- Use Flutter's built-in theming system
- Use values from `UiColors`, `UiTextStyles`, `UiSpacing`, `UiBorderRadius` (found in `lib/src/foundation/`)
- Avoid hardcoded values - if a needed value is missing, hardcode it only once in the component

**Architecture Patterns:**
- Follow Flutter/Dart best practices
- Use proper State management techniques (widget state, Cubit, or Bloc as appropriate)
- Components should be modular and follow single-responsibility principle
- Avoid duplicate code, re-use components when possible
- Use proper widget composition patterns

**Naming Conventions:**
- Use camelCase for variables and functions
- Use PascalCase for classes and widgets
- Use descriptive names that clearly indicate purpose

### Adding New Widgets

When adding a new widget:

1. **Place the widget** in the appropriate `lib/src/` directory
2. **Export the widget** in `lib/unping_ui.dart`
3. **Create widget tests** in the corresponding `test/src/` directory
4. **Add to Widgetbook** by creating a story in `widgetbook/lib/`
5. **Generate Widgetbook code**:
   ```bash
   cd widgetbook && dart run build_runner build -d
   ```
6. **Update documentation** as needed

### Testing Requirements

- Write widget tests for all new components using `flutter_test`
- Test different widget states (loading, error, success)
- Test user interactions and animations
- Ensure proper test coverage
- All tests must pass before submitting PR

### Widgetbook Integration

- Every new widget must have a corresponding Widgetbook story
- Use `@UseCase` annotations for Widgetbook stories
- Show different variants and states of widgets
- Include knobs for interactive properties when relevant

## 📝 Pull Request Guidelines

### Before Submitting

- Ensure your branch is up to date with `main`
- All tests pass locally
- Code is properly formatted and analyzed
- Documentation is updated if needed
- Widgetbook stories are added for new components

### PR Description

Include in your pull request:

- **Summary** of changes made
- **Type of change** (bug fix, new feature, breaking change, documentation)
- **Testing** performed
- **Screenshots** for UI changes
- **Breaking changes** (if any) and migration guide

### Review Process

1. Automated checks will run (tests, linting, formatting)
2. Maintainers will review your code
3. Address any requested changes
4. Once approved, your PR will be merged

## 🎯 Types of Contributions

We welcome various types of contributions:

- **🐛 Bug fixes** - Fix existing issues
- **✨ New widgets** - Add new UI components
- **📚 Documentation** - Improve docs, add examples
- **🧪 Tests** - Add or improve test coverage
- **🔧 Tooling** - Improve development tools and processes
- **🎨 Design** - Improve Figma design system integration

## 📖 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Widgetbook Documentation](https://docs.widgetbook.io/)

## 💬 Questions or Need Help?

- Create an issue for questions about the codebase
- Check existing issues and discussions
- Review this contributing guide and project documentation

## 📜 Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please be respectful and inclusive in all interactions.

## 🙏 Recognition

Contributors will be recognized in our documentation and releases. Thank you for helping make Unping UI better for everyone!

---

**Happy Contributing! 🚀**
