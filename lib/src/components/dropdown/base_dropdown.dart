import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

class BaseDropdown<T> extends StatefulWidget {
  ///Labeling widget
  final String? label;

  ///Current state of the Dropdown
  final DropdownState state;

  ///Type of dropdown
  final DropdownType dropdownType;

  /// Callback when the Dropdown state changes
  final ValueChanged<DropdownState>? onDropdownStateChanged;

  ///Current size of the Dropdown
  final DropdownSize size;

  //for Single or multiple selection
  final bool isMultiSelect;

  /// For searching enabled or disabled
  final bool isSearchable;

  //Selected DropdownMenuItem
  final String? selectedValue;
  final ValueChanged<T>? onSelectedValueChanged;

  ///List Options
  final List<String> options;

  /// Selected values
  final List<String> selectedValues;

  //Enable Keyboard navigations
  final bool enableKeyboardNavigation;

  //border or none
  final bool withBorder;

  /// Text style of the dropdown button text
  final TextStyle? textStyle;

  /// Padding around the visible portion of the dropdown widget.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the Dropdown
  final double borderRadius;
  final double borderRadiusWidth;

  //Dropdown Colors
  final Color dropdownColor;
  final Color containerBackgroundColor;
  final Color borderRadiusColor;

  /// Border color when disabled
  final Color? disabledBorderColor;

  ///For errors
  final Color errorColor;

  ///Error message
  final String errorMessage;

  ///Select All Text
  final String selectAllText;

  ///Clear all Text
  final String clearAllText;

  ///The leading Icon In a dropdown
  final Widget? leadingDropdownIcon;

  ///The leading Icon In a dropdown
  final Widget? trailingDropdownIcon;

  ///action Menu Groups
  final List<MenuDropdownItemGroup> actionMenuGroups;

  ///Action menu divider
  final bool actionMenuDivider;

  const BaseDropdown(
      {super.key,
      this.label,
      this.state = DropdownState.normal,
      required this.dropdownType,
      this.onDropdownStateChanged,
      this.size = DropdownSize.md,
      this.isMultiSelect = false,
      this.isSearchable = true,
      this.selectedValue,
      this.onSelectedValueChanged,
      this.selectedValues = const [],
      this.options = const [],
      this.enableKeyboardNavigation = false,
      this.withBorder = true,
      this.textStyle, //assign later
      this.padding = const EdgeInsets.all(5),
      this.borderRadius = UiRadius.xs,
      this.borderRadiusWidth = 1,
      this.dropdownColor = UiColors.neutral700,
      this.containerBackgroundColor = UiColors.neutral700,
      this.borderRadiusColor = UiColors.neutral300,
      this.disabledBorderColor,
      this.errorColor = UiColors.error,
      this.errorMessage = 'Error',
      this.selectAllText = "Select All",
      this.clearAllText = "Clear All",
      this.leadingDropdownIcon,
      this.trailingDropdownIcon,
      this.actionMenuGroups = const [],
      this.actionMenuDivider = true});

  /// Get the actual size based on the size variant
  /// Scaled using 0.2
  double get actualSize {
    switch (size) {
      case DropdownSize.sm:
        return 200;
      case DropdownSize.md:
        return 250;
      case DropdownSize.lg:
        return 300;
    }
  }

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  ///To monitor window changes
  @override
  void didChangeMetrics() {
    // Called when the window size or device orientation changes
    closeOverlay();
    super.didChangeMetrics();
  }

//On Dropdown Value changed
  void onDropdownValueSelected(value) {
    setState(() {
      widget.onSelectedValueChanged!(value!);
    });
  }

//To prevent duplicates in the options list
  void verifyInputs() {
    if (widget.dropdownType == DropdownType.action) {
      assert(widget.actionMenuGroups.length != 0,
          "Action Menu Groups must have atleast one element");
    } else {
      ///Duplicate check for the option list to avoid double values
      assert(widget.options.toSet().length == widget.options.length,
          "No duplicates in the options list allowed");
      assert(widget.options.length > 0, "Add atleast one Item in options List");
    }
  }

//Return a list of Dropdown menu items
  List<DropdownMenuEntry> getMenuEntries() {
    List<DropdownMenuEntry> entries = [];
    for (var option in widget.options) {
      entries.add(DropdownMenuEntry(value: option, label: option));
    }
    return entries;
  }

  ///Multidropdown Variables

  ///for the Input Field
  LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  GlobalKey textFieldGlobalKey = GlobalKey();
  int? searchedItem;
  TextEditingController textEditingController = new TextEditingController();
  bool suggestAdd = false;

