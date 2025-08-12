# Unping UI Component Interface System

This document provides a comprehensive guide to the Unping UI component interface system, which ensures consistency, accessibility, and maintainability across all components.

## Overview

The component interface system is built around several key concepts:

1. **Interface-driven development** - All components implement well-defined interfaces
2. **Composition over inheritance** - Use mixins for shared functionality
3. **Theme-driven styling** - Consistent theming across all components
4. **Accessibility first** - Built-in support for screen readers and keyboard navigation
5. **Type-safe validation** - Comprehensive property validation with helpful error messages

## Core Interfaces

### UnpingUIComponent

The base interface that all components must implement:

```dart
abstract class UnpingUIComponent {
  Key? get key;
  bool get isInteractive;
  bool get supportsAccessibility;
  String get componentType;
  void validateProperties();
  Widget build(BuildContext context);
}
```

### Specialized Interfaces

- **DisableableComponent** - For components that can be disabled
- **ThemedComponent** - For components that support theming
- **AnimatedComponent** - For components that support animation
- **FocusableComponent** - For components that support focus
- **HoverableComponent** - For components that support hover
- **SizableComponent** - For components with size variants

## Base Classes

### BaseInteractiveComponent

For components that respond to user input (buttons, checkboxes, inputs):

```dart
class MyButton extends BaseInteractiveComponent 
    with StateVariantMixin<MyButtonState> {
  
  @override
  String get componentType => 'MyButton';
  
  @override
  bool get isDisabled => onPressed == null;
  
  // Implementation...
}
```

### BaseDisplayComponent

For display-only components (labels, badges, indicators):

```dart
class MyLabel extends BaseDisplayComponent 
    implements ThemedComponent {
  
  @override
  String get componentType => 'MyLabel';
  
  // Implementation...
}
```

### BaseContainerComponent

For container components that hold other widgets:

```dart
class MyCard extends BaseContainerComponent 
    implements SizableComponent {
  
  @override
  String get componentType => 'MyCard';
  
  @override
  ComponentSize get size => ComponentSize.md;
  
  // Implementation...
}
```

## Mixins

### StateVariantMixin

For components with multiple visual states:

```dart
mixin StateVariantMixin<T extends Enum> {
  T get currentState;
  List<T> get availableStates;
  Map<String, dynamic> getStateStyle(T state);
  void validateState();
}
```

### ForceStateMixin

Allows forcing a specific state (useful for testing and demos):

```dart
mixin ForceStateMixin<T extends Enum> on StateVariantMixin<T> {
  T? get forceState;
  T get effectiveState => forceState ?? currentState;
  bool get hasForceState => forceState != null;
}
```

### LoadingMixin

For components that support loading states:

```dart
mixin LoadingMixin {
  bool get isLoading;
  Widget? get loadingWidget;
  Widget buildDefaultLoadingIndicator();
  Widget getLoadingWidget() => loadingWidget ?? buildDefaultLoadingIndicator();
}
```

### IconPositionMixin

For components with positioned icons:

```dart
mixin IconPositionMixin {
  enum IconPosition { leading, trailing }
  
  IconPosition get iconPosition;
  Widget? get icon;
  bool get hasIcon => icon != null;
  
  List<Widget> buildContentWithIcon(Widget content, {double gap = 8.0});
}
```

### TextContentMixin

For components with text content:

```dart
mixin TextContentMixin {
  String? get text;
  String? get secondaryText;
  TextStyle? get textStyle;
  TextStyle? get secondaryTextStyle;
  
  bool get hasText => text != null && text!.isNotEmpty;
  Widget buildTextWidget({required String text, TextStyle? style, bool isPrimary = true});
  void validateTextContent();
}
```

## Theming System

### ComponentTheme

The base theme interface:

```dart
abstract class ComponentTheme {
  ComponentColors get colors;
  ComponentTypography get typography;
  ComponentSpacing get spacing;
  ComponentBorders get borders;
  ComponentAnimations get animations;
}
```

### Using Themes

```dart
// Wrap your app with a theme
UnpingUITheme(
  theme: UnpingUIThemes.dark,
  child: MyApp(),
)

// Access theme in components
final theme = UnpingUITheme.of(context);
final textStyle = theme.getTextStyle(size: ComponentSize.lg);
```

### Theme Extensions

The theme system includes helpful extensions:

```dart
// Get text style for a specific size
final style = theme.getTextStyle(
  size: ComponentSize.lg,
  weight: FontWeight.bold,
  color: Colors.red,
);

// Create decoration with theme values
final decoration = theme.createDecoration(
  backgroundColor: theme.colors.primary,
  size: ComponentSize.md,
);

// Get color for a specific state
final color = theme.getStateColor(
  state: ComponentVisualState.hovered,
  normalColor: theme.colors.primary,
);
```

## Utilities

### ComponentUtils

Utility functions for common operations:

```dart
// Size-based utilities
final fontSize = ComponentUtils.getFontSizeForSize(ComponentSize.md);
final padding = ComponentUtils.getPaddingForSize(ComponentSize.lg);
final borderRadius = ComponentUtils.getBorderRadiusForSize(ComponentSize.sm);

// Style creation
final decoration = ComponentUtils.createStandardDecoration(
  backgroundColor: Colors.blue,
  borderColor: Colors.grey,
  borderRadius: 8.0,
);

final textStyle = ComponentUtils.createStandardTextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);
```

### ComponentValidation

Type-safe validation utilities:

