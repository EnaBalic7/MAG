import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

// ignore: must_be_immutable
class AnimeDetailScreen extends StatefulWidget {
  Anime? anime;
  AnimeDetailScreen({super.key, this.anime});

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
  String? imageUrlValue;
  String? titleEnValue;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();
  final FocusNode _focusNode10 = FocusNode();

  DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.contains("0001-01-01")) {
      return null;
    }

    return DateTime.tryParse(dateString);
  }

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
      'beginAir': parseDate(widget.anime?.beginAir!.toIso8601String()),
      'finishAir': parseDate(widget.anime?.finishAir!.toIso8601String()),
      'season': widget.anime?.season ?? "Spring",
      'studio': widget.anime?.studio ?? ""
    };
    imageUrlValue = widget.anime?.imageUrl ?? "";
    titleEnValue = widget.anime?.titleEn ?? "";
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

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    _focusNode7.dispose();
    _focusNode8.dispose();
    _focusNode9.dispose();
    _focusNode10.dispose();

    super.dispose();
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
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  focusNode: _focusNode1,
                                  onChanged: (newTitle) {
                                    if (mounted) {
                                      setState(() {
                                        titleEnValue = newTitle;
                                        _title = _buildTitle(title: newTitle!);
                                      });
                                    }
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    } else if (val.length > 200) {
                                      return "Character limit exceeded: ${val.length}/200";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "titleJp",
                                  labelText: "Title (Japanese)",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  focusNode: _focusNode2,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    } else if (val.length > 200) {
                                      return "Character limit exceeded: ${val.length}/200";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "episodesNumber",
                                  labelText: "Number of episodes",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  keyboardType: TextInputType.number,
                                  focusNode: _focusNode3,
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
                                  readOnly: true,
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  keyboardType: TextInputType.number,
                                  focusNode: _focusNode4,
                                ),
                                MyDateTimePicker(
                                  name: "beginAir",
                                  labelText: "Began airing",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth * 0.93,
                                  formKey: _animeFormKey,
                                  focusNode: _focusNode9,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: (val) {
                                    final beginAir = _animeFormKey
                                        .currentState
                                        ?.fields["beginAir"]
                                        ?.value as DateTime?;
                                    final finishAir = _animeFormKey
                                        .currentState
                                        ?.fields["finishAir"]
                                        ?.value as DateTime?;

                                    if (beginAir != null &&
                                        finishAir != null &&
                                        beginAir.isAfter(finishAir)) {
                                      return "Begin date cannot be after finish date.";
                                    } else if (beginAir != null &&
                                        beginAir.isAfter(DateTime.now())) {
                                      return "Begin date cannot be in the future";
                                    }

                                    return null;
                                  },
                                ),
                                MyDateTimePicker(
                                  name: "finishAir",
                                  labelText: "Finished airing",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth * 0.91,
                                  formKey: _animeFormKey,
                                  focusNode: _focusNode10,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  validator: (val) {
                                    final beginAir = _animeFormKey
                                        .currentState
                                        ?.fields["beginAir"]
                                        ?.value as DateTime?;
                                    final finishAir = _animeFormKey
                                        .currentState
                                        ?.fields["finishAir"]
                                        ?.value as DateTime?;

                                    if (beginAir != null &&
                                        finishAir != null &&
                                        finishAir.isBefore(beginAir)) {
                                      return "Finish date cannot be before begin date.";
                                    } else if (finishAir != null &&
                                        finishAir.isAfter(DateTime.now())) {
                                      return "Finish date cannot be in the future";
                                    }

                                    return null;
                                  },
                                ),
                                MyFormBuilderDropdown(
                                  name: "season",
                                  labelText: "Season",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  dropdownColor: Palette.dropdownMenu,
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
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  focusNode: _focusNode5,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    } else if (val.length > 50) {
                                      return "Character limit exceeded: ${val.length}/50";
                                    }
                                    return null;
                                  },
                                ),
                                MyFormBuilderTextField(
                                  name: "imageUrl",
                                  labelText: "Image URL",
                                  fillColor:
                                      Palette.textFieldPurple.withOpacity(0.3),
                                  width: maxTextFieldWidth,
                                  paddingLeft: 40,
                                  paddingBottom: 50,
                                  borderRadius: 50,
                                  focusNode: _focusNode6,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "This field cannot be empty.";
                                    } else if (!isValidImageUrl(val)) {
                                      return "URL is not valid.";
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    if (mounted) {
                                      setState(() {
                                        imageUrlValue = newValue;
                                        _image =
                                            _buildImage(imageUrl: newValue!);
                                      });
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFormBuilderTextField(
                                        name: "trailerUrl",
                                        labelText: "Trailer URL",
                                        fillColor: Palette.textFieldPurple
                                            .withOpacity(0.3),
                                        width: maxTextFieldWidth,
                                        paddingLeft: 40,
                                        paddingBottom: 50,
                                        borderRadius: 50,
                                        focusNode: _focusNode7,
                                        validator: (val) {
                                          if (val != null &&
                                              val.isNotEmpty &&
                                              !isValidYouTubeUrl(val)) {
                                            return "Not a valid YouTube URL.";
                                          }
                                          return null;
                                        }),
                                    Tooltip(
                                      message: "Watch in YouTube",
                                      child: IconButton(
                                          onPressed: () async {
                                            var youtubeUrl = _animeFormKey
                                                .currentState
                                                ?.fields["trailerUrl"]
                                                ?.value;

                                            if (await canLaunchUrl(
                                                Uri.parse(youtubeUrl))) {
                                              await launchUrl(
                                                  Uri.parse(youtubeUrl),
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            } else {
                                              if (context.mounted) {
                                                showInfoDialog(
                                                    context,
                                                    const Icon(
                                                      Icons.warning_rounded,
                                                      color: Palette.lightRed,
                                                      size: 55,
                                                    ),
                                                    Text(
                                                        "Could not launch video with URL: $youtubeUrl"));
                                              }
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.open_in_new_rounded,
                                              color: Palette.lightPurple)),
                                    )
                                  ],
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
                          fillColor: Palette.textFieldPurple.withOpacity(0.3),
                          minLines: 10,
                          maxLines: 10,
                          borderRadius: 15,
                          paddingTop: 40,
                          paddingLeft: 0,
                          paddingBottom: 20,
                          focusNode: _focusNode8,
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                            top: 30,
                            right: 10,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "This field cannot be empty"),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GradientButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const GenresScreen())));
                          },
                          width: 75,
                          height: 32,
                          gradient: Palette.buttonGradient,
                          paddingTop: 5,
                          paddingRight: 8,
                          borderRadius: 50,
                          child: const Icon(Icons.add_rounded,
                              size: 20, color: Palette.white),
                        ),
                      ),
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
                                  ...genreList.map(
                                    (genre) => FormBuilderChipOption(
                                      value: genre.id.toString(),
                                      child: Text(genre.name!,
                                          style: const TextStyle(
                                              color: Palette.midnightPurple)),
                                    ),
                                  ),
                                ],
                                initialValue: widget.anime?.genreAnimes
                                        ?.map(
                                            (genre) => genre.genreId.toString())
                                        .toList() ??
                                    [],
                                validator: (val) {
                                  if (val != null && val.isEmpty) {
                                    return "Must select at least one genre.";
                                  }
                                  return null;
                                },
                              );
                            }
                          },
                        ),
                      ),
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
    if (_animeFormKey.currentState?.saveAndValidate() == true) {
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

          if (context.mounted) {
            showInfoDialog(
                context,
                const Icon(Icons.task_alt,
                    color: Palette.lightPurple, size: 50),
                const Text(
                  "Added successfully!",
                  textAlign: TextAlign.center,
                ));
          }
        } else {
          await _animeProvider.update(widget.anime!.id!, request: request);

          if (context.mounted) {
            showInfoDialog(
                context,
                const Icon(Icons.task_alt,
                    color: Palette.lightPurple, size: 50),
                const Text(
                  "Updated successfully!",
                  textAlign: TextAlign.center,
                ));
          }
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
        if (context.mounted) {
          showErrorDialog(context, e);
        }
      }
    } else {
      showInfoDialog(
          context,
          const Icon(Icons.warning_rounded, color: Palette.lightRed, size: 50),
          const Text(
            "There are validation errors.",
            textAlign: TextAlign.center,
          ));
    }
  }

  Text _buildTitle({String title = ""}) {
    if (title.isEmpty) {
      if (widget.anime?.titleEn?.isEmpty ?? true) {
        return const Text("Untitled");
      } else {
        return Text("$titleEnValue");
      }
    } else {
      return Text(title);
    }
  }

  Image _buildImage({String imageUrl = ""}) {
    if (imageUrl == "") {
      if (widget.anime?.imageUrl == null ||
          imageUrlValue == null ||
          imageUrlValue == "") {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      } else if (widget.anime!.imageUrl!.startsWith(
          RegExp(r'^https?:\/\/.*\.(png|jpg|jpeg|gif|bmp|webp)$'))) {
        return Image.network(
          imageUrlValue ?? "",
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