  ScrollController dropdownScrollController = new ScrollController();
  FocusNode overLayFocus = FocusNode();
  void scrollToIndex(int index) {
    dropdownScrollController.animateTo(
      index * singleLineListTileHeight,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  ///Overlay for the show options
  ///Overlay for Multiselect Dropdown
  OverlayEntry OptionsOverlay() {
    RenderBox renderBox =
        textFieldGlobalKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                closeOverlay();
              },
            ),
          ),
          Positioned(
            width: size.width,
            child: StatefulBuilder(
              builder: (context, setState) {
                return CompositedTransformFollower(
                  link: layerLink,
                  offset: Offset(0, size.height + 3),
                  child: Material(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: widget.containerBackgroundColor,
                          border: widget.withBorder
                              ? Border.all(
                                  color: widget.borderRadiusColor,
                                  width: widget.borderRadiusWidth,
                                )
                              : Border.fromBorderSide(BorderSide.none),
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.borderRadius))),
                      child: Column(
                        children: [
                          ///Suggest adding  or Clear or select all In the case of Multiselect
                          suggestAdd
                              ? SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        ///Add item and remove suggest
                                        setState(
                                          () {
                                            widget.options.add(
                                                textEditingController.text);
                                            suggestAdd = false;
                                          },
                                        );
                                        closeOverlay();
                                      },
                                      child: Text(
                                          "+ Add '${textEditingController.text}'")),
                                )
                              : SizedBox(),

                          ///For multi select Add select all and clear all options
                          widget.dropdownType == DropdownType.multi
                              ? SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///Select all button
                                      Center(
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                selectAllOrClear(true);
                                              });
                                            },
                                            child: Text(widget.selectAllText)),
                                      ),
                                      Center(
                                        child: TextButton(
                                            onPressed: () {
                                              ///Clear all
                                              setState(() {
                                                selectAllOrClear(false);
                                              });
                                            },
                                            child: Text(widget.clearAllText)),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          suggestAdd ||
                                  widget.dropdownType == DropdownType.multi
                              ? Divider(
                                  color: widget.borderRadiusColor,
                                  thickness: widget.borderRadiusWidth,
                                )
                              : SizedBox(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.options.length,
                              controller: dropdownScrollController,
                              itemBuilder: (context, index) {
                                String optionsValue = widget.options[index];
                                bool shouldFlash = searchedItem == index;
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInCubic,
                                  color: shouldFlash
                                      ? UiColors.neutral500
                                      : Colors.transparent,
                                  child: ListTile(
                                    title: Text(optionsValue),
                                    minTileHeight: singleLineListTileHeight,
                                    trailing: widget.selectedValues
                                            .contains(optionsValue)
                                        ? Icon(Icons.done)
                                        : SizedBox(),
                                    onTap: () {
                                      if (widget.dropdownType ==
                                          DropdownType.multi) {
                                        setState(
                                          () {
                                            manageSelectedValues(
                                                widget.selectedValues,
                                                optionsValue);
                                          },
                                        );
                                      } else {
                                        textEditingController.text =
                                            optionsValue;
                                        onDropdownValueSelected(optionsValue);
                                        closeOverlay();
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///manage selected values add remove etc
  void manageSelectedValues(List selectedValues, String valueToManage) {
    setState(() {
      if (selectedValues.contains(valueToManage)) {
        selectedValues.remove(valueToManage);
      } else {
        selectedValues.add(valueToManage);
      }
    });
  }

  ///Select or clear all
  void selectAllOrClear(bool selectAll) {
    if (selectAll) {
      ///select all
      widget.selectedValues.clear();

      setState(() {
        widget.selectedValues.addAll(widget.options);
      });
    } else {
      //Clear all
      setState(() {
        widget.selectedValues.clear();
      });
    }
  }

  void closeOverlay() {
    setState(() {
      overlayEntry?.remove();
      overlayEntry = null;
    });
  }

  ///Create or close Overlay
  void createOrCloseOverlay() {
    if (overlayEntry == null) {
      setState(() {
        overlayEntry = OptionsOverlay();
      });
      Overlay.of(context, rootOverlay: true).insert(overlayEntry!);
    } else {
      setState(() {
        closeOverlay();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> menuEntries = getMenuEntries();

    ///Ensure Lists dont cause errors
    verifyInputs();

    ///Return Depending on the type of Dropdown
    switch (widget.dropdownType) {
      ///Single selection dropdown
      case DropdownType.single:
        return Container(
          child: DropdownMenu(
            label: widget.label != null
                ? Text(
                    widget.label!,
                    style: widget.textStyle,
                  )
                : SizedBox(),
            enableSearch: widget.isSearchable,
            errorText: widget.state == DropdownState.error
                ? widget.errorMessage
                : null,
            enabled: widget.state != DropdownState.disabled,
            leadingIcon: widget.leadingDropdownIcon,
            width: widget.actualSize,
            dropdownMenuEntries: menuEntries,
            onSelected: onDropdownValueSelected,
            alignmentOffset: const Offset(0, 3),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: widget.dropdownColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                  borderSide: widget.withBorder
                      ? BorderSide(
                          color: widget.borderRadiusColor,
                          width: widget.borderRadiusWidth,
                        )
                      : BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                  borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius)),
                  borderSide: BorderSide(
                    color: widget.errorColor,
                    width: widget.borderRadiusWidth,
                  )),
            ),
            menuStyle: MenuStyle(
                side: WidgetStatePropertyAll(BorderSide(
                  color: widget.borderRadiusColor,
                  width: widget.borderRadiusWidth,
                )),
                backgroundColor:
                    WidgetStatePropertyAll(widget.containerBackgroundColor),
                fixedSize: WidgetStatePropertyAll(
                    Size(widget.actualSize, double.infinity))),
            trailingIcon: Icon(
              Icons.arrow_drop_down,
              color: widget.state == DropdownState.disabled
                  ? UiColors.neutral400
                  : UiColors.background,
            ),
          ),
        );

      /// Multiple selection dropdown
      case DropdownType.multi || DropdownType.comboBox:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.dropdownType == DropdownType.multi
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: widget.actualSize,
                      child: Wrap(
                        children: widget.selectedValues.map((selectedOption) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Chip(
                              label: Text(selectedOption),
                              onDeleted: () {
                                manageSelectedValues(
                                    widget.selectedValues, selectedOption);
                              },
                              deleteIcon: Icon(Icons.close),
                              backgroundColor: widget.containerBackgroundColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              width: widget.actualSize,
              child: CompositedTransformTarget(
                link: layerLink,
                child: TextField(
                  key: textFieldGlobalKey,
                  style: widget.textStyle,
                  enabled: widget.state != DropdownState.disabled,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.containerBackgroundColor,
                    icon: widget.leadingDropdownIcon,
                    labelText: widget.label,
                    errorText: widget.state == DropdownState.error
                        ? widget.errorMessage
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(overlayEntry == null
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up),
                      color: widget.state == DropdownState.disabled
                          ? UiColors.neutral400
                          : UiColors.background,
                      onPressed: () {
                        createOrCloseOverlay();
                      },
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: widget.withBorder
                            ? BorderSide(
                                color: widget.borderRadiusColor,
                                width: widget.borderRadiusWidth)
                            : BorderSide.none),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius)),
                        borderSide: BorderSide(
                          color: widget.errorColor,
                          width: widget.borderRadiusWidth,
                        )),
                  ),
                  onTap: () {
                    createOrCloseOverlay();
                  },
                  onChanged: widget.isSearchable
                      ? (textFieldValue) {
                          if (textFieldValue.trim().isNotEmpty) {
                            String? firstResult =
                                searchList(widget.options, textFieldValue);

                            if (firstResult != null) {
                              searchedItem =
                                  widget.options.indexOf(firstResult);
                              suggestAdd = false;
                              overlayEntry!.markNeedsBuild();
                              scrollToIndex(searchedItem!);
                              Future.delayed(Duration(milliseconds: 500), () {
                                searchedItem = null; // remove flash after time
                                overlayEntry!.markNeedsBuild();
                              });
                            } else if (widget.dropdownType ==
                                DropdownType.comboBox) {
                              /// suggest add
                              suggestAdd = true;
                              overlayEntry!.markNeedsBuild();
                            }
                          }
                        }
                      : null,
                ),
              ),
            )
          ],
        );

      ///Action menu dropdown
      case DropdownType.action:
        return MenuDropdown(
            label: widget.label,
            leadingIcon: widget.leadingDropdownIcon,
            trailingIcon: widget.trailingDropdownIcon,
            containerBackgroundColor: widget.containerBackgroundColor,
            menuColor: widget.dropdownColor,
            textStyle: widget.textStyle,
            size: widget.size,
            state: widget.state,
            divider: widget.actionMenuDivider,
            withBorder: widget.withBorder,
            actionMenuGroups: widget.actionMenuGroups);
    }
  }
}
