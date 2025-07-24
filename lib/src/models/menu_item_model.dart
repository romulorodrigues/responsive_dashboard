import 'package:flutter/material.dart';

class MenuItemModel {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final List<MenuItemModel>? children;
  bool isExpanded;

  MenuItemModel({
    required this.icon,
    required this.label,
    this.onTap,
    this.children,
    this.isExpanded = false,
  });

  bool get hasChildren => children != null && children!.isNotEmpty;
}
