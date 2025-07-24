import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';

class SideBar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggleMenu;
  final VoidCallback? onForceExpand;
  final List<MenuItemModel> menuItems;
  final TextStyle? sideBarSectionTextStyle;
  final TextStyle? sideBarMenuItemTextStyle;

  const SideBar({
    super.key,
    required this.isCollapsed,
    required this.onToggleMenu,
    this.onForceExpand,
    required this.menuItems,
    this.sideBarSectionTextStyle,
    this.sideBarMenuItemTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isCollapsed ? 80 : 250,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterLogo(size: isCollapsed ? 40 : 50),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: _buildMenuItemsGroupedBySection(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItemsGroupedBySection(BuildContext context) {
    final Map<String?, List<MenuItemModel>> grouped = {};

    for (var item in menuItems) {
      grouped.putIfAbsent(item.section, () => []).add(item);
    }

    final List<Widget> widgets = [];

    grouped.forEach((section, items) {
      if (section != null && !isCollapsed) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              section.toUpperCase(),
              style: sideBarSectionTextStyle ??
                  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
        );
      }

      widgets.addAll(items.map((item) => _buildMenuItem(context, item)));
    });

    return widgets;
  }

  Widget _buildMenuItem(BuildContext context, MenuItemModel item) {
    if (item.hasChildren) {
      return ExpansionTile(
        key: ValueKey('${item.label}_${item.isExpanded}'),
        leading: Icon(item.icon),
        title: Row(
          children: [
            if (!isCollapsed)
              Expanded(
                  child: Text(item.label, style: sideBarMenuItemTextStyle)),
          ],
        ),
        initiallyExpanded: item.isExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.only(left: 16),
        onExpansionChanged: (expanded) {
          item.isExpanded = expanded;
          if (isCollapsed && expanded) {
            onForceExpand?.call();
          }
        },
        children: item.children!
            .map((child) => _buildMenuItem(context, child))
            .toList(),
      );
    } else {
      return Tooltip(
        message: item.label,
        waitDuration: const Duration(milliseconds: 300),
        child: ListTile(
          leading: Icon(item.icon),
          title: isCollapsed
              ? const SizedBox.shrink()
              : Text(item.label, style: sideBarMenuItemTextStyle),
          onTap: item.onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          minLeadingWidth: 0,
        ),
      );
    }
  }
}
