import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';



/// Helper function to create badge widgets based on type
class ConfigurableInputWidget extends StatefulWidget {
  final InputTypes widgetType;
  final InputDisplayState state;
  final InputSize size;
  final bool hasLabel;
  final bool hasPlaceholder;
  final bool hasHelperText;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final String labelText;
  final String placeholderText;
  final String helperErrorText;
  final int? minLines;

  const ConfigurableInputWidget({
    super.key,
    required this.widgetType,
    required this.state,
    required this.size,
    required this.hasLabel,
    required this.hasPlaceholder,
    required this.hasHelperText,
    required this.hasPrefixIcon,
    required this.hasSuffixIcon,
    required this.labelText,
    required this.placeholderText,
    required this.helperErrorText,
    this.minLines,
  });

  @override
  State<ConfigurableInputWidget> createState() =>
      _ConfigurableInputWidgetState();
}

class _ConfigurableInputWidgetState extends State<ConfigurableInputWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Set some initial text so the field isn't empty
    _controller.text = "Anton Harkusha";

    // Defer the focus request to after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _manageFocus();
    });
  }

  @override
  void didUpdateWidget(covariant ConfigurableInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Manage focus whenever the state knob changes
    if (widget.state != oldWidget.state) {
      _manageFocus();
    }
  }

  void _manageFocus() {
    if (widget.state == InputDisplayState.focused) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isError = widget.state == InputDisplayState.error;
    final bool isEnabled = widget.state != InputDisplayState.disabled;
    return Container(
      padding: const EdgeInsets.all(16),
      width: 400,
      child: Form(
        autovalidateMode: widget.state == InputDisplayState.error
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: Row(
          children: [
            Expanded(
              child: switch (widget.widgetType) {
                InputTypes.text => Inputs.text(
                    size: widget.size,
                    enabled: isEnabled,
                    label: widget.hasLabel ? widget.labelText : null,
                    placeholder:
                        widget.hasPlaceholder ? widget.placeholderText : null,
                    validator: (_) => isError ? widget.helperErrorText : null,
                    helperText: !isError && widget.hasHelperText
                        ? widget.helperErrorText
                        : null,
                    prefixIcon:
                        widget.hasPrefixIcon ? const Icon(Icons.search) : null,
                    suffixIcon: widget.hasSuffixIcon
                        ? const Icon(Icons.info_outline)
                        : null,
                    // The wrapper manages these internally
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                InputTypes.password => Inputs.password(
                    focusNode: _focusNode,
                    controller: _controller,
                    label: widget.hasLabel ? widget.labelText : null,
                    placeholder:
                        widget.hasPlaceholder ? widget.placeholderText : null,
                    validator: (_) => isError ? widget.helperErrorText : null,
                  ),
                InputTypes.textArea => Inputs.textArea(
                    focusNode: _focusNode,
                    controller: _controller,
                    label: widget.hasLabel ? widget.labelText : null,
                    placeholder:
                        widget.hasPlaceholder ? widget.placeholderText : null,
                    minLines: widget.minLines,
                    validator: (_) => isError ? widget.helperErrorText : null,
                  ),
                InputTypes.search => Inputs.search(
                    controller: _controller,
                    placeholder:
                        widget.hasPlaceholder ? widget.placeholderText : null,
                    focusNode: _focusNode,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'ConfigurableInput',
  type: BaseInput,
  path: 'Components/Input/Configurable',
  designLink:
      'https://www.figma.com/design/D1jFOBHi38okdjyBFwN97c/unping-ui.com-%7C-Public--Community-?node-id=4913-7280&p=f&t=fMXcYIOzZi7Elvf6-0',
)
Widget buildConfigurableInput(BuildContext context) {
  // WidgetType configuration
  InputTypes widgetType = context.knobs.list(
    label: 'Widget Type',
    options: InputTypes.values,
    initialOption: InputTypes.text,
    labelBuilder: (value) {
      return value.name;
    },
  );

  final state = context.knobs.list(
    label: 'State',
    options: InputDisplayState.values,
    labelBuilder: (value) => value.name,
  );

  int? minLines = widgetType == InputTypes.textArea
      ? context.knobs.int.slider(
          label: 'Min lines for ${widgetType.name}',
          initialValue: 3,
          min: 1,
          max: 8,
        )
      : null;

  // Basic properties
  final size = context.knobs.list(
    label: 'Size',
    options: InputSize.values,
    labelBuilder: (value) => value.name.toUpperCase(),
    initialOption: InputSize.md,
  );

  // --- CONTENT SELECTION KNOBS (BOOLEAN TOGGLES) ---
  final hasLabel =
      context.knobs.boolean(label: 'Has Label', initialValue: true);
  final hasPlaceholder =
      context.knobs.boolean(label: 'Has Placeholder', initialValue: true);
  final hasHelperText = context.knobs.boolean(label: 'Has Helper Text');
  final hasPrefixIcon = context.knobs.boolean(label: 'Has Prefix Icon');
  final hasSuffixIcon = context.knobs.boolean(label: 'Has Suffix Icon');

  // --- CONTENT DEFINITION KNOBS (STRINGS) ---
  final labelText =
      context.knobs.string(label: 'Label Text', initialValue: 'Full Name');
  final placeholderText = context.knobs
      .string(label: 'Placeholder Text', initialValue: 'Anton Harkusha');
  final helperErrorText = context.knobs.string(
    label: 'Helper/Error Text',
    initialValue: 'This is a helper message.',
  );

  return UnpingUIContainer(
    key: ValueKey(widgetType),
    breadcrumbs: ['Components', 'Input', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: ConfigurableInputWidget(
              widgetType: widgetType,
              size: size,
              minLines: minLines,
              state: state,
              hasLabel: hasLabel,
              hasPlaceholder: hasPlaceholder,
              hasHelperText: hasHelperText,
              hasPrefixIcon: hasPrefixIcon,
              hasSuffixIcon: hasSuffixIcon,
              labelText: labelText,
              placeholderText: placeholderText,
              helperErrorText: helperErrorText,
            ),
          ),
        ])
      ],
    ),
  );
}
