import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_admin/widgets/master_screen.dart';

import '../models/anime.dart';
import '../utils/colors.dart';
import '../widgets/form_builder_text_field.dart';

class AnimeDetailScreen extends StatefulWidget {
  Anime? anime;
  AnimeDetailScreen({Key? key, this.anime}) : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      showBackArrow: true,
      title_widget: Text(widget.anime?.titleEn.toString() ?? "Untitled"),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.anime?.imageUrl ?? "",
                          width: 400,
                        ),
                      ),
                      Expanded(
                        child: Wrap(
                          children: [
                            MyFormBuilderTextField(
                              name: "titleEn",
                              labelText: "Title (English)",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              initialValue: widget.anime?.titleEn ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "titleJp",
                              labelText: "Title (Japanese)",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              initialValue: widget.anime?.titleJp ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "episodesNumber",
                              labelText: "Number of episodes",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              keyboardType: TextInputType.number,
                              initialValue:
                                  widget.anime?.episodesNumber.toString() ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "score",
                              labelText: "Score",
                              fillColor: Palette.darkPurple,
                              readOnly: true,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              keyboardType: TextInputType.number,
                              initialValue:
                                  widget.anime?.score.toString() ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "beginAir",
                              labelText: "Began airing",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              keyboardType: TextInputType.datetime,
                              initialValue:
                                  widget.anime?.beginAir.toString() ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "finishAir",
                              labelText: "Finished airing",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              keyboardType: TextInputType.datetime,
                              initialValue:
                                  widget.anime?.finishAir.toString() ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "season",
                              labelText: "Season",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              initialValue: widget.anime?.season ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "studio",
                              labelText: "Studio",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              initialValue: widget.anime?.studio ?? "",
                            ),
                            MyFormBuilderTextField(
                              name: "imageUrl",
                              labelText: "Image URL",
                              fillColor: Palette.darkPurple,
                              width: 500,
                              height: 45,
                              borderRadius: 50,
                              initialValue: widget.anime?.imageUrl ?? "",
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
                          initialValue: widget.anime?.synopsis ?? "",
                          maxLines: null,
                          paddingTop: 40,
                          paddingLeft: 0,
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
}
