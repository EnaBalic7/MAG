import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../providers/anime_list_provider.dart';
import '../providers/listt_provider.dart';
import '../utils/util.dart';
import '../widgets/gradient_button.dart';
import '../models/anime.dart';
import '../models/anime_list.dart';
import '../models/listt.dart';
import '../utils/colors.dart';
import 'circular_progress_indicator.dart';
import 'form_builder_filter_chip.dart';

class ConstellationForm extends StatefulWidget {
  final Anime anime;
  const ConstellationForm({super.key, required this.anime});

  @override
  State<ConstellationForm> createState() => _ConstellationFormState();
}

class _ConstellationFormState extends State<ConstellationForm> {
  late final ListtProvider _listtProvider;
  late Future<SearchResult<Listt>> _listtFuture;
  late final AnimeListProvider _animeListProvider;
  late Future<SearchResult<AnimeList>> _animeListFuture;
  final _constellationFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _listtProvider = context.read<ListtProvider>();
    _listtFuture =
        _listtProvider.get(filter: {"UserId": "${LoggedUser.user!.id}"});

    _animeListProvider = context.read<AnimeListProvider>();

    _animeListFuture =
        _animeListProvider.get(filter: {"AnimeId": "${widget.anime.id}"});

    super.initState();
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
                      return FormBuilder(
                        key: _constellationFormKey,
                        child: FutureBuilder<SearchResult<AnimeList>>(
                            future: _animeListFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const MyProgressIndicator(); // Loading state
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error: ${snapshot.error}'); // Error state
                              } else {
                                // Data loaded successfully
                                var selectedStars = snapshot.data!.result;

                                return MyFormBuilderFilterChip(
                                  labelText: "Your Stars",
                                  name: 'stars',
                                  fontSize: 20,
                                  options: [
                                    ...stars.map(
                                      (star) => FormBuilderChipOption(
                                        value: star.id.toString(),
                                        child: Text(star.name!,
                                            style: const TextStyle(
                                                color: Palette.midnightPurple)),
                                      ),
                                    ),
                                  ],
                                  initialValue: selectedStars
                                      .where((animeList) => stars.any(
                                          (listItem) =>
                                              listItem.id == animeList.listId))
                                      .map((animeList) =>
                                          animeList.listId.toString())
                                      .toList(),
                                );
                              }
                            }),
                      );
                    }
                  }),
              const SizedBox(height: 30),
              GradientButton(
                  onPressed: () async {
                    try {
                      _constellationFormKey.currentState?.saveAndValidate();

                      var selectedStars = (_constellationFormKey
                                  .currentState?.value['stars'] as List?)
                              ?.whereType<String>()
                              .toList() ??
                          [];

                      List<AnimeList> animeListInsert = [];

                      if (selectedStars.isNotEmpty) {
                        for (var listId in selectedStars) {
                          animeListInsert.add(AnimeList(
                              null, int.parse(listId), widget.anime.id, null));
                        }
                      }

                      await _animeListProvider.updateListsForAnime(
                          widget.anime.id!, animeListInsert);

                      if (context.mounted) {
                        showInfoDialog(
                            context,
                            const Icon(Icons.task_alt,
                                color: Palette.lightPurple, size: 50),
                            const Text(
                              "Saved successfully!",
                              textAlign: TextAlign.center,
                            ));
                      }
                    } on Exception catch (e) {
                      if (context.mounted) {
                        showErrorDialog(context, e);
                      }
                    }
                  },
                  width: 60,
                  height: 30,
                  borderRadius: 50,
                  gradient: Palette.buttonGradient,
                  child: const Text("Save",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Palette.white)))
            ],
          ),
        ),
      ),
    );
  }
}
