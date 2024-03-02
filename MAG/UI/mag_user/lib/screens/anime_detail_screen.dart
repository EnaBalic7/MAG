import 'package:flutter/material.dart';
import 'package:mag_user/widgets/master_screen.dart';

import '../models/anime.dart';

class AnimeDetailScreen extends StatefulWidget {
  Anime anime;
  final int selectedIndex;
  AnimeDetailScreen(
      {Key? key, required this.selectedIndex, required this.anime})
      : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: true,
        title: "Anime details",
        child: Text("${widget.anime.titleEn}"));
  }
}
