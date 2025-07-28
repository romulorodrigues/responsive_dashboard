import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';

class SideBar extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggleMenu;
  final VoidCallback? onForceExpand;
  final List<MenuItemModel> menuItems;
  final TextStyle? sectionTextStyle;
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final double? scrollbarThickness;
  final Radius? scrollbarRadius;
  final Color? scrollbarThumbColor;

  const SideBar({
    super.key,
    required this.isCollapsed,
    required this.onToggleMenu,
    this.onForceExpand,
    required this.menuItems,
    this.sectionTextStyle,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.scrollbarThickness,
    this.scrollbarRadius,
    this.scrollbarThumbColor,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isCollapsed ? 80 : 250,
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: widget.backgroundColor ?? const Color(0xFF232E51),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: widget.headerBackgroundColor ?? const Color(0xFF232E51),
              ),
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterLogo(size: widget.isCollapsed ? 40 : 50),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: widget.backgroundColor ?? const Color(0xFF232E51),
                child: RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thickness: widget.scrollbarThickness ?? 6,
                  radius: widget.scrollbarRadius ?? const Radius.circular(4),
                  thumbColor:
                      (widget.scrollbarThumbColor ?? Colors.grey.shade400)
                          .withOpacity(0.6),
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    children: _buildMenuItemsGroupedBySection(context),
                  ),
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

    for (var item in widget.menuItems) {
      grouped.putIfAbsent(item.section, () => []).add(item);
    }

    final List<Widget> widgets = [];

    grouped.forEach((section, items) {
      if (section != null && !widget.isCollapsed) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              section.toUpperCase(),
              style: widget.sectionTextStyle ??
                  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF97aac1),
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
              if (!widget.isCollapsed)
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
            if (widget.isCollapsed && expanded) {
              widget.onForceExpand?.call();
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
          title: widget.isCollapsed
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
