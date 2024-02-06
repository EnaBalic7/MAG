import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../providers/genre_anime_provider.dart';
import '../screens/genres_screen.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/form_builder_datetime_picker.dart';
import '../widgets/form_builder_dropdown.dart';
import '../widgets/master_screen.dart';
import '../models/anime.dart';
import '../models/genre.dart';
import '../models/genre_anime.dart';
import '../models/search_result.dart';
import '../providers/anime_provider.dart';
import '../providers/genre_provider.dart';
import '../utils/colors.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/form_builder_filter_chip.dart';
import '../widgets/form_builder_text_field.dart';
import '../widgets/gradient_button.dart';

class AnimeDetailScreen extends StatefulWidget {
  Anime? anime;
  AnimeDetailScreen({Key? key, this.anime}) : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final _animeFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<_AnimeDetailScreenState> key =
      GlobalKey<_AnimeDetailScreenState>();
  Image? _image;
  Widget? _title;
  late AnimeProvider _animeProvider;
  late GenreProvider _genreProvider;
  late GenreAnimeProvider _genreAnimeProvider;
  late Future<SearchResult<Genre>> _genreFuture;
  Map<String, dynamic> _initialValue = {};
  bool? showGenresForm;
  final ScrollController _scrollController = ScrollController();

  double _savedScrollPosition = 0.0;

  @override
  void initState() {
    _initialValue = {
      'titleEn': widget.anime?.titleEn ?? "",
      'titleJp': widget.anime?.titleJp ?? "",
      'synopsis': widget.anime?.synopsis ?? "",
      'episodesNumber': widget.anime?.episodesNumber.toString() ?? "",
      'imageUrl': widget.anime?.imageUrl ?? "",
      'trailerUrl': widget.anime?.trailerUrl ?? "",
      'score': widget.anime?.score.toString() ?? "0.0",
      'beginAir': widget.anime?.beginAir ?? DateTime.now(),
      'finishAir': widget.anime?.finishAir ?? DateTime.now(),
      'season': widget.anime?.season ?? "Spring",
      'studio': widget.anime?.studio ?? ""
    };
    _image = _buildImage();
    _title = _buildTitle();
    _animeProvider = context.read<AnimeProvider>();
    _genreProvider = context.read<GenreProvider>();
    _genreAnimeProvider = context.read<GenreAnimeProvider>();
    _genreFuture = _genreProvider.get(filter: {"SortAlphabetically": "true"});

    _genreProvider.addListener(() {
      _reloadGenresList();
      if (widget.anime != null) {
        _updateAnimeGenres();
      }
    });

    super.initState();
  }

  void _updateAnimeGenres() async {
    var genreAnimeList = await _genreAnimeProvider
        .get(filter: {"AnimeId": "${widget.anime!.id!}"});

    if (mounted) {
      setState(() {
        widget.anime!.genreAnimes = genreAnimeList.result;
      });
    }
  }

