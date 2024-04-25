import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/models/search_result.dart';
import 'package:mag_user/providers/anime_list_provider.dart';
import 'package:mag_user/providers/listt_provider.dart';
import 'package:mag_user/utils/util.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/anime_list.dart';
import '../models/listt.dart';
import '../utils/colors.dart';
import 'circular_progress_indicator.dart';
import 'form_builder_filter_chip.dart';

class ConstellationForm extends StatefulWidget {
  final Anime anime;
  const ConstellationForm({Key? key, required this.anime}) : super(key: key);

  @override
  State<ConstellationForm> createState() => _ConstellationFormState();
}

class _ConstellationFormState extends State<ConstellationForm> {
  late final ListtProvider _listtProvider;
  late Future<SearchResult<Listt>> _listtFuture;
  late final AnimeListProvider _animeListProvider;
  SearchResult<AnimeList> animeList = SearchResult<AnimeList>();

  @override
  void initState() {
    _listtProvider = context.read<ListtProvider>();
    _listtFuture =
        _listtProvider.get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _animeListProvider = context.read<AnimeListProvider>();

    getAnimeListData();

    super.initState();
  }

  void getAnimeListData() async {
    animeList =
        await _animeListProvider.get(filter: {"AnimeId": "${widget.anime.id}"});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(17),
        alignment: Alignment.center,
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Palette.darkPurple,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Palette.lightPurple.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Add ',
                          style: TextStyle(color: Palette.lightPurple)),
                      TextSpan(
                        text: '${widget.anime.titleEn}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Palette.rose),
                      ),
                      const TextSpan(
                          text: ' to selected Stars:',
                          style: TextStyle(color: Palette.lightPurple)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<SearchResult<Listt>>(
                    future: _listtFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        // Data loaded successfully
                        var stars = snapshot.data!.result;
                        return MyFormBuilderFilterChip(
                          labelText: "Your Stars",
                          name: '',
                          options: [
                            ...stars
                                .map(
                                  (star) => FormBuilderFieldOption(
                                    value: star.id.toString(),
                                    child: Text(star.name!,
                                        style: const TextStyle(
                                            color: Palette.midnightPurple)),
                                  ),
                                )
                                .toList(),
                          ],
                          initialValue: animeList.result
                              .map((animeList) => animeList.listId.toString())
                              .toList(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
