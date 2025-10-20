//Enums, option classes, and helpers
import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

enum DropdownSize {
  /// Small Dropdown - compact size
  sm,

  /// Medium Dropdown - default size
  md,

  /// Large Dropdown - expanded size
  lg,
}

enum DropdownState {
  /// Normal state - default appearance
  normal,

  /// Error state
  error,

  /// Focused state change focus color
  focused,

  /// Disabled state
  disabled,
}

enum DropdownType {
  ///Single selection dropdown
  single,

  ///Multiple selection dropdown
  multi,

  ///Searchable combo box
  comboBox,

  ///Action menu dropdown
  action
}

///Action Menu Dropdown
///Styling options placed outside for easier acccesibility by the functions
///REMEMBER TO ASSIGN THESE BEFORE USING THEM!!!!!!
late Color _menuColor;

/// Border radius of the Dropdown
late double _borderRadius;
late double _borderRadiusWidth;
late Color _borderRadiusColor;
late TextStyle _textStyle;

class MenuDropdown extends StatelessWidget {
  final bool divider;
  final Widget icon;
  final Color menuColor;

  /// Border radius of the Dropdown
  final double borderRadius;
  final double borderRadiusWidth;
  final Color borderRadiusColor;

  final TextStyle? textStyle;
  final List<MenuDropdownItemGroup> actionMenuGroups;
  MenuDropdown(
      {this.divider = false,
      required this.icon,
      required this.actionMenuGroups,
      this.menuColor = UiColors.neutral700,
      this.textStyle,
      this.borderRadius = UiRadius.xs,
      this.borderRadiusWidth = 1,
      this.borderRadiusColor = UiColors.neutral300});

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconButtonKey = GlobalKey();

    ///Set accesible styling functions
    _menuColor = menuColor;
    _borderRadius = borderRadius;
    _borderRadiusWidth = borderRadiusWidth;
    _borderRadiusColor = borderRadiusColor;
    _textStyle = textStyle ?? UiTextStyles.textSm;

    ///Build the actual menu
    ListView menu = ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      itemCount: actionMenuGroups.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            divider && index != 0
                ? Divider(
                    color: borderRadiusColor,
                    thickness: borderRadiusWidth,
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: actionMenuGroups[index],
            )
          ],
        );
      },
    );

    ///A layer link to link the popup menu with the icon
    LayerLink layerLink = LayerLink();
    return CompositedTransformTarget(
      link: layerLink,
      child: IconButton(
        key: iconButtonKey,
        alignment: AlignmentGeometry.topLeft,
        icon: icon,
        onPressed: () {
          ///Open the action Menu show dialog
          showMenuDropdownOverlay(context, iconButtonKey, menu, layerLink);
        },
      ),
    );
  }
}

///MenuDropdownItemGroup a group for the MenuDropdown
class MenuDropdownItemGroup extends StatelessWidget {
  final List<MenuDropdownItem> groupItems;
  final String? groupTitle;

  MenuDropdownItemGroup({required this.groupItems, this.groupTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (groupItems.length * 57),

      ///Using 57 for the size of the emenet
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///title
          groupTitle != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child:
                      Text(groupTitle!, style: TextStyle(color: Colors.white)),
                )
              : SizedBox(),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: groupItems.length,
            itemBuilder: (context, index) {
              MenuDropdownItem item = groupItems[index];
              return MenuDropdownItem(
                  label: item.label,
                  destructive: item.destructive,
                  icon: item.icon,
                  onTap: item.onTap);
            },
          ))
        ],
      ),
    );
  }
}

///MenuDropDownItem an Item to be Inserted in a MenuDropdownItemGroup
class MenuDropdownItem extends StatelessWidget {
  final Widget? icon;
  final String label;
  final void Function()? onTap;
  final bool destructive;
  MenuDropdownItem({
    this.icon,
    required this.label,
    this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(label, style: _textStyle),
      onTap: onTap,
    );
  }
}

OverlayEntry? menuDropdownOverlay;

///Overlay for the Dropdown Menu
void showMenuDropdownOverlay(
    BuildContext context, GlobalKey key, ListView menu, LayerLink layerLink) {
  final renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  final screenSize = MediaQuery.of(context).size;

  bool openLeft = offset.dx + 200 > screenSize.width;
  menuDropdownOverlay = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          //  Fullscreen tap blocker to dismiss
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                menuDropdownOverlay?.remove();
                menuDropdownOverlay = null;
              },
            ),
          ),

          /// Actual positioned menu
          CompositedTransformFollower(
            link: layerLink,
            offset: Offset(openLeft ? 220 : 20, size.height),
            child: Container(
                decoration: BoxDecoration(
                    color: _menuColor,
                    border: Border.all(
                      color: _borderRadiusColor,
                      width: _borderRadiusWidth,
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(_borderRadius))),
                width: 200,
                constraints: BoxConstraints(
                  maxHeight: 315, // limit height to safe zone
                ),
                child: menu),
          ),
        ],
      );
    },
  );

  Overlay.of(context).insert(menuDropdownOverlay!);
}