```dart
@override
void validateProperties() {
  super.validateProperties();
  
  ComponentValidation.validateRange(opacity, 0.0, 1.0, 'opacity');
  ComponentValidation.validatePositiveDuration(animationDuration, 'animationDuration');
  ComponentValidation.validateColorOpacity(textColor, 'textColor');
  ComponentValidation.validateEnumValue(size, ComponentSize.values, 'size');
}
```

### AccessibilityUtils

Accessibility helper functions:

```dart
// Create semantic properties
final semantics = AccessibilityUtils.createInteractiveSemantics(
  label: 'Submit button',
  hint: 'Submits the form',
  enabled: !isDisabled,
);

// Wrap with semantics
final accessibleWidget = AccessibilityUtils.wrapWithSemantics(
  label: 'Settings',
  child: myWidget,
);
```

## Component Development Workflow

### 1. Choose the Right Base Class

- **Interactive components** → `BaseInteractiveComponent`
- **Display components** → `BaseDisplayComponent`
- **Container components** → `BaseContainerComponent`

### 2. Add Required Mixins

```dart
class MyComponent extends BaseInteractiveComponent
    with
        StateVariantMixin<MyComponentState>,
        ForceStateMixin<MyComponentState>,  // For testing/demos
        LoadingMixin,                       // If supports loading
        IconPositionMixin,                  // If has icons
        TextContentMixin                    // If has text
    implements
        SizableComponent,                   // If has size variants
        ThemedComponent {                   // For theming support
  
  // Implementation...
}
```

### 3. Implement Required Interface Methods

```dart
@override
String get componentType => 'MyComponent';

@override
bool get isDisabled => onPressed == null;

@override
MyComponentState get currentState => _calculateCurrentState();

@override
List<MyComponentState> get availableStates => MyComponentState.values;

@override
void validateProperties() {
  super.validateProperties();
  // Add custom validation
}

@override
Map<String, dynamic> getStateStyle(MyComponentState state) {
  // Return styling for each state
}
```

### 4. Create Factory Methods

```dart
class MyComponents {
  static MyComponent primary({
    String? text,
    VoidCallback? onPressed,
    ComponentSize size = ComponentSize.md,
  }) {
    return MyComponent(
      text: text,
      onPressed: onPressed,
      size: size,
      backgroundColor: const Color(0xFF3B4554),
      textColor: const Color(0xFFFFFFFF),
    );
  }
  
  static MyComponent secondary({...}) => MyComponent(...);
  static MyComponent outline({...}) => MyComponent(...);
}
```

### 5. Add Comprehensive Tests

```dart
group('MyComponent', () {
  test('implements UnpingUIComponent interface', () {
    final component = MyComponent();
    expect(component, isA<UnpingUIComponent>());
    expect(component.componentType, 'MyComponent');
  });
  
  test('validates properties correctly', () {
    expect(() => MyComponent().validateProperties(), returnsNormally);
  });
  
  test('handles all states correctly', () {
    for (final state in MyComponentState.values) {
      final style = MyComponent().getStateStyle(state);
      expect(style, isNotEmpty);
    }
  });
  
  // Add more tests...
});
```

### 6. Create Widgetbook Stories

```dart
@UseCase(name: 'Primary', type: MyComponent)
Widget myComponentPrimary(BuildContext context) {
  return MyComponents.primary(
    text: 'Primary Button',
    onPressed: () {},
  );
}

@UseCase(name: 'All States', type: MyComponent)
Widget myComponentStates(BuildContext context) {
  return Column(
    children: MyComponentState.values.map((state) =>
      MyComponent(
        text: state.name,
        forceState: state,
        onPressed: () {},
      ),
    ).toList(),
  );
}
```

## Standard Patterns

### State Management

```dart
enum MyComponentState {
  normal,
  hovered,
  focused,
  pressed,
  disabled,
}

MyComponentState get _effectiveState {
  if (hasForceState) return effectiveState;
  if (isDisabled) return MyComponentState.disabled;
  if (_isFocused) return MyComponentState.focused;
  if (_isHovered) return MyComponentState.hovered;
  if (_isPressed) return MyComponentState.pressed;
  return MyComponentState.normal;
}
```

### Animation Patterns

```dart
class _MyComponentState extends State<MyComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ));
  }
  
  // Handle animation triggers...
}
```

### Accessibility Patterns

```dart
Widget build(BuildContext context) {
  Widget child = // ... component implementation

  if (!isDisabled) {
    child = Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _handleTap,
          child: child,
        ),
      ),
    );
  }

  return Semantics(
    label: semanticLabel ?? text,
    button: true,
    enabled: !isDisabled,
    child: child,
  );
}
```

## Benefits

### For Developers

- **Consistency** - All components follow the same patterns
- **Productivity** - Templates and utilities speed up development
- **Quality** - Built-in validation and testing patterns
- **Maintenance** - Easier to update and refactor components

### For Users

- **Accessibility** - Screen reader support, keyboard navigation
- **Theming** - Consistent visual design across components
- **Performance** - Optimized animations and rendering
- **Reliability** - Comprehensive testing and validation

### For the Library

- **Scalability** - Easy to add new components
- **Documentation** - Self-documenting interfaces
- **Testing** - Automated interface compliance checking
- **Evolution** - Easy to extend and improve the system

## Migration Guide

For existing components, migration can be done incrementally:

1. **Add interface implementation** without changing existing API
2. **Add validation** using ComponentValidation utilities
3. **Add theming support** while maintaining custom styling options
4. **Add accessibility features** using AccessibilityUtils
5. **Update tests** to check interface compliance
6. **Create factory methods** using the new patterns

See `example_interface_migration.dart` for a complete migration example.