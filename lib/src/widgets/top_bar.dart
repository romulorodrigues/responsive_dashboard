import 'package:flutter/material.dart';
import '../../responsive_dashboard.dart';

class TopBar extends StatefulWidget {
  final Widget child;
  final Widget? searchField;
  final ValueChanged<String>? onSearch;
  final Widget? userAvatar;
  final String? userName;
  final List<Widget>? userDropdownItems;
  final Color? hoverBackgroundColor;
  final VoidCallback? onToggleMenu;

  const TopBar({
    super.key,
    required this.child,
    this.searchField,
    this.onSearch,
    this.userAvatar,
    this.userName,
    this.userDropdownItems,
    this.hoverBackgroundColor,
    this.onToggleMenu,
  });

  @override
  State<TopBar> createState() => _TopBarState();

  TopBar copyWith({
    Widget? child,
    Widget? searchField,
    ValueChanged<String>? onSearch,
    Widget? userAvatar,
    String? userName,
    List<Widget>? userDropdownItems,
    Color? hoverBackgroundColor,
    VoidCallback? onToggleMenu,
  }) {
    return TopBar(
      searchField: searchField ?? this.searchField,
      onSearch: onSearch ?? this.onSearch,
      userAvatar: userAvatar ?? this.userAvatar,
      userName: userName ?? this.userName,
      userDropdownItems: userDropdownItems ?? this.userDropdownItems,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      onToggleMenu: onToggleMenu ?? this.onToggleMenu,
      child: child ?? this.child,
    );
  }
}

class _TopBarState extends State<TopBar> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _searchOverlay;

  void _showSearchOverlay() {
    if (_searchOverlay != null) return;

    final overlay = Overlay.of(context);

    _searchOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        right: 0,
        top: 70,
        child: Material(
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                autofocus: true,
                onSubmitted: (value) {
                  widget.onSearch?.call(value);
                  _removeSearchOverlay();
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _removeSearchOverlay,
                  ),
                  border: const OutlineInputBorder(),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_searchOverlay!);
  }

  void _removeSearchOverlay() {
    _searchOverlay?.remove();
    _searchOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(104, 134, 177, 0.15),
              blurRadius: 35,
              offset: Offset.zero,
            ),
          ],
          border: Border(
            bottom: BorderSide(color: Color(0xFFE7E9EB), width: 0),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                if (ResponsiveHelper.isMobile(context)) {
                  Scaffold.of(context).openDrawer();
                } else {
                  widget.onToggleMenu?.call();
                }
              },
              tooltip: 'Alternar menu',
            ),
            const SizedBox(width: 16),
            if (isMobile)
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _showSearchOverlay,
              )
            else
              SizedBox(
                width: 400,
                height: 40,
                child: widget.searchField ??
                    TextField(
                      controller: _controller,
                      onSubmitted: widget.onSearch,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
              ),
            const Spacer(),
            Row(
              children: [
                widget.child,
                if (widget.userAvatar != null &&
                    widget.userName != null &&
                    widget.userDropdownItems != null) ...[
                  const SizedBox(width: 16),
                  CustomDropdown(
                    hoverBackgroundColor: widget.hoverBackgroundColor,
                    button: Row(
                      children: [
                        widget.userAvatar!,
                        const SizedBox(width: 8),
                        if (ResponsiveHelper.isDesktop(context)) ...[
                          const SizedBox(width: 8),
                          Text(widget.userName!),
                        ],
                      ],
                    ),
                    dropdownContent: Column(
                      children: widget.userDropdownItems!,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeSearchOverlay();
    super.dispose();
  }
}
