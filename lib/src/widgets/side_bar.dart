import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';

class SideBar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggleMenu;
  final VoidCallback? onForceExpand;
  final List<MenuItemModel> menuItems;

  const SideBar({
    super.key,
    required this.isCollapsed,
    required this.onToggleMenu,
    this.onForceExpand,
    required this.menuItems,
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
                children: menuItems
                    .map((item) => _buildMenuItem(context, item))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItemModel item) {
    if (item.hasChildren) {
      return ExpansionTile(
        key: ValueKey('${item.label}_${item.isExpanded}'),
        leading: Icon(item.icon),
        title: Row(
          children: [
            if (!isCollapsed) Expanded(child: Text(item.label)),
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
          title: isCollapsed ? const SizedBox.shrink() : Text(item.label),
          onTap: item.onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          minLeadingWidth: 0,
        ),
      );
    }
  }
}
