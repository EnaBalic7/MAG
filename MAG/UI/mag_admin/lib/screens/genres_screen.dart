import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/genre.dart';
import '../models/search_result.dart';
import '../providers/genre_provider.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/form_builder_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/master_screen.dart';
import '../utils/colors.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  final _genreFormKey = GlobalKey<FormBuilderState>();
  late GenreProvider _genreProvider;
  late Future<SearchResult<Genre>> _genreFuture;

  @override
  void initState() {
    _genreProvider = context.read<GenreProvider>();
    _genreFuture = _genreProvider.get(filter: {"SortAlphabetically": "true"});

    context.read<GenreProvider>().addListener(() {
      _reloadGenresList();
    });

    super.initState();
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
      titleWidget: const Text("Genres"),
      showBackArrow: true,
      child: Stack(
        children: [
          _buildGenresForm(context),
          Positioned(
            left: 120,
            top: 25,
            child: Image.asset(
              "assets/images/mikasa.png",
              width: 400,
            ),
          ),
          Positioned(
            right: 130,
            bottom: 40,
            child: Image.asset(
              "assets/images/eren.png",
              width: 400,
            ),
          ),
        ],
      ),
    );
  }

  /*void _showOverlayForm(BuildContext context) {
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
                right: 270,
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
  }*/

  Widget _buildGenresForm(BuildContext context) {
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
            padding: const EdgeInsets.all(16.0),
            width: 500.0,
            height: 550.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                FormBuilder(
                  key: _genreFormKey,
                  child: FutureBuilder<SearchResult<Genre>>(
                    future: _genreFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyProgressIndicator(); // Loading state
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
                                    const SizedBox(width: 5),
                                    GradientButton(
                                        onPressed: () {
                                          _saveGenre(context);
                                        },
                                        width: 80,
                                        height: 30,
                                        borderRadius: 50,
                                        gradient: Palette.buttonGradient,
                                        child: const Text("Add",
                                            style: TextStyle(
                                                color: Palette.white,
                                                fontWeight: FontWeight.w500))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      children: _buildGenres(genreList),
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
              padding: const EdgeInsets.all(5.4),
              decoration: BoxDecoration(
                  color: Palette.textFieldPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${genreList[index].name}",
                      style: const TextStyle(fontSize: 15)),
                  GestureDetector(
                      onTap: () {
                        showConfirmationDialog(
                            context,
                            const Icon(Icons.warning_rounded,
                                color: Palette.lightRed, size: 55),
                            const Text(
                                "Are you sure you want to delete this genre?"),
                            () async {
                          await _genreProvider.delete(genreList[index].id!);
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
          const Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
          const Text(
            "Added successfully!",
            textAlign: TextAlign.center,
          ));
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }
}
