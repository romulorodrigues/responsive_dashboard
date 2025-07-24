import 'package:flutter/material.dart';

class MenuItemModel {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final List<MenuItemModel>? children;
  bool isExpanded;
  final String? section;

  MenuItemModel({
    required this.icon,
    required this.label,
    this.onTap,
    this.children,
    this.isExpanded = false,
    this.section,
  });

  bool get hasChildren => children != null && children!.isNotEmpty;
}
