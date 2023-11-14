// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Palette {
  static const Color midnightPurple = Color.fromRGBO(12, 11, 30, 1);
  static const Color darkPurple = Color.fromRGBO(30, 28, 64, 1);
  static const Color plumPurple = Color.fromRGBO(57, 28, 75, 1);
  static const Color lightPurple = Color.fromRGBO(192, 185, 255, 1);
  static const Color starYellow = Color.fromRGBO(255, 255, 141, 1);
  static const Color teal = Color.fromRGBO(153, 255, 255, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color lightRed = Color.fromRGBO(255, 185, 235, 1);
  static const Color textFieldPurple = Color.fromRGBO(140, 131, 215, 1);

  //Gradients
  static const LinearGradient menuGradient = LinearGradient(colors: [
    Color.fromRGBO(72, 72, 156, 0.7),
    Color.fromRGBO(169, 87, 198, 0.7)
  ]);
  static const LinearGradient buttonGradient = LinearGradient(colors: [
    Color.fromRGBO(155, 108, 249, 0.8),
    Color.fromRGBO(0, 255, 255, 0.8)
  ]);

  //Detailed icon colors
  static const Color animeIco_e901 = Color.fromRGBO(101, 91, 192, 1);
  static const Color animeIco_e902 = Color.fromRGBO(140, 131, 215, 1);
  static const Color animeIco_e903_e904_e905 = Color.fromRGBO(192, 185, 255, 1);
  static const Color animeIco_e906_e907_e908_e909 = white;

  static const Color starIco_e914 = Color.fromRGBO(255, 255, 141, 1);
  static const Color starIco_e915 = white;
  static const Color starIco_e916 = Color.fromRGBO(223, 223, 93, 1);

  static const Color pdfIco_e90e = Color.fromRGBO(96, 87, 173, 1);
  static const Color pdfIco_e90f = Color.fromRGBO(192, 185, 255, 1);
  static const Color pdfIco_e910_e911_e912 = Color.fromRGBO(255, 235, 238, 1);
}
