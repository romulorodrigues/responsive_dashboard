import 'package:flutter/material.dart';

class ButtonIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? hoverIconColor;
  final Color? hoverBackgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;

  const ButtonIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.hoverIconColor = const Color(0xFF232E51),
    this.hoverBackgroundColor = const Color(0xFFEEEEEE),
    this.iconColor,
    this.textStyle,
  });

  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.textStyle?.color ?? widget.iconColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color:
                _isHovered ? widget.hoverBackgroundColor : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? widget.hoverIconColor : defaultColor,
            size: widget.textStyle?.fontSize,
          ),
        ),
      ),
    );
  }
}
