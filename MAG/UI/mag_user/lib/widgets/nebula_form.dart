import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/widgets/form_builder_datetime_picker.dart';
import 'package:mag_user/widgets/form_builder_text_field.dart';
import 'package:mag_user/widgets/numeric_step_button.dart';

import '../models/anime.dart';
import '../utils/colors.dart';
import 'form_builder_choice_chip.dart';
import 'gradient_button.dart';

class NebulaForm extends StatefulWidget {
  final Anime anime;
  const NebulaForm({Key? key, required this.anime}) : super(key: key);

  @override
  State<NebulaForm> createState() => _NebulaFormState();
}

class _NebulaFormState extends State<NebulaForm> {
  final _nebulaFormKey = GlobalKey<FormBuilderState>();

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
        child: FormBuilder(
          key: _nebulaFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.anime.titleEn}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(name: "progress", options: const [
                  FormBuilderFieldOption(value: "Watching"),
                  FormBuilderFieldOption(value: "Completed"),
                  FormBuilderFieldOption(value: "On Hold"),
                  FormBuilderFieldOption(value: "Dropped"),
                  FormBuilderFieldOption(value: "Plan to Watch"),
                ]),
                Row(
                  children: const [
                    Text(
                      "Progress",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const NumericStepButton(
                  minValue: 0,
                  maxValue: 1000,
                ),
                Row(
                  children: const [
                    Text(
                      "Score",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(
                    name: "score",
                    selectedColor: Palette.starYellow,
                    options: const [
                      FormBuilderFieldOption(value: "10"),
                      FormBuilderFieldOption(value: "9"),
                      FormBuilderFieldOption(value: "8"),
                      FormBuilderFieldOption(value: "7"),
                      FormBuilderFieldOption(value: "6"),
                      FormBuilderFieldOption(value: "5"),
                      FormBuilderFieldOption(value: "4"),
                      FormBuilderFieldOption(value: "3"),
                      FormBuilderFieldOption(value: "2"),
                      FormBuilderFieldOption(value: "1"),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                MyFormBuilderTextField(
                  name: "review",
                  labelText: "Review",
                  fillColor: Palette.textFieldPurple.withOpacity(0.5),
                  height: 54,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  paddingBottom: 10,
                  keyboardType: TextInputType.multiline,
                  borderRadius: 20,
                ),
                Row(
                  children: const [
                    Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDateTimePicker(
                  name: "start",
                  labelText: "Began watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 35,
                  borderRadius: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyDateTimePicker(
                  name: "end",
                  labelText: "Finished watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 35,
                  borderRadius: 50,
                ),
                GradientButton(
                  onPressed: () {},
                  borderRadius: 50,
                  height: 30,
                  width: 120,
                  paddingTop: 20,
                  gradient: Palette.buttonGradient,
                  child: const Text(
                    "Add to Nebula",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
