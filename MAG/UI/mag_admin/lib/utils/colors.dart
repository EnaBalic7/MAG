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
  static const Color searchBar = Color.fromRGBO(52, 48, 110, 1);
  static const Color disabledControl = Color.fromRGBO(69, 67, 108, 1);
  static const Color selectedGenre = Color.fromRGBO(245, 184, 255, 1);
  static const Color popupMenu = Color.fromRGBO(50, 48, 90, 1);
  static const Color listTile = Color.fromRGBO(55, 53, 102, 1);

  //Gradients
  static const LinearGradient menuGradient = LinearGradient(colors: [
    Color.fromRGBO(72, 72, 156, 0.9),
    Color.fromRGBO(169, 87, 198, 0.9)
  ]);
  static const LinearGradient buttonGradient = LinearGradient(colors: [
    Color.fromRGBO(155, 108, 249, 0.8),
    Color.fromRGBO(0, 255, 255, 0.8)
  ]);
  static const LinearGradient buttonGradientReverse = LinearGradient(colors: [
    Color.fromRGBO(0, 255, 255, 1),
    Color.fromRGBO(155, 108, 249, 1)
  ]);
  static const LinearGradient barChartGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 255, 255, 1),
      Color.fromRGBO(155, 108, 249, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient barChartGradient2 = LinearGradient(
    colors: [
      Color.fromRGBO(72, 72, 156, 1),
      Color.fromRGBO(243, 137, 235, 1),
      Color.fromRGBO(251, 248, 166, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient barChartGradient3 = LinearGradient(
    colors: [
      Color.fromRGBO(132, 255, 134, 1),
      Color.fromRGBO(28, 167, 236, 1),
      Color.fromRGBO(120, 127, 246, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient barChartGradient4 = LinearGradient(
    colors: [
      // Color.fromRGBO(73, 38, 248, 1),
      Color.fromRGBO(229, 255, 100, 1),
      Color.fromRGBO(174, 98, 255, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient barChartGradient5 = LinearGradient(
    colors: [
      Color.fromRGBO(214, 26, 176, 1),
      Color.fromRGBO(236, 87, 129, 1),
      Color.fromRGBO(251, 248, 166, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient barChartGradient6 = LinearGradient(colors: [
    Color.fromRGBO(251, 248, 166, 1),
    Color.fromRGBO(236, 87, 129, 1),
    Color.fromRGBO(214, 26, 176, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const LinearGradient barChartGradient7 = LinearGradient(colors: [
    Color.fromRGBO(251, 248, 166, 1),
    Color.fromRGBO(243, 137, 235, 1),
    Color.fromRGBO(72, 72, 156, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static List<LinearGradient> gradientList = [
    barChartGradient2,
    barChartGradient3,
    barChartGradient5,
    barChartGradient,
    barChartGradient4
  ];

  static List<LinearGradient> gradientList2 = [
    barChartGradient7,
    barChartGradient3,
    barChartGradient6,
    barChartGradient,
    barChartGradient4
  ];

  static const LinearGradient buttonGradient2 = LinearGradient(
      colors: [Color.fromRGBO(52, 48, 110, 1), Color.fromRGBO(52, 48, 110, 1)]);
  //Detailed icon colors
  static const Color animeIco_e902 = Color.fromRGBO(101, 91, 192, 1);
  static const Color animeIco_e903 = Color.fromRGBO(140, 131, 215, 1);
  static const Color animeIco_e904_e905_e906 = Color.fromRGBO(192, 185, 255, 1);
  static const Color animeIco_e907_e908_e909_e90a = white;

  static const Color starIco_e918 = Color.fromRGBO(255, 255, 141, 1);
  static const Color starIco_e919 = white;
  static const Color starIco_e91a = Color.fromRGBO(223, 223, 93, 1);

  static const Color pdfIco_e911 = lightPurple;
  static const Color pdfIco_e912 = Color.fromRGBO(255, 235, 238, 1);
  static const Color pdfIco_e913_e914_e915 = Color.fromRGBO(96, 87, 173, 1);

  static const Color snowflakeIco1 = Color.fromRGBO(135, 206, 217, 1);
  static const Color snowflakeIco2 = Color.fromRGBO(167, 225, 235, 1);
}
