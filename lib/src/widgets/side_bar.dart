import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';

class SideBar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggleMenu;
  final VoidCallback? onForceExpand;
  final List<MenuItemModel> menuItems;
  final TextStyle? sectionTextStyle;
  final Color? backgroundColor;
  final Color? headerBackgroundColor;

  const SideBar({
    super.key,
    required this.isCollapsed,
    required this.onToggleMenu,
    this.onForceExpand,
    required this.menuItems,
    this.sectionTextStyle,
    this.backgroundColor,
    this.headerBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isCollapsed ? 80 : 250,
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: backgroundColor ?? const Color(0xFF232E51),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: headerBackgroundColor ?? const Color(0xFF232E51),
              ),
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
              child: Container(
                color: backgroundColor ?? const Color(0xFF232E51),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: _buildMenuItemsGroupedBySection(context),
                ),
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
              style: sectionTextStyle ??
                  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF97aac1),
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
      return Tooltip(
        message: item.label,
        child: ExpansionTile(
          key: ValueKey('${item.label}_${item.isExpanded}'),
          leading: Icon(
            item.icon,
            color: item.iconColor ?? const Color(0xFF97aac1),
          ),
          title: Row(
            children: [
              if (!isCollapsed)
                Expanded(
                  child: Text(
                    item.label,
                    style: item.textStyle ??
                        const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF97aac1),
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
            ],
          ),
          trailing: Icon(
            item.isExpanded ? Icons.expand_less : Icons.expand_more,
            color: item.arrowColor ?? const Color(0xFF97aac1),
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
        ),
      );
    } else {
      return Tooltip(
        message: item.label,
        child: ListTile(
          leading: Icon(
            item.icon,
            color: item.iconColor ?? const Color(0xFF97aac1),
          ),
          title: isCollapsed
              ? const SizedBox.shrink()
              : Text(
                  item.label,
                  style: item.textStyle ??
                      const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF97aac1),
                        letterSpacing: 0.5,
                      ),
                ),
          onTap: item.onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          minLeadingWidth: 0,
        ),
      );
    }
  }
}
