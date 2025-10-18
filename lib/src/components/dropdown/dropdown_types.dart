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
class MenuDropdown extends StatelessWidget {
  final bool divider;
  final Widget icon;
  final Color menuColor;
  final TextStyle? menuTextStyle;
  final List<MenuDropdownItemGroup> actionMenuGroups;
  MenuDropdown({
    this.divider = false,
    required this.icon,
    required this.actionMenuGroups,
    this.menuColor = UiColors.neutral700,
    this.menuTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    final GlobalKey iconButtonKey = GlobalKey();
    ListView menu = ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(), // Enable scrolling when needed
      itemCount: actionMenuGroups.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            divider && index != 0 ? Divider() : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: actionMenuGroups[index],
            )
          ],
        );
      },
    );
    return IconButton(
      key: iconButtonKey,
      icon: icon,
      onPressed: () {
        ///Open the action Menu show dialog
        showMenuDropdownOverlay(context, iconButtonKey, menu, menuColor);
      },
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

      ///25 for each element
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///title
          groupTitle != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    groupTitle!,
                    textAlign: TextAlign.left,
                  ),
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
      title: Text(label),
      onTap: onTap,
    );
  }
}

OverlayEntry? menuDropdownOverlay;

///Overlay for the Dropdown Menu
void showMenuDropdownOverlay(
    BuildContext context, GlobalKey key, ListView menu, Color menuColor) {
  final renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  final screenSize = MediaQuery.of(context).size;

  bool openLeft = offset.dx + 200 > screenSize.width;
  bool openUp = offset.dy + 200 > screenSize.height;
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
          Positioned(
            left: openLeft ? offset.dx - 200 : offset.dx + size.width,
            top: openUp
                ? offset.dy - 200 + size.height
                : offset.dy + size.height,
            width: 200,
            child: Material(
              elevation: 4,
              child: GestureDetector(
                onTap: () {}, // Prevent internal taps from closing
                child: Container(
                    color: menuColor,
                    width: 200,
                    //   height: 300,
                    constraints: BoxConstraints(
                      maxHeight: 315, // limit height to safe zone
                    ),
                    child: menu),
              ),
            ),
          ),
        ],
      );
    },
  );

  Overlay.of(context).insert(menuDropdownOverlay!);
}
