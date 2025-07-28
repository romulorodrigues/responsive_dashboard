import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';
import '../utils/constants.dart';
import '../widgets/side_bar.dart';
import '../utils/responsive_helper.dart';
import '../widgets/top_bar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget topBar;
  final List<MenuItemModel> menuItems;
  final TextStyle? sideBarSectionTextStyle;
  final Color? sideBarHeaderBackgroundColor;
  final Color? sideBarBackgroundColor;
  final double? sideBarScrollbarThickness;
  final Radius? sideBarScrollbarRadius;
  final Color? sideBarScrollbarThumbColor;
  final Widget? footer;

  const DashboardLayout({
    super.key,
    required this.child,
    required this.topBar,
    this.backgroundColor,
    required this.menuItems,
    this.sideBarSectionTextStyle,
    this.sideBarHeaderBackgroundColor,
    this.sideBarBackgroundColor,
    this.sideBarScrollbarThickness,
    this.sideBarScrollbarRadius,
    this.sideBarScrollbarThumbColor,
    this.footer,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool isCollapsed = false;
  Key sidebarKey = UniqueKey();

  void collapseAllSubmenus(List<MenuItemModel> items) {
    for (var item in items) {
      item.isExpanded = false;
      if (item.children != null) {
        collapseAllSubmenus(item.children!);
      }
    }
    sidebarKey = UniqueKey();
  }

  void toggleMenu() {
    setState(() {
      isCollapsed = !isCollapsed;
      if (isCollapsed) {
        collapseAllSubmenus(widget.menuItems);
      }
    });
  }

  void forceExpand() {
    setState(() {
      isCollapsed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final bgColor = widget.backgroundColor ?? DashboardColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      drawer: isMobile
          ? SideBar(
              key: sidebarKey,
              isCollapsed: isCollapsed,
              onToggleMenu: toggleMenu,
              onForceExpand: forceExpand,
              menuItems: widget.menuItems,
              sectionTextStyle: widget.sideBarSectionTextStyle,
              headerBackgroundColor: widget.sideBarHeaderBackgroundColor,
              backgroundColor: widget.sideBarBackgroundColor,
              scrollbarThickness: widget.sideBarScrollbarThickness,
              scrollbarRadius: widget.sideBarScrollbarRadius,
              scrollbarThumbColor: widget.sideBarScrollbarThumbColor,
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            SideBar(
              key: sidebarKey,
              isCollapsed: isCollapsed,
              onToggleMenu: toggleMenu,
              onForceExpand: forceExpand,
              menuItems: widget.menuItems,
              sectionTextStyle: widget.sideBarSectionTextStyle,
              headerBackgroundColor: widget.sideBarHeaderBackgroundColor,
              backgroundColor: widget.sideBarBackgroundColor,
              scrollbarThickness: widget.sideBarScrollbarThickness,
              scrollbarRadius: widget.sideBarScrollbarRadius,
              scrollbarThumbColor: widget.sideBarScrollbarThumbColor,
            ),
          Expanded(
            child: Column(
              children: [
                widget.topBar is TopBar
                    ? (widget.topBar as TopBar)
                        .copyWith(onToggleMenu: toggleMenu)
                    : widget.topBar,
                Expanded(child: widget.child),
                if (widget.footer != null) widget.footer!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
