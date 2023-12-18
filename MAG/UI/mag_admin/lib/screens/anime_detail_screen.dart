import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/providers/genre_anime_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/form_builder_datetime_picker.dart';
import 'package:mag_admin/widgets/form_builder_dropdown.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/genre.dart';
import '../models/search_result.dart';
import '../providers/anime_provider.dart';
import '../providers/genre_provider.dart';
import '../utils/colors.dart';
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
  @override
  final _animeFormKey = GlobalKey<FormBuilderState>();
  final _genreFormKey = GlobalKey<FormBuilderState>();
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
  ScrollController _scrollController = ScrollController();

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
    _genreFuture = _genreProvider.get();

    context.read<GenreProvider>().addListener(() {
      _reloadGenresList();
    });

    super.initState();
  }

  void _reloadGenresList() {
    if (mounted) {
      setState(() {
        _genreFuture = context.read<GenreProvider>().get();
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
          Icon(Icons.save_rounded, size: 48, color: Palette.lightPurple),
      showBackArrow: true,
      title_widget: _title,
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
                                    setState(() {
                                      widget.anime?.titleEn = newTitle;
                                      _title = _buildTitle(title: newTitle!);
                                    });
                                  },
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
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
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
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
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.integer(context),
                                  ]),
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
                                  items: [
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
                                  //initialValue: _initialValue['season'],
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
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
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
                                    setState(() {
                                      widget.anime?.imageUrl = newValue;
                                      _image = _buildImage(imageUrl: newValue!);
                                    });
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
                                    FormBuilderValidators.required(context),
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
                              return CircularProgressIndicator(); // Loading state
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
                                              style: TextStyle(
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
                            _showOverlayForm(context);
                          },
                          width: 75,
                          height: 30,
                          gradient: Palette.buttonGradient,
                          borderRadius: 50,
                          child: Icon(Icons.add_rounded,
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

  void _showOverlayForm(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: Palette.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 1,
          //width: MediaQuery.of(context).size.width * 1,
          child: Stack(
            children: [
              _buildOverlayForm(context),
              Positioned(
                left: 170,
                top: 25,
                child: Image.asset(
                  "assets/images/mikasa.png",
                  width: 400,
                ),
              ),
              Positioned(
                right: 350,
                bottom: 40,
                child: Image.asset(
                  "assets/images/eren.png",
                  width: 300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverlayForm(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Palette.lightPurple.withOpacity(0.2)),
              color: Palette.darkPurple,
            ),
            padding: EdgeInsets.all(16.0),
            width: 500.0,
            height: 450.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close_rounded))
                  ],
                ),
                FormBuilder(
                  key: _genreFormKey,
                  child: FutureBuilder<SearchResult<Genre>>(
                    future: _genreFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        var genreList = snapshot.data!.result;

                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyFormBuilderTextField(
                                      name: "name",
                                      labelText: "Genre name",
                                      fillColor: Palette.disabledControl,
                                      width: 300,
                                      height: 50,
                                      borderRadius: 50,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                    ),
                                    SizedBox(width: 5),
                                    GradientButton(
                                        onPressed: () {
                                          _saveGenre(context);
                                        },
                                        width: 80,
                                        height: 30,
                                        borderRadius: 50,
                                        gradient: Palette.buttonGradient,
                                        child: Text("Add",
                                            style: TextStyle(
                                                color: Palette.white,
                                                fontWeight: FontWeight.w500))),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      child: Wrap(
                                        children: _buildGenres(genreList),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGenres(List<Genre> genreList) {
    return List.generate(
      genreList.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              //width: 100,
              height: 30,
              padding: EdgeInsets.all(5.4),
              decoration: BoxDecoration(
                  color: Palette.textFieldPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${genreList[index].name}",
                      style: TextStyle(fontSize: 15)),
                  GestureDetector(
                      onTap: () {
                        showConfirmationDialog(
                            context,
                            Icon(Icons.warning_rounded,
                                color: Palette.lightRed, size: 55),
                            Text("Are you sure you want to delete this genre?"),
                            () async {
                          await _genreAnimeProvider
                              .deleteByGenreId(genreList[index].id!);
                          _genreProvider.delete(genreList[index].id!);
                        });
                      },
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: buildTrashIcon(20)))
                ],
              )),
        );
      },
    );
  }

  Future<void> _saveGenre(BuildContext context) async {
    _genreFormKey.currentState?.saveAndValidate();
    var request = Map.from(_genreFormKey.currentState!.value);
    try {
      await _genreProvider.insert(request);
      showInfoDialog(
          context,
          Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
          Text(
            "Added successfully!",
            textAlign: TextAlign.center,
          ));
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  Future<void> _saveAnimeData(BuildContext context) async {
    _animeFormKey.currentState?.saveAndValidate();
    var request = Map.from(_animeFormKey.currentState!.value);
    Anime? response;

    try {
      if (widget.anime == null) {
        response = await _animeProvider.insert(request);
        showInfoDialog(
            context,
            Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            Text(
              "Added successfully!",
              textAlign: TextAlign.center,
            ));
      } else {
        await _animeProvider.update(widget.anime!.id!, request: request);
        showInfoDialog(
            context,
            Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            Text(
              "Updated successfully!",
              textAlign: TextAlign.center,
            ));
      }

      if (widget.anime == null && response != null) {
        widget.anime = response;
      }

      var selectedGenres =
          (_animeFormKey.currentState?.value['genres'] as List?)
                  ?.whereType<String>()
                  .toList() ??
              [];

      await _genreAnimeProvider.saveGenresForAnime(
          widget.anime!.id!, selectedGenres);
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  Text _buildTitle({String title = ""}) {
    if (title.isEmpty) {
      if (widget.anime?.titleEn?.isEmpty ?? true) {
        return Text("Untitled");
      } else {
        return Text("${widget.anime?.titleEn}");
      }
    } else {
      return Text("$title");
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
