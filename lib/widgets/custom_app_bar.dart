import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final Widget? actionButton;

  CustomAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.actionButton,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF222220),
      brightness: Brightness.dark,
      actions: widget.actionButton != null ? [widget.actionButton!] : null,
      bottom: widget.bottom,
    );
  }
}
