import 'package:flutter/material.dart';
import 'package:mag_user/models/search_result.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/master_screen.dart';

import '../models/anime_list.dart';
import '../models/listt.dart';

class ConstellationDetailScreen extends StatefulWidget {
  final int selectedIndex;
  final Listt star;
  final List<AnimeList> animeListData;
  const ConstellationDetailScreen({
    Key? key,
    required this.selectedIndex,
    required this.star,
    required this.animeListData,
  }) : super(key: key);

  @override
  State<ConstellationDetailScreen> createState() =>
      _ConstellationDetailScreenState();
}

class _ConstellationDetailScreenState extends State<ConstellationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        showBackArrow: true,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${widget.star.name}"),
            const SizedBox(width: 5),
            buildStarTrailIcon(24),
          ],
        ),
        child: Text("Constellation details"));
  }
}
