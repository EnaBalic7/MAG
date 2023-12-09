import 'dart:math';
import 'package:flutter/material.dart';

import '../widgets/gradient_button.dart';
import 'colors.dart';

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

class Authorization {
  static String? username;
  static String? password;
}

Future<void> showErrorDialog(BuildContext context, Exception e) async {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actionsAlignment: MainAxisAlignment.center,
              backgroundColor: Palette.darkPurple,
              title: Text("Error"),
              content: Text(e.toString()),
              actions: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: GradientButton(
                        onPressed: () => Navigator.pop(context),
                        width: 85,
                        height: 28,
                        borderRadius: 15,
                        gradient: Palette.buttonGradient,
                        child: Text("OK",
                            style: TextStyle(fontWeight: FontWeight.w500)))),
              ]));
}

Future<void> showInfoDialog(
    BuildContext context, Widget? title, Widget? content) async {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actionsAlignment: MainAxisAlignment.center,
              backgroundColor: Palette.darkPurple,
              title: title,
              content: content,
              actions: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: GradientButton(
                        onPressed: () => Navigator.pop(context),
                        width: 85,
                        height: 28,
                        borderRadius: 15,
                        gradient: Palette.buttonGradient,
                        child: Text("OK",
                            style: TextStyle(fontWeight: FontWeight.w500)))),
              ]));
}

Future<void> showConfirmationDialog(BuildContext context, Widget? dialogTitle,
    Widget? content, VoidCallback onPressedYes) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        backgroundColor: Palette.darkPurple,
        title: dialogTitle,
        content: content,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
              child: GradientButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  width: 85,
                  height: 28,
                  borderRadius: 15,
                  gradient: Palette.buttonGradient2,
                  child: Text("No"))),
          Padding(
              padding: EdgeInsets.only(right: 16, bottom: 10, top: 10),
              child: GradientButton(
                  onPressed: () {
                    onPressedYes();
                    Navigator.of(context).pop();
                  },
                  width: 85,
                  height: 28,
                  borderRadius: 15,
                  gradient: Palette.buttonGradient,
                  child: Text("Yes",
                      style: TextStyle(fontWeight: FontWeight.w500)))),
        ],
      );
    },
  );
}
