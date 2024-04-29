import 'package:flutter/material.dart';
import 'colors.dart';

Stack buildAnimeIcon(double size) {
  return Stack(children: [
    Icon(const IconData(0xe902, fontFamily: 'icomoon'),
        color: Palette.animeIco_e902, size: size),
    Icon(const IconData(0xe903, fontFamily: 'icomoon'),
        color: Palette.animeIco_e903, size: size),
    Icon(const IconData(0xe904, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906, size: size),
    Icon(const IconData(0xe905, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906, size: size),
    Icon(const IconData(0xe906, fontFamily: 'icomoon'),
        color: Palette.animeIco_e904_e905_e906, size: size),
    Icon(const IconData(0xe907, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a, size: size),
    Icon(const IconData(0xe908, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a, size: size),
    Icon(const IconData(0xe909, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a.withOpacity(0.2),
        size: size),
    Icon(const IconData(0xe90a, fontFamily: 'icomoon'),
        color: Palette.animeIco_e907_e908_e909_e90a.withOpacity(0.2),
        size: size)
  ]);
}

Stack buildStarIcon(double size, {double? opacity}) {
  return Stack(children: [
    Icon(const IconData(0xe918, fontFamily: 'icomoon'),
        color: Palette.starIco_e918.withOpacity(opacity ?? 1), size: size),
    Icon(const IconData(0xe919, fontFamily: 'icomoon'),
        color: Palette.starIco_e919.withOpacity(opacity ?? 1), size: size),
    Icon(const IconData(0xe91a, fontFamily: 'icomoon'),
        color: Palette.starIco_e91a.withOpacity(opacity ?? 1), size: size)
  ]);
}

Stack buildPdfIcon(double size) {
  return Stack(children: [
    Icon(const IconData(0xe911, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e911, size: size),
    Icon(const IconData(0xe912, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e912, size: size),
    Icon(const IconData(0xe913, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915, size: size),
    Icon(const IconData(0xe914, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915, size: size),
    Icon(const IconData(0xe915, fontFamily: 'icomoon'),
        color: Palette.pdfIco_e913_e914_e915, size: size)
  ]);
}

Icon buildAstronautIcon() =>
    const Icon(IconData(0xe90b, fontFamily: 'icomoon'));

Icon buildEditIcon(double size, {double? opacity}) {
  return Icon(
    const IconData(0xe90e, fontFamily: 'icomoon'),
    color: Palette.lightPurple.withOpacity(opacity ?? 1),
    size: size,
  );
}

dynamic buildSearchIcon(bool returnIconData) {
  if (returnIconData == true) {
    return const IconData(0xe916, fontFamily: 'icomoon');
  }
  return const Icon(IconData(0xe916, fontFamily: 'icomoon'));
}

Icon buildTrashIcon(double size) {
  return Icon(
    const IconData(0xe920, fontFamily: 'icomoon'),
    color: Palette.lightRed,
    size: size,
  );
}

Icon buildHelpIcon(double size) {
  return Icon(const IconData(0xe90f, fontFamily: 'icomoon'),
      color: Palette.lightPurple, size: size);
}

dynamic buildClubsIcon({double? size, bool? returnIconData}) {
  if (returnIconData == true && size == null) {
    return const IconData(0xe900, fontFamily: 'icomoon');
  }
  return Icon(const IconData(0xe900, fontFamily: 'icomoon'),
      color: Palette.lightPurple, size: size);
}

Icon buildReportsIcon(double size) {
  return Icon(const IconData(0xe901, fontFamily: 'icomoon'),
      color: Palette.lightPurple, size: size);
}

Icon buildUsersIcon(double size) {
  return Icon(const IconData(0xe921, fontFamily: 'icomoon'),
      color: Palette.lightPurple, size: size);
}

Icon buildCalendarIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe90c, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}

Stack buildStarTrailIcon(double size, {Color? color}) {
  return Stack(
    children: [
      Icon(
        const IconData(0xe91b, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow,
        size: size,
      ),
      Icon(
        const IconData(0xe91c, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
      Icon(
        const IconData(0xe91d, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
      Icon(
        const IconData(0xe91e, fontFamily: 'icomoon'),
        color: color ?? Palette.starYellow.withOpacity(0.4),
        size: size,
      ),
    ],
  );
}

Icon buildPostIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe917, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}

Icon buildCommentIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe90d, fontFamily: 'icomoon'),
    color: color ?? Palette.lightPurple,
    size: size,
  );
}

Stack buildSnowflakeIcon(double size, {Color? color}) {
  return Stack(
    children: [
      Icon(
        const IconData(0xe922, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco1,
        size: size,
      ),
      Icon(
        const IconData(0xe923, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco1,
        size: size,
      ),
      Icon(
        const IconData(0xe924, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco1,
        size: size,
      ),
      Icon(
        const IconData(0xe925, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe926, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe927, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe928, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe929, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92a, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92b, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92c, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92d, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92e, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe92f, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe930, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
      Icon(
        const IconData(0xe931, fontFamily: 'icomoon'),
        color: color ?? Palette.snowflakeIco2,
        size: size,
      ),
    ],
  );
}

Icon buildCrownIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe932, fontFamily: 'icomoon'),
    color: color ?? Palette.starYellow,
    size: size,
  );
}

buildLogoutIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe951, fontFamily: 'icomoon'),
    size: size,
    color: color ?? Palette.lightPurple,
  );
}

buildNebulaIcon({double? size, bool? returnIconData}) {
  if (returnIconData == true && size == null) {
    return const IconData(0xe937, fontFamily: 'icomoon');
  }
  return Icon(
    const IconData(0xe937, fontFamily: 'icomoon'),
    size: size,
    color: Palette.lightPurple,
  );
}

buildEarthIcon({double? size, bool? returnIconData}) {
  if (returnIconData == true && size == null) {
    return const IconData(0xe934, fontFamily: 'icomoon');
  }

  return Icon(
    const IconData(0xe934, fontFamily: 'icomoon'),
    size: size,
    color: Palette.lightPurple,
  );
}

buildExploreIcon({double? size, bool? returnIconData}) {
  if (returnIconData == true && size == null) {
    return const IconData(0xe935, fontFamily: 'icomoon');
  }

  return Icon(
    const IconData(0xe935, fontFamily: 'icomoon'),
    size: size,
    color: Palette.lightPurple,
  );
}

buildSparklePlusIcon(double size) {
  return Icon(
    const IconData(0xe936, fontFamily: 'icomoon'),
    size: size,
    color: Palette.starYellow,
  );
}

buildConstellationIcon({double? size, bool? returnIconData}) {
  if (returnIconData == true && size == null) {
    return const IconData(0xe953, fontFamily: 'icomoon');
  }

  return Icon(
    const IconData(0xe937, fontFamily: 'icomoon'),
    size: size,
    color: Palette.lightPurple,
  );
}

buildOutlinedStarIcon(double size) {
  return Icon(
    const IconData(0xe952, fontFamily: 'icomoon'),
    size: size,
    color: Palette.lightPurple,
  );
}

buildBlackHoleIcon(double size, {Color? color}) {
  return Icon(
    const IconData(0xe954, fontFamily: 'icomoon'),
    size: size,
    color: color ?? Palette.lightPurple,
  );
}
