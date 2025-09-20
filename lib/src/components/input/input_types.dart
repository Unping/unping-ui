import 'package:flutter/material.dart';
import 'package:unping_ui/src/components/input/base_input.dart';

/// Defines the various types of input fields available for use in input components.
enum InputTypes {
  /// A standard single-line text input field.
  text,

  /// A multi-line text area input field.
  textArea,

  /// An input field optimized for search functionality.
  search,

  /// An input field for entering and obscuring passwords.
  password,
}

/// Represents the visual display states for an input component.
enum InputDisplayState {
  /// The input is enabled and ready for user interaction.
  enabled,

  ///  The input is currently focused by the user.
  focused,

  /// The input has encountered a validation error.
  error,

  /// The input is disabled and cannot be interacted with.
  disabled,
}

/// Defines the available sizes for input components.
enum InputSize {
  /// Small size input.
  sm,

  /// Medium size input (default).
  md,

  /// Large size input.
  lg
}

/// Enum to represent the different levels of password security.
enum PasswordStrength {
  /// For when the input is empty.
  None,

  /// Low score.
  Weak,

  /// Medium score.
  Medium,

  /// High score.
  Strong,
}

class TextInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputSize size;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const TextInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.validator,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = InputSize.md,
    this.onChanged,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: _controller,
      focusNode: _focusNode,
      label: widget.label,
      placeholder: widget.placeholder,
      enabled: widget.enabled,
      validator: widget.validator,
      helperText: widget.helperText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      size: widget.size,
      onChanged: widget.onChanged,
    );
  }
}

class TextArea extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  final bool showCharCount;
  final bool enabled;
  final String? Function(String?)? validator;

  const TextArea({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.controller,
    this.focusNode,
    this.maxLength,
    this.minLines = 3,
    this.maxLines = 8,
    this.showCharCount = false,
    this.validator,
    this.enabled = true,
  });

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _charCount = _controller.text.length;
    _controller.addListener(_onTextChanged);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  void _onTextChanged() {
    setState(() {
      _charCount = _controller.text.length;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? helperText = widget.helperText;
    if (widget.showCharCount) {
      helperText = widget.maxLength != null
          ? '$_charCount / ${widget.maxLength}'
          : '$_charCount';
    }

    return BaseInput(
      controller: _controller,
      focusNode: _focusNode,
      label: widget.label,
      placeholder: widget.placeholder,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      helperText: helperText,
      validator: widget.validator,
      enabled: widget.enabled,
    );
  }
}

class SearchInput extends StatefulWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmit;

  const SearchInput({
    super.key,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.onSubmit,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _showClearButton = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  void _onTextChanged() {
    if (_showClearButton != _controller.text.isNotEmpty) {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    }
    widget.onSubmit?.call(_controller.text);
  }

  void _clearText() {
    _controller.clear();
    widget.onSubmit?.call('');
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: _controller,
      focusNode: _focusNode,
      placeholder: widget.placeholder,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: _showClearButton
          ? IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: _clearText,
              splashRadius: 20,
            )
          : null,
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  /// If true, a helper text will appear showing the calculated password strength.
  final bool showStrengthIndicator;
  final bool obscureText;

  const PasswordInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.showStrengthIndicator = false,
    this.obscureText = true,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _obscureText = true;
  PasswordStrength _strength = PasswordStrength.None;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
    _obscureText = widget.obscureText;
    // Add a listener to check strength on every text change.
    if (widget.showStrengthIndicator) {
      _controller.addListener(_onPasswordChanged);
      // Check initial strength in case there's a pre-filled value.
      _onPasswordChanged();
    }
  }

  @override
  void dispose() {
    if (widget.showStrengthIndicator) {
      _controller.removeListener(_onPasswordChanged);
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Called on every text change to re-evaluate the password strength.
  void _onPasswordChanged() {
    final password = _controller.text;
    if (mounted) {
      setState(() {
        _strength = _checkPasswordStrength(password);
      });
    }
  }

  /// Calculates the strength of a password based on a scoring system.
  PasswordStrength _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrength.None;
    }

    int score = 0;
    // Regex for different character types
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigits = RegExp(r'[0-9]');
    final hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    // Rule 1: Length
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Rule 2: Character variety
    if (hasUppercase.hasMatch(password)) score++;
    if (hasLowercase.hasMatch(password)) score++;
    if (hasDigits.hasMatch(password)) score++;
    if (hasSpecialChars.hasMatch(password)) score++;

    // Convert score to strength level
    if (score < 3) return PasswordStrength.Weak;
    if (score < 5) return PasswordStrength.Medium;
    return PasswordStrength.Strong;
  }

  /// Builds the helper text string based on the current strength.
  /// Returns null if the indicator should not be shown.
  String? _getStrengthHelperText() {
    if (!widget.showStrengthIndicator) {
      return null;
    }

    switch (_strength) {
      case PasswordStrength.Weak:
        return 'Strength: Weak';
      case PasswordStrength.Medium:
        return 'Strength: Medium';
      case PasswordStrength.Strong:
        return 'Strength: Strong';
      case PasswordStrength.None:
        return null;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The validator's error text takes precedence over the strength indicator.
    // The BaseInput component's logic should already handle this if it prioritizes
    // validator's errorText over helperText.
    final helperText = _getStrengthHelperText();

    return BaseInput(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      label: widget.label,
      placeholder: widget.placeholder,
      validator: widget.validator,
      obscureText: _obscureText,
      // Pass the generated helper text to BaseInput.
      helperText: helperText,
      onChanged: widget.onChanged,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: _toggleVisibility,
        splashRadius: 20,
      ),
    );
  }
}
