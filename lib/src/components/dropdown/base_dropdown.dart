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
  final ValueChanged<String> onSelectedValueChanged;

  ///List Options
  final List<String> options;

  /// Selected values
  final List<String> selectedValues;

  //Enable Keyboard navigations
  final bool enableKeyboardNavigation;

  //Sort the dropdown menu Item
  final bool sortMenuItems;

  /// Text style of the dropdown button text
  final TextStyle? textStyle;

  /// Padding around the visible portion of the dropdown widget.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the Dropdown
  final double borderRadius;
  final double borderRadiusWidth;

  //Dropdown Colors
  final Color? dropdownColor;
  final Color? containerBackgroundColor;
  final Color borderRadiusColor;

  /// width of the dropDown
  final double dropdownMenuWidth;

  const BaseDropdown({
    super.key,
    this.label,
    this.state = DropdownState.normal,
    required this.dropdownType,
    this.onDropdownStateChanged,
    this.size = DropdownSize.md,
    this.isMultiSelect = false,
    this.isSearchable = true,
    this.selectedValue,
    required this.onSelectedValueChanged,
    this.selectedValues = const [],
    this.options = const [],
    this.enableKeyboardNavigation = false,
    this.sortMenuItems = false,
    this.textStyle, //assign later
    this.padding = const EdgeInsets.all(5),
    this.borderRadius = UiRadius.xs,
    this.borderRadiusWidth = 1,
    this.dropdownColor = UiColors.neutral700,
    this.containerBackgroundColor = UiColors.neutral700,
    this.borderRadiusColor = UiColors.neutral300,
    this.dropdownMenuWidth = 150,
  });
  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
//On Dropdown Value changed
  void onDropdownValueSelected(value) {
    setState(() {
      widget.onSelectedValueChanged(value!);
    });
  }

//To prevent duplicates in the options list
  bool NoDuplicates() {
    return widget.options.toSet().length == widget.options.length;
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
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: widget.containerBackgroundColor,
                        border: Border.all(
                          color: widget.borderRadiusColor,
                          width: widget.borderRadiusWidth,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius))),
                    child: Column(
                      children: [
                        ///Suggest adding
                        suggestAdd
                            ? SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      ///Add item and remove suggest
                                      setState(
                                        () {
                                          widget.options
                                              .add(textEditingController.text);
                                          suggestAdd = false;
                                        },
                                      );
                                      closeOverlay();
                                    },
                                    child: Text(
                                        "+ Add '${textEditingController.text}'")),
                              )
                            : SizedBox(),
                        suggestAdd
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
                                      textEditingController.text = optionsValue;
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

  void closeOverlay() {
    setState(() {
      overlayEntry?.remove();
      overlayEntry = null;
    });
  }

  @override
  void dispose() {
    closeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> menuEntries = getMenuEntries();

    ///Duplicate check for the option list to avoid double values
    assert(NoDuplicates(), "No duplicates in the options list allowed");

    ///Return Depending on the type of Dropdown
    switch (widget.dropdownType) {
      ///Single selection dropdown
      case DropdownType.single:
        return DropdownMenu(
          label: widget.label != null ? Text(widget.label!) : SizedBox(),
          enableSearch: widget.isSearchable,
          width: widget.dropdownMenuWidth,
          dropdownMenuEntries: menuEntries,
          onSelected: onDropdownValueSelected,
          alignmentOffset: const Offset(0, 3),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: widget.dropdownColor,
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: widget.borderRadiusColor,
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
                  Size(widget.dropdownMenuWidth, double.infinity))),
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
                      width: widget.dropdownMenuWidth,
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
              width: widget.dropdownMenuWidth,
              child: CompositedTransformTarget(
                link: layerLink,
                child: TextField(
                  key: textFieldGlobalKey,
                  style: widget.textStyle,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.containerBackgroundColor,
                    labelText: widget.label,
                    suffixIcon: IconButton(
                      icon: Icon(overlayEntry == null
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up),
                      color: UiColors.background,
                      onPressed: () {
                        setState(() {
                          if (overlayEntry == null) {
                            overlayEntry = OptionsOverlay();
                            Overlay.of(context).insert(overlayEntry!);
                          } else {
                            closeOverlay();
                          }
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                            color: widget.borderRadiusColor,
                            width: widget.borderRadiusWidth)),
                  ),
                  onTap: () {
                    setState(() {
                      if (overlayEntry == null) {
                        overlayEntry = OptionsOverlay();
                        Overlay.of(context).insert(overlayEntry!);
                      } else {
                        closeOverlay();
                      }
                    });
                  },
                  onChanged: (textFieldValue) {
                    if (textFieldValue.trim().isNotEmpty) {
                      String? firstResult =
                          searchList(widget.options, textFieldValue);

                      if (firstResult != null) {
                        searchedItem = widget.options.indexOf(firstResult);
                        suggestAdd = false;
                        overlayEntry!.markNeedsBuild();
                        scrollToIndex(searchedItem!);
                        Future.delayed(Duration(milliseconds: 500), () {
                          searchedItem = null; // remove flash after time
                          overlayEntry!.markNeedsBuild();
                        });
                      } else if (widget.dropdownType == DropdownType.comboBox) {
                        /// suggest add
                        suggestAdd = true;
                        overlayEntry!.markNeedsBuild();
                      }
                    }
                  },
                ),
              ),
            )
          ],
        );

      ///Action menu dropdown
      case DropdownType.action:
        return Placeholder();
    }
  }
}
