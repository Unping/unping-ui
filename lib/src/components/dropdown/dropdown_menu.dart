import 'package:flutter/material.dart';
import 'package:unping_ui/unping_ui.dart';

///Action Menu Dropdown
///Styling options placed outside for easier acccesibility by the functions
///REMEMBER TO ASSIGN THESE BEFORE USING THEM!!!!!!
late Color _menuColor;
late double _menuWidth;

/// Border radius of the Dropdown
late double _borderRadius;
late double _borderRadiusWidth;
late Color _borderRadiusColor;
late TextStyle _textStyle;

double get listTileSize {
  if (_textStyle.fontSize! > 16) {
    return 72;
  } else if (_textStyle.fontSize! > 16) {
    return 48;
  }
  return 60;
}

class MenuDropdown extends StatelessWidget with WidgetsBindingObserver {
  final bool divider;
  final Widget? leadingIcon;
  final Color menuColor;
  final Color containerBackgroundColor;
  final DropdownSize size;
  final DropdownState state;
  final Widget? trailingIcon;

  /// Border radius of the Dropdown
  final double borderRadius;
  final double borderRadiusWidth;
  final Color borderRadiusColor;

  final TextStyle? textStyle;
  final List<MenuDropdownItemGroup> actionMenuGroups;
  final String? label;

  final bool withBorder;
  MenuDropdown(
      {this.divider = false,
      required this.leadingIcon,
      required this.actionMenuGroups,
      this.menuColor = UiColors.neutral700,
      this.textStyle,
      this.borderRadius = UiRadius.xs,
      this.borderRadiusWidth = 1,
      this.borderRadiusColor = UiColors.neutral300,
      this.size = DropdownSize.md,
      this.state = DropdownState.normal,
      this.label,
      this.trailingIcon,
      this.withBorder = true,
      this.containerBackgroundColor = UiColors.neutral700});

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
  void didChangeMetrics() {
    closeMenuDropOverlay();
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    final GlobalKey mainListTileKey = GlobalKey();

    ///Set accesible styling functions
    _menuColor = menuColor;
    _borderRadius = borderRadius;
    _borderRadiusWidth = borderRadiusWidth;
    _borderRadiusColor = borderRadiusColor;
    _textStyle = textStyle ?? UiTextStyles.textMdMedium;
    _menuWidth = actualSize;

    ///Build the actual menu
    ListView menu = ListView.builder(
      shrinkWrap: true,
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
        child: Container(
          //  width: _menuWidth - _menuWidth / 3,
          decoration: BoxDecoration(
              color: containerBackgroundColor,
              border: state == DropdownState.disabled || !withBorder
                  ? Border.fromBorderSide(BorderSide.none)
                  : Border.all(
                      color: _borderRadiusColor,
                      width: _borderRadiusWidth,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(UiRadius.full))),
          child: IntrinsicWidth(
            stepWidth: 15,
            child: ListTile(
              key: mainListTileKey,
              horizontalTitleGap: 0,
              minVerticalPadding: 0,
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: state == DropdownState.disabled
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.grey, // new color tint
                        BlendMode.srcIn, // replace the original color
                      ),
                      child: leadingIcon)
                  : leadingIcon,
              onTap: state == DropdownState.disabled
                  ? null
                  : () {
                      menuDropdownOverlay = createMenuDropdownOverlay(
                          context, mainListTileKey, menu, layerLink);

                      Overlay.of(context, rootOverlay: true)
                          .insert(menuDropdownOverlay!);
                    },
              title: label != null
                  ? Text(label!,
                      style: state == DropdownState.disabled
                          ? _textStyle.copyWith(color: UiColors.neutral500)
                          : textStyle)
                  : null,
              trailing: state == DropdownState.disabled
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                      child: trailingIcon)
                  : trailingIcon,
            ),
          ),
        ));
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
      height: (groupItems.length * listTileSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///title
          groupTitle != null
              ? Text(groupTitle!,
                  style: _textStyle.apply(
                      color:
                          UiColors.onPrimary)) //for some reason doesnt pick up
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
  final bool? destructive;
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
OverlayEntry createMenuDropdownOverlay(
    BuildContext context, GlobalKey key, ListView menu, LayerLink layerLink) {
  final renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  final screenSize = MediaQuery.of(context).size;

  bool openLeft = offset.dx + _menuWidth > screenSize.width;
  return OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          //  Fullscreen tap blocker to dismiss
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                closeMenuDropOverlay();
              },
            ),
          ),

          /// Actual positioned menu
          CompositedTransformFollower(
            link: layerLink,
            offset:
                Offset(openLeft ? _menuWidth : _menuWidth / 4, size.height + 5),
            child: Material(
              child: Container(
                  decoration: BoxDecoration(
                      color: _menuColor,
                      border: Border.all(
                        color: _borderRadiusColor,
                        width: _borderRadiusWidth,
                      ),
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  width: _menuWidth,
                  child: menu),
            ),
          ),
        ],
      );
    },
  );
}

void closeMenuDropOverlay() {
  menuDropdownOverlay?.remove();
  menuDropdownOverlay = null;
}
