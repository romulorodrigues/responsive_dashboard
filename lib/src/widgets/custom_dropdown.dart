import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final Widget button;
  final Widget dropdownContent;
  final double width;
  final double maxHeight;
  final int? badgeCount;
  final Color? hoverBackgroundColor;

  const CustomDropdown({
    super.key,
    required this.button,
    required this.dropdownContent,
    this.width = 200,
    this.maxHeight = 300,
    this.badgeCount,
    this.hoverBackgroundColor,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlay;
  OverlayEntry? _backdropOverlay;

  bool _isOpen = false;
  bool _isHovered = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
    final Size buttonSize = buttonRenderBox.size;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);

    final screenWidth = MediaQuery.of(context).size.width;
    final double dropdownRightEdge = buttonPosition.dx + widget.width;

    double dxOffset = 0;
    if (dropdownRightEdge > screenWidth) {
      dxOffset = screenWidth - dropdownRightEdge - 8;
    }

    final Offset offset = Offset(dxOffset, buttonSize.height + 8);

    _backdropOverlay = OverlayEntry(
      builder: (_) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.translucent,
        child: const SizedBox.expand(),
      ),
    );

    _dropdownOverlay = OverlayEntry(
      builder: (_) => Positioned(
        width: widget.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: widget.maxHeight),
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: widget.dropdownContent,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_backdropOverlay!);
    overlay.insert(_dropdownOverlay!);

    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _dropdownOverlay?.remove();
    _backdropOverlay?.remove();
    _dropdownOverlay = null;
    _backdropOverlay = null;
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: _isHovered
                ? BoxDecoration(
                    color: widget.hoverBackgroundColor ?? Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconTheme(
                  data: IconThemeData(
                    color: _isHovered ? const Color(0xFF232E51) : null,
                  ),
                  child: widget.button,
                ),
                if ((widget.badgeCount ?? 0) > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.badgeCount}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }
}
