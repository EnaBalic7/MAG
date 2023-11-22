import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/form_builder_datetime_picker.dart';
import 'package:mag_admin/widgets/form_builder_dropdown.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../providers/anime_provider.dart';
import '../utils/colors.dart';
import '../widgets/form_builder_text_field.dart';
import '../widgets/gradient_button.dart';

class AnimeDetailScreen extends StatefulWidget {
  Anime? anime;
  AnimeDetailScreen({Key? key, this.anime}) : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Image? _image;
  Widget? _title;
  late AnimeProvider _animeProvider;
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      floatingButtonOnPressed: () async {
        _formKey.currentState?.saveAndValidate();
        var request = Map.from(_formKey.currentState!.value);

        try {
          if (widget.anime == null) {
            await _animeProvider.insert(request);
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
        } on Exception catch (e) {
          showErrorDialog(context, e);
        }
      },
      showFloatingActionButton: true,
      floatingActionButtonIcon:
          Icon(Icons.save_rounded, size: 48, color: Palette.lightPurple),
      showBackArrow: true,
      title_widget: _title,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: FormBuilder(
              key: _formKey,
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
                        child: Wrap(
                          children: [
                            MyFormBuilderTextField(
                              name: "titleEn",
                              labelText: "Title (English)",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
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
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                            MyFormBuilderTextField(
                              name: "episodesNumber",
                              labelText: "Number of episodes",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
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
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                              keyboardType: TextInputType.number,
                            ),
                            MyDateTimePicker(
                              name: "beginAir",
                              labelText: "Began airing",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                            ),
                            MyDateTimePicker(
                              name: "finishAir",
                              labelText: "Finished airing",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                            ),
                            MyFormBuilderDropdown(
                              name: "season",
                              labelText: "Season",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                              icon: Icon(
                                Icons.sunny_snowing,
                                color: Palette.lightPurple,
                              ),
                              //initialValue: _initialValue['season'],
                            ),
                            MyFormBuilderTextField(
                              name: "studio",
                              labelText: "Studio",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                            MyFormBuilderTextField(
                              name: "imageUrl",
                              labelText: "Image URL",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 50,
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
                              width: 500,
                              height: 50,
                              borderRadius: 50,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.url(context),
                              ]),
                            ),
                          ],
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
                          width: 1000,
                          height: 200,
                          borderRadius: 15,
                          maxLines: null,
                          paddingTop: 40,
                          paddingLeft: 0,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
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

  Image _buildImage({String imageUrl = ""}) {
    if (imageUrl == "") {
      if (widget.anime?.imageUrl == null) {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      } else if (widget.anime!.imageUrl!.startsWith(RegExp(
          r'^https:\/\/cdn\.myanimelist\.net\/images\/anime\/.*\.jpg$'))) {
        return Image.network(
          widget.anime?.imageUrl ?? "",
          width: 400,
        );
      } else {
        return Image.asset(
          "assets/images/emptyImg.png",
          width: 400,
        );
      }
    } else {
      if (imageUrl.startsWith(RegExp(
          r'^https:\/\/cdn\.myanimelist\.net\/images\/anime\/.*\.jpg$'))) {
        return Image.network(
          imageUrl,
          width: 400,
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
