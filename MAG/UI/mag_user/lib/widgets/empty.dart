import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/icons.dart';
import 'gradient_button.dart';

class Empty extends StatefulWidget {
  /// Text widget to portray
  final Text? text;

  /// Screen to navigate to by clicking a button, used in combination with showGradientButton
  final Widget? screen;

  /// Shows a gradient button under the icon
  final bool? showGradientButton;

  final double? iconSize;

  /// GradientButton height
  final double? height;

  /// GradientButton width
  final double? width;

  /// GradientButton gradient
  final LinearGradient? gradient;

  /// GradientButton child widget, usually Text
  final Widget? child;
  const Empty({
    Key? key,
    this.text,
    this.screen,
    this.showGradientButton = true,
    this.iconSize,
    this.height,
    this.width,
    this.gradient,
    this.child,
  }) : super(key: key);

  @override
  State<Empty> createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildBlackHoleIcon(widget.iconSize ?? 200,
                color: Palette.lightPurple.withOpacity(0.8)),
            widget.text ?? const Text(""),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: widget.showGradientButton ?? true,
              child: GradientButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => widget.screen!));
                },
                width: widget.width ?? 120,
                height: widget.height ?? 30,
                borderRadius: 50,
                gradient: widget.gradient ?? Palette.navGradient4,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
