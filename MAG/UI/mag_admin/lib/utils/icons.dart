import 'package:flutter/material.dart';
import 'colors.dart';

Stack buildAnimeIcon() {
  return Stack(children: [
    Icon(IconData(0xe902, fontFamily: 'icomoon'), color: Palette.animeIco_e902),
    Icon(IconData(0xe903, fontFamily: 'icomoon'), color: Palette.animeIco_e903),
    Icon(IconData(0xe904, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906),
    Icon(IconData(0xe905, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906),
    Icon(IconData(0xe906, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906),
    Icon(IconData(0xe907, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a),
    Icon(IconData(0xe908, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a),
    Icon(IconData(0xe909, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a.withOpacity(0.2)),
    Icon(IconData(0xe90a, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a.withOpacity(0.2))
  ]);
}

Stack buildStarIcon(double size) {
  return Stack(children: [
    Icon(IconData(0xe918, fontFamily: 'icomoon'),
        color: Palette.starIco_e918, size: size),
    Icon(IconData(0xe919, fontFamily: 'icomoon'),
        color: Palette.starIco_e919, size: size),
    Icon(IconData(0xe91a, fontFamily: 'icomoon'),
        color: Palette.starIco_e91a, size: size)
  ]);
}

Stack buildPdfIcon() {
  return Stack(children: [
    Icon(IconData(0xe911, fontFamily: 'icomoon'), color: Palette.pdfIco_e911),
    Icon(IconData(0xe912, fontFamily: 'icomoon'), color: Palette.pdfIco_e912),
    Icon(IconData(0xe913, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915),
    Icon(IconData(0xe914, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915),
    Icon(IconData(0xe915, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915)
  ]);
}

Icon buildAstronautIcon() => Icon(IconData(0xe90b, fontFamily: 'icomoon'));

Icon buildEditIcon(double size) {
  return Icon(
    IconData(0xe90e, fontFamily: 'icomoon'),
    color: Palette.lightPurple,
    size: size,
  );
}

dynamic buildSearchIcon(bool returnIconData) {
  if (returnIconData == true) {
    return IconData(0xe916, fontFamily: 'icomoon');
  }
  return Icon(IconData(0xe916, fontFamily: 'icomoon'));
}

Icon buildTrashIcon(double size) {
  return Icon(
    IconData(0xe920, fontFamily: 'icomoon'),
    color: Palette.lightRed,
    size: size,
  );
}

Icon buildHelpIcon() {
  return Icon(IconData(0xe90f, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildClubsIcon() {
  return Icon(IconData(0xe900, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildAnalyticsIcon() {
  return Icon(IconData(0xe901, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildUsersIcon() {
  return Icon(IconData(0xe921, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildCalendarIcon(double size, {Color? color}) {
  return Icon(
    IconData(0xe90c, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}

Stack buildStarTrailIcon(double size, {Color? color}) {
  return Stack(
    children: [
      Icon(
        IconData(0xe91b, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow,
        size: size,
      ),
      Icon(
        IconData(0xe91c, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
      Icon(
        IconData(0xe91d, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
      Icon(
        IconData(0xe91e, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
    ],
  );
}

Icon buildPostIcon(double size, {Color? color}) {
  return Icon(
    IconData(0xe917, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}

Icon buildCommentIcon(double size, {Color? color}) {
  return Icon(
    IconData(0xe90d, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}
