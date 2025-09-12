import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@UseCase(
  name: 'Text Input',
  type: BaseInput,
  path: 'Components/Input/Showcase',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget textInput(BuildContext context) {
  const String placeholderText = 'Anton Harkusha';
  const String valueText = 'Anton Harkusha';
  const String errorMessage = 'Error message';
  const String helperMessage = 'Tooltip message';

  final defaultController = TextEditingController(text: valueText);
  final disabledController = TextEditingController(text: valueText);
  final errorController = TextEditingController(text: valueText);
  final helperController = TextEditingController(text: valueText);

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Text Input'],
    child: Container(
      padding: const EdgeInsets.all(24.0),
      width: 400, // Fixed width for consistent presentation
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Default State (with placeholder)
          Inputs.text(
            placeholder: placeholderText,
          ),
          const SizedBox(height: 24),

          // 2. Default State (with value)
          Inputs.text(
            controller: defaultController,
          ),
          const SizedBox(height: 24),

          // 3. Focused State
          _FocusedInputWrapper(
            builder: (context, focusNode) => Inputs.text(
              controller: defaultController,
              focusNode: focusNode,
              helperText: helperMessage,
            ),
          ),
          const SizedBox(height: 24),

          // 4. Disabled State
          Inputs.text(
            controller: disabledController,
            enabled: false,
          ),
          const SizedBox(height: 24),

          // 5. Error State
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Inputs.text(
              controller: errorController,
              validator: (_) => errorMessage,
            ),
          ),
          const SizedBox(height: 36), // More space for error text

          // 6. Helper Text State
          Inputs.text(
            controller: helperController,
            helperText: helperMessage,
          ),
        ],
      ),
    ),
  );
}

@UseCase(
  name: 'Text Area Input',
  type: BaseInput,
  path: 'Components/Input/Showcase',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget textAreaInput(BuildContext context) {
  const String placeholderText = 'Anton Harkusha';
  const String valueText = 'Anton Harkusha';
  const String errorMessage = 'Error message';
  const String helperMessage = 'Tooltip message';

  final defaultController = TextEditingController(text: valueText);
  final disabledController = TextEditingController(text: valueText);
  final errorController = TextEditingController(text: valueText);
  final helperController = TextEditingController(text: valueText);

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Text Area Input'],
    child: Container(
      padding: const EdgeInsets.all(24.0),
      width: 400, // Fixed width for consistent presentation
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Default State (with placeholder)
          Inputs.textArea(
            placeholder: placeholderText,
          ),
          const SizedBox(height: 24),

          // 2. Default State (with value)
          Inputs.textArea(
            controller: defaultController,
          ),
          const SizedBox(height: 24),

          // 3. Focused State
          _FocusedInputWrapper(
            builder: (context, focusNode) => Inputs.textArea(
              controller: defaultController,
              focusNode: focusNode,
            ),
          ),
          const SizedBox(height: 24),

          // 4. Disabled State
          Inputs.textArea(
            controller: disabledController,
            enabled: false,
          ),
          const SizedBox(height: 24),

          // 5. Error State
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Inputs.textArea(
              controller: errorController,
              validator: (_) => errorMessage,
            ),
          ),
          const SizedBox(height: 36), // More space for error textArea

          // 6. Text count state
          Inputs.textArea(
            controller: helperController,
            showCharCount: true,
          ),
          const SizedBox(height: 36),

          // 6. Text count state
          Inputs.textArea(
            controller: helperController,
            helperText: helperMessage,
          ),
        ],
      ),
    ),
  );
}

@UseCase(
  name: 'Search Input',
  type: BaseInput,
  path: 'Components/Input/Showcase',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget searchInput(BuildContext context) {
  const String placeholderText = 'Anton Harkusha';
  const String valueText = 'Anton Harkusha';

  final defaultController = TextEditingController(text: valueText);

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Search Input'],
    child: Container(
      padding: const EdgeInsets.all(24.0),
      width: 400, // Fixed width for consistent presentation
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Default State (with placeholder)
          Inputs.search(
            placeholder: placeholderText,
          ),
          const SizedBox(height: 24),

          // 2. Default State (with value)
          Inputs.search(
            controller: defaultController,
          ),
          const SizedBox(height: 24),

          // 3. Focused State
          _FocusedInputWrapper(
            builder: (context, focusNode) => Inputs.search(
              controller: defaultController,
              focusNode: focusNode,
            ),
          ),
        ],
      ),
    ),
  );
}

@UseCase(
  name: 'Passworrd Input',
  type: BaseInput,
  path: 'Components/Input/Showcase',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget passwordInput(BuildContext context) {
  const String placeholderText = 'Enter your password';
  const String valueText = 'password123';
  const String strongPassword = 'Password123@#';
  const String weakPassword = 'password';
  const String errorMessage = 'Error message';

  final defaultController = TextEditingController(text: valueText);
  final weakPasswordController = TextEditingController(text: weakPassword);
  final strongPasswordController = TextEditingController(text: strongPassword);
  final errorController = TextEditingController(text: valueText);

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Password Input'],
    child: Container(
      padding: const EdgeInsets.all(24.0),
      width: 400, // Fixed width for consistent presentation
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Default State (with placeholder)
          Inputs.password(
            placeholder: placeholderText,
            label: 'Password',
          ),
          const SizedBox(height: 24),

          // 2. Default State (with value)
          Inputs.password(
            controller: defaultController,
          ),
          const SizedBox(height: 24),

          // 3. Focused State
          _FocusedInputWrapper(
            builder: (context, focusNode) => Inputs.password(
              controller: defaultController,
              focusNode: focusNode,
            ),
          ),
          const SizedBox(height: 24),

          // 4. Error State
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Inputs.password(
              controller: errorController,
              validator: (_) => errorMessage,
            ),
          ),
          const SizedBox(height: 24),
          // 5. Default text with text visible
          Inputs.password(
            controller: defaultController,
            obscureText: false,
          ),
          const SizedBox(height: 24),

          // 6. Strength indicator with medium password
          Inputs.password(
            controller: weakPasswordController,
            showStrengthIndicator: true,
            obscureText: false,
          ),
          const SizedBox(height: 24),

          // 7. Strength indicator with medium password
          Inputs.password(
            controller: defaultController,
            showStrengthIndicator: true,
            obscureText: false,
          ),
          const SizedBox(height: 24),

          // 8. Strength indicator with Strong password
          Inputs.password(
            controller: strongPasswordController,
            showStrengthIndicator: true,
            obscureText: false,
          ),
        ],
      ),
    ),
  );
}

/// A helper widget to programmatically focus an input field on build.
class _FocusedInputWrapper extends StatefulWidget {
  final Widget Function(BuildContext, FocusNode) builder;

  const _FocusedInputWrapper({required this.builder});

  @override
  State<_FocusedInputWrapper> createState() => _FocusedInputWrapperState();
}

class _FocusedInputWrapperState extends State<_FocusedInputWrapper> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _focusNode);
  }
}
