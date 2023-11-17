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
      child: Center(
          child: Wrap(
        children: [
          Image.network(widget.anime?.imageUrl ?? ""),
          FormBuilder(
            key: _formKey,
            child: Wrap(
              children: [
                MyFormBuilderTextField(
                  name: "titleEn",
                  hintText: "Title (English)",
                  fillColor: Palette.textFieldPurple.withOpacity(0.9),
                  obscureText: false,
                  width: 350,
                  height: 38,
                  borderRadius: 15,
                ),
                MyFormBuilderTextField(
                  name: "titleJp",
                  hintText: "Title (Japanese)",
                  fillColor: Palette.textFieldPurple.withOpacity(0.9),
                  obscureText: false,
                  width: 350,
                  height: 38,
                  borderRadius: 15,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
