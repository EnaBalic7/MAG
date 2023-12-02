import 'package:flutter/material.dart';
import 'colors.dart';

Stack buildAnimeIcon() {
  return Stack(children: [
    Icon(IconData(0xe901, fontFamily: 'icomoon'), color: Palette.animeIco_e901),
    Icon(IconData(0xe902, fontFamily: 'icomoon'), color: Palette.animeIco_e902),
    Icon(IconData(0xe903, fontFamily: 'icomoon'),
        color: Palette.animeIco_e903_e904_e905),
    Icon(IconData(0xe904, fontFamily: 'icomoon'),
        color: Palette.animeIco_e903_e904_e905),
    Icon(IconData(0xe905, fontFamily: 'icomoon'),
        color: Palette.animeIco_e903_e904_e905),
    Icon(IconData(0xe906, fontFamily: 'icomoon'),
        color: Palette.animeIco_e906_e907_e908_e909),
    Icon(IconData(0xe907, fontFamily: 'icomoon'),
        color: Palette.animeIco_e906_e907_e908_e909),
    Icon(IconData(0xe908, fontFamily: 'icomoon'),
        color: Palette.animeIco_e906_e907_e908_e909.withOpacity(0.2)),
    Icon(IconData(0xe909, fontFamily: 'icomoon'),
        color: Palette.animeIco_e906_e907_e908_e909.withOpacity(0.2))
  ]);
}

Stack buildStarIcon(double size) {
  return Stack(children: [
    Icon(IconData(0xe914, fontFamily: 'icomoon'),
        color: Palette.starIco_e914, size: size),
    Icon(IconData(0xe915, fontFamily: 'icomoon'),
        color: Palette.starIco_e915, size: size),
    Icon(IconData(0xe916, fontFamily: 'icomoon'),
        color: Palette.starIco_e916, size: size)
  ]);
}

Stack buildPdfIcon() {
  return Stack(children: [
    Icon(IconData(0xe90e, fontFamily: 'icomoon'), color: Palette.pdfIco_e90e),
    Icon(IconData(0xe90f, fontFamily: 'icomoon'), color: Palette.pdfIco_e90f),
    Icon(IconData(0xe910, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e910_e911_e912),
    Icon(IconData(0xe911, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e910_e911_e912),
    Icon(IconData(0xe912, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e910_e911_e912)
  ]);
}

Icon buildAstronautIcon() => Icon(IconData(0xe90a, fontFamily: 'icomoon'));

Icon buildEditIcon(double size) {
  return Icon(
    IconData(0xe90c, fontFamily: 'icomoon'),
    color: Palette.lightPurple,
    size: size,
  );
}

dynamic buildSearchIcon(bool returnIconData) {
  if (returnIconData == true) {
    return IconData(0xe913, fontFamily: 'icomoon');
  }
  return Icon(IconData(0xe913, fontFamily: 'icomoon'));
}

Icon buildTrashIcon(double size) {
  return Icon(
    IconData(0xe917, fontFamily: 'icomoon'),
    color: Palette.lightRed,
    size: size,
  );
}

Icon buildHelpIcon() {
  return Icon(IconData(0xe90d, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildClubsIcon() {
  return Icon(IconData(0xe90b, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildAnalyticsIcon() {
  return Icon(IconData(0xe900, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}

Icon buildUsersIcon() {
  return Icon(IconData(0xe918, fontFamily: 'icomoon'),
      color: Palette.lightPurple);
}
