import 'package:flutter/material.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  late AnimeProvider _animeProvider;
  SearchResult<Anime>? result;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _animeProvider = context.read<AnimeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard(),
              buildAnimeCard()
            ],
          ),
        ),
      ),
      title_widget: Text("Anime"),
    );
  }

  Container buildAnimeCard() {
    return Container(
        width: 290,
        height: 403,
        margin: EdgeInsets.only(top: 20, left: 20, right: 0, bottom: 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.network(
                "https://wallpapers.com/images/hd/anime-girl-background-bs0kczie5vqucxqj.jpg",
                // width: 265,
                height: 195,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                  child: Row(
                    children: [
                      buildStarIcon(15),
                      SizedBox(width: 3),
                      Text("8.75",
                          style: TextStyle(
                              color: Palette.starYellow, fontSize: 11)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 5),
                    child: Text(
                      "When the Wind Blows",
                      overflow: TextOverflow.clip,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Text(
                          "'A believing heart is your magic!'—these were the words that Atsuko 'Akko' Kagari's idol, the renowned witch Shiny Chariot, said to her during a magic performance years ago. Since then, Akko has lived by these words and aspired to be a witch just like Shiny Chariot, one that can make people, 'A believing heart is your magic!'—these were the words that Atsuko 'Akko' Kagari's idol, the renowned witch Shiny Chariot, said to her during a magic performance years ago. Since then, Akko has lived by these words and aspired to be a witch just like Shiny Chariot, one that can make people"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