  void _reloadGenresList() {
    if (mounted) {
      setState(() {
        _genreFuture =
            _genreProvider.get(filter: {"SortAlphabetically": "true"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      floatingButtonOnPressed: () async {
        await _saveAnimeData(context);
      },
      showFloatingActionButton: true,
      floatingActionButtonIcon:
          const Icon(Icons.save_rounded, size: 48, color: Palette.lightPurple),
      showBackArrow: true,
      titleWidget: _title,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: FormBuilder(
              key: _animeFormKey,
              initialValue: _initialValue,
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: _image,
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            double maxTextFieldWidth =
                                constraints.maxWidth / 2.5;

                            return Wrap(
                              children: [
                                MyFormBuilderTextField(
                                  name: "titleEn",
                                  labelText: "Title (English)",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  onChanged: (newTitle) {
                                    if (mounted) {
                                      setState(() {
                                        widget.anime?.titleEn = newTitle;
                                        _title = _buildTitle(title: newTitle!);
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "titleJp",
                                  labelText: "Title (Japanese)",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "episodesNumber",
                                  labelText: "Number of episodes",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    } else if (val.isNotEmpty == true &&
                                        int.tryParse(val) == null) {
                                      return "This field may only contain numbers.";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "score",
                                  labelText: "Score",
                                  fillColor: Palette.darkPurple,
                                  readOnly: true,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  keyboardType: TextInputType.number,
                                ),
                                MyDateTimePicker(
                                  name: "beginAir",
                                  labelText: "Began airing",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                ),
                                MyDateTimePicker(
                                  name: "finishAir",
                                  labelText: "Finished airing",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                ),
                                MyFormBuilderDropdown(
                                  name: "season",
                                  labelText: "Season",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  dropdownColor: Palette.disabledControl,
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'Spring', child: Text('Spring')),
                                    DropdownMenuItem(
                                        value: 'Summer', child: Text('Summer')),
                                    DropdownMenuItem(
                                        value: 'Fall', child: Text('Fall')),
                                    DropdownMenuItem(
                                        value: 'Winter', child: Text('Winter')),
                                  ],
                                  icon: buildSnowflakeIcon(24),
                                  onTap: () {
                                    _savedScrollPosition =
                                        _scrollController.position.pixels;
                                  },
                                  onChanged: (x) {
                                    _scrollController
                                        .jumpTo(_savedScrollPosition);
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "studio",
                                  labelText: "Studio",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 45,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "imageUrl",
                                  labelText: "Image URL",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.url(context),
                                  ]),
                                  onChanged: (newValue) {
                                    if (mounted) {
                                      setState(() {
                                        widget.anime?.imageUrl = newValue;
                                        _image =
                                            _buildImage(imageUrl: newValue!);
                                      });
                                    }
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "trailerUrl",
                                  labelText: "Trailer URL",
                                  fillColor: Palette.darkPurple,
                                  width: maxTextFieldWidth,
                                  height: 50,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.url(context),
                                  ]),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyFormBuilderTextField(
                          name: "synopsis",
                          labelText: "Synopsis",
                          fillColor: Palette.darkPurple,
                          // width: 1000,
                          // height: 500,
                          minLines: 10,
                          maxLines: 10,
                          borderRadius: 15,
                          paddingTop: 40,
                          paddingLeft: 0,
                          paddingBottom: 20,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<SearchResult<Genre>>(
                          future: _genreFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const MyProgressIndicator(); // Loading state
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // Error state
                            } else {
                              // Data loaded successfully
                              var genreList = snapshot.data!.result;

                              return MyFormBuilderFilterChip(
                                labelText: "Genres",
                                name: 'genres',
                                options: [
                                  ...genreList
                                      .map(
                                        (genre) => FormBuilderFieldOption(
                                          value: genre.id.toString(),
                                          child: Text(genre.name!,
                                              style: const TextStyle(
                                                  color:
                                                      Palette.midnightPurple)),
                                        ),
                                      )
                                      .toList(),
                                ],
                                initialValue: widget.anime?.genreAnimes
                                        ?.map(
                                            (genre) => genre.genreId.toString())
                                        .toList() ??
                                    [],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GradientButton(
                          onPressed: () {
                            //_showOverlayForm(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const GenresScreen())));
                          },
                          width: 75,
                          height: 30,
                          gradient: Palette.buttonGradient,
                          borderRadius: 50,
                          child: const Icon(Icons.add_rounded,
                              size: 20, color: Palette.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAnimeData(BuildContext context) async {
    _animeFormKey.currentState?.saveAndValidate();
    var request = Map.from(_animeFormKey.currentState!.value);
    Anime? response;

    try {
      if (widget.anime == null) {
        response = await _animeProvider.insert(request);
        if (mounted) {
          setState(() {
            widget.anime = response;
          });
        }

        showInfoDialog(
            context,
            const Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            const Text(
              "Added successfully!",
              textAlign: TextAlign.center,
            ));
      } else {
        await _animeProvider.update(widget.anime!.id!, request: request);
        showInfoDialog(
            context,
            const Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            const Text(
              "Updated successfully!",
              textAlign: TextAlign.center,
            ));
      }

      var selectedGenres =
          (_animeFormKey.currentState?.value['genres'] as List?)
                  ?.whereType<String>()
                  .toList() ??
              [];

      if (selectedGenres.isNotEmpty) {
        List<GenreAnime> genreAnimeInsertList = [];

        for (var genreId in selectedGenres) {
          genreAnimeInsertList
              .add(GenreAnime(null, int.parse(genreId), widget.anime!.id!));
        }

        await _genreAnimeProvider.updateGenresForAnime(
            widget.anime!.id!, genreAnimeInsertList);
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  Text _buildTitle({String title = ""}) {
    if (title.isEmpty) {
      if (widget.anime?.titleEn?.isEmpty ?? true) {
        return const Text("Untitled");
      } else {
        return Text("${widget.anime?.titleEn}");
      }
    } else {
      return Text(title);
    }
  }

//^https?:\/\/.*\.(png|jpg|jpeg|gif|bmp|webp)$
//^https:\/\/cdn\.myanimelist\.net\/images\/anime\/.*\.jpg$
  Image _buildImage({String imageUrl = ""}) {
    if (imageUrl == "") {
      if (widget.anime?.imageUrl == null) {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      } else if (widget.anime!.imageUrl!.startsWith(
          RegExp(r'^https?:\/\/.*\.(png|jpg|jpeg|gif|bmp|webp)$'))) {
        return Image.network(
          widget.anime?.imageUrl ?? "",
          width: 400,
          height: 500,
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      }
    } else {
      if (imageUrl.startsWith(
          RegExp(r'^https?:\/\/.*\.(png|jpg|jpeg|gif|bmp|webp)$'))) {
        return Image.network(
          imageUrl,
          width: 400,
          height: 500,
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      }
    }
  }
}
