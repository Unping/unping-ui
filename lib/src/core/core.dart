/// Core interfaces and utilities for Unping UI components.
/// 
/// This module provides the foundational interfaces, base classes, and utilities
/// that ensure consistency across all Unping UI components.
///
/// ## Key Components
///
/// ### Interfaces
/// - [UnpingUIComponent] - Base interface for all components
/// - [DisableableComponent] - Interface for components that can be disabled
/// - [ThemedComponent] - Interface for components that support theming
/// - [AnimatedComponent] - Interface for components that support animation
/// - [FocusableComponent] - Interface for components that support focus
/// - [HoverableComponent] - Interface for components that support hover
/// - [SizableComponent] - Interface for components with size variants
///
/// ### Base Classes
/// - [BaseInteractiveComponent] - Base class for interactive components
/// - [BaseDisplayComponent] - Base class for display-only components
/// - [BaseContainerComponent] - Base class for container components
///
/// ### Mixins
/// - [StateVariantMixin] - Mixin for components with state variants
/// - [ForceStateMixin] - Mixin for forcing states (testing/demos)
/// - [LoadingMixin] - Mixin for components with loading states
/// - [IconPositionMixin] - Mixin for components with positioned icons
/// - [MultiSlotMixin] - Mixin for components with multiple content slots
/// - [TextContentMixin] - Mixin for components with text content
///
/// ### Utilities
/// - [ComponentUtils] - Utility functions for common component operations
/// - [ComponentVariants] - Factory methods for creating standard configurations
/// - [ComponentValidation] - Validation utilities for component properties
/// - [AccessibilityUtils] - Helper functions for accessibility features
/// - [ComponentDocumentation] - Templates for consistent documentation
///
/// ### Theming
/// - [ComponentTheme] - Base theme interface
/// - [DefaultComponentTheme] - Default theme implementation
/// - [UnpingUITheme] - Theme provider widget
/// - [UnpingUIThemes] - Predefined theme configurations
///
/// ## Usage
///
/// ### Creating a New Component
///
/// 1. **Extend the appropriate base class:**
/// ```dart
/// class MyComponent extends BaseInteractiveComponent
///     with StateVariantMixin<MyComponentState> {
///   // Component implementation
/// }
/// ```
///
/// 2. **Implement required interfaces:**
/// ```dart
/// @override
/// String get componentType => 'MyComponent';
/// 
/// @override
/// void validateProperties() {
///   super.validateProperties();
///   // Add custom validation
/// }
/// ```
///
/// 3. **Use the component template as a guide:**
/// See [component_template.dart] for a complete implementation example.
///
/// ### Using Themes
///
/// ```dart
/// // Wrap your app with a theme
/// UnpingUITheme(
///   theme: UnpingUIThemes.dark,
///   child: MyApp(),
/// )
///
/// // Access theme in components
/// final theme = UnpingUITheme.of(context);
/// ```
///
/// ### Validation and Testing
///
/// ```dart
/// // Validate component properties
/// ComponentValidation.validateRange(value, min, max, 'propertyName');
/// 
/// // Test component interface compliance
/// test('component implements interface correctly', () {
///   final component = MyComponent();
///   expect(component, isA<UnpingUIComponent>());
///   expect(component.componentType, 'MyComponent');
/// });
/// ```
///
/// ## Design Principles
///
/// 1. **Consistency** - All components follow the same patterns
/// 2. **Accessibility** - Built-in support for screen readers and keyboard navigation
/// 3. **Theming** - Consistent visual design across components
/// 4. **Validation** - Comprehensive property validation
/// 5. **Documentation** - Clear documentation and examples
/// 6. **Testing** - Interface compliance and behavior testing
///
/// ## Contributing
///
/// When adding new components:
/// 1. Follow the interface contracts
/// 2. Use the provided mixins for common functionality
/// 3. Add comprehensive tests
/// 4. Update documentation
/// 5. Create Widgetbook stories for visual testing
library;

export 'component_interface.dart';
export 'base_components.dart';
export 'component_utils.dart';
export 'default_theme.dart';
export 'component_template.dart';