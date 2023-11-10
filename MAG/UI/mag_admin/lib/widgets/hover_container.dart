import 'package:flutter/material.dart';

class MyHoverContainer extends StatefulWidget {
  @override
  _MyHoverContainerState createState() => _MyHoverContainerState();
}

class _MyHoverContainerState extends State<MyHoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _mouseEnter(true),
      onExit: (_) => _mouseEnter(false),
      child: Container(
        width: 200,
        height: 200,
        color: _isHovered ? Colors.blue : Colors.red,
        child: Center(
          child: Text(
            _isHovered ? 'Hovered!' : 'Not Hovered',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _isHovered = hover;
    });
  }
}
