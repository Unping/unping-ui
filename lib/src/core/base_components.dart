import 'package:flutter/widgets.dart';
import 'component_interface.dart';

/// Abstract base class for interactive components (buttons, checkboxes, etc.)
abstract class BaseInteractiveComponent extends StatefulWidget
    implements
        UnpingUIComponent,
        DisableableComponent,
        FocusableComponent,
        HoverableComponent,
        AnimatedComponent {
  const BaseInteractiveComponent({super.key});

  @override
  bool get isInteractive => true;

  @override
  bool get supportsAccessibility => true;

  /// Whether the component is currently enabled (opposite of disabled)
  bool get isEnabled => !isDisabled;

  /// Whether the component can receive focus when enabled
  @override
  bool get canFocus => isEnabled;

  /// Whether the component responds to hover when enabled
  @override
  bool get canHover => isEnabled;

  /// Default disabled opacity
  @override
  double get disabledOpacity => 0.4;

  /// Default animation duration
  @override
  Duration get animationDuration => const Duration(milliseconds: 200);

  /// Default animation curve
  @override
  Curve get animationCurve => Curves.easeInOut;

  /// Default animations enabled
  @override
  bool get animationsEnabled => true;

  /// Default focus ring width
  @override
  double get focusRingWidth => 3.0;

  /// Validate that required properties are set correctly
  @override
  void validateProperties() {
    // Base validation - can be overridden by subclasses
    assert(animationDuration.inMicroseconds > 0, 'Animation duration must be positive');
    assert(focusRingWidth >= 0, 'Focus ring width must be non-negative');
    assert(disabledOpacity >= 0 && disabledOpacity <= 1, 'Disabled opacity must be between 0 and 1');
  }
}

/// Abstract base class for display-only components (badges, labels, etc.)
abstract class BaseDisplayComponent extends StatelessWidget
    implements UnpingUIComponent, ThemedComponent {
  const BaseDisplayComponent({super.key});

  @override
  bool get isInteractive => false;

  @override
  bool get supportsAccessibility => true;

  /// Default validation for display components
  @override
  void validateProperties() {
    // Base validation - can be overridden by subclasses
  }
}

/// Abstract base class for container components that hold other widgets
abstract class BaseContainerComponent extends StatelessWidget
    implements UnpingUIComponent, SizableComponent {
  const BaseContainerComponent({super.key});

  @override
  bool get isInteractive => false;

  @override
  bool get supportsAccessibility => true;

  /// Default component size
  @override
  ComponentSize get size => ComponentSize.md;

  /// Default validation for container components
  @override
  void validateProperties() {
    // Base validation - can be overridden by subclasses
  }
}

/// Mixin for components that support state variants
mixin StateVariantMixin<T extends Enum> {
  /// Current state of the component
  T get currentState;

  /// Available states for this component type
  List<T> get availableStates;

  /// Get styling for a specific state
  Map<String, dynamic> getStateStyle(T state);

  /// Validate that the current state is valid
  void validateState() {
    assert(
      availableStates.contains(currentState),
      'Current state $currentState is not in available states $availableStates',
    );
  }
}

/// Mixin for components that support forced states (for testing/demos)
mixin ForceStateMixin<T extends Enum> on StateVariantMixin<T> {
  /// Forced state that overrides normal state detection
  T? get forceState;

  /// Get the effective state (forced state takes precedence)
  T get effectiveState => forceState ?? currentState;

  /// Whether a state is being forced
  bool get hasForceState => forceState != null;

  @override
  void validateState() {
    super.validateState();
    if (forceState != null) {
      assert(
        availableStates.contains(forceState),
        'Forced state $forceState is not in available states $availableStates',
      );
    }
  }
}

/// Mixin for components that support loading states
mixin LoadingMixin {
  /// Whether the component is in a loading state
  bool get isLoading;

  /// Custom loading widget (if null, uses default)
  Widget? get loadingWidget;

  /// Build the default loading indicator
  Widget buildDefaultLoadingIndicator();

  /// Get the effective loading widget
  Widget getLoadingWidget() => loadingWidget ?? buildDefaultLoadingIndicator();

  /// Whether the component should be disabled while loading
  bool get disableWhileLoading => true;
}

/// Mixin for components that support icon positioning
mixin IconPositionMixin {
  /// Available icon positions
  enum IconPosition {
    /// Icon appears before content
    leading,
    /// Icon appears after content
    trailing,
  }

  /// Current icon position
  IconPosition get iconPosition;

  /// Icon widget (if any)
  Widget? get icon;

  /// Whether the component has an icon
  bool get hasIcon => icon != null;

  /// Build content with icon positioned correctly
  List<Widget> buildContentWithIcon(Widget content, {double gap = 8.0}) {
    if (!hasIcon) return [content];

    final children = <Widget>[];
    
    if (iconPosition == IconPosition.leading) {
      children.add(icon!);
      children.add(SizedBox(width: gap));
      children.add(content);
    } else {
      children.add(content);
      children.add(SizedBox(width: gap));
      children.add(icon!);
    }

    return children;
  }
}

/// Mixin for components that support multiple content slots
mixin MultiSlotMixin {
  /// Get all content slots as a map
  Map<String, Widget?> get contentSlots;

  /// Get non-null content slots
  Map<String, Widget> get activeSlots {
    final active = <String, Widget>{};
    for (final entry in contentSlots.entries) {
      if (entry.value != null) {
        active[entry.key] = entry.value!;
      }
    }
    return active;
  }

  /// Whether a specific slot has content
  bool hasContentInSlot(String slotName) {
    return contentSlots[slotName] != null;
  }

  /// Get content for a specific slot
  Widget? getSlotContent(String slotName) {
    return contentSlots[slotName];
  }
}

/// Mixin for components that support text content
mixin TextContentMixin {
  /// Primary text content
  String? get text;

  /// Optional secondary text content
  String? get secondaryText;

  /// Text style for primary content
  TextStyle? get textStyle;

  /// Text style for secondary content
  TextStyle? get secondaryTextStyle;

  /// Whether the component has primary text
  bool get hasText => text != null && text!.isNotEmpty;

  /// Whether the component has secondary text
  bool get hasSecondaryText => secondaryText != null && secondaryText!.isNotEmpty;

  /// Build text widget with proper styling
  Widget buildTextWidget({
    required String text,
    TextStyle? style,
    bool isPrimary = true,
  }) {
    return Text(
      text,
      style: style ?? (isPrimary ? textStyle : secondaryTextStyle),
    );
  }

  /// Validate text content
  void validateTextContent() {
    if (hasText) {
      assert(text!.trim().isNotEmpty, 'Text content should not be empty or whitespace only');
    }
    if (hasSecondaryText) {
      assert(secondaryText!.trim().isNotEmpty, 'Secondary text content should not be empty or whitespace only');
    }
  }
}