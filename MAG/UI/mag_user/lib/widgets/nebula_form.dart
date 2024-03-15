import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/providers/anime_watchlist_provider.dart';
import 'package:mag_user/providers/rating_provider.dart';
import 'package:mag_user/utils/util.dart';
import 'package:mag_user/widgets/form_builder_datetime_picker.dart';
import 'package:mag_user/widgets/form_builder_text_field.dart';
import 'package:mag_user/widgets/numeric_step_button.dart';
import 'package:mag_user/widgets/separator.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../utils/colors.dart';
import 'form_builder_choice_chip.dart';
import 'gradient_button.dart';

class NebulaForm extends StatefulWidget {
  final Anime anime;

  /// If watchlistId isn't provided, it means editing is in question, not adding
  final int? watchlistId;

  const NebulaForm({Key? key, required this.anime, this.watchlistId})
      : super(key: key);

  @override
  State<NebulaForm> createState() => _NebulaFormState();
}

class _NebulaFormState extends State<NebulaForm> {
  final _nebulaFormKey = GlobalKey<FormBuilderState>();
  late final AnimeWatchlistProvider _animeWatchlistProvider;
  late final RatingProvider _ratingProvider;

  int progress = 0;

  @override
  void initState() {
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _ratingProvider = context.read<RatingProvider>();

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
        child: FormBuilder(
          key: _nebulaFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.anime.titleEn}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Palette.teal.withOpacity(0.85)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      "Watch status",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(
                  name: "watchStatus",
                  options: const [
                    FormBuilderFieldOption(value: "Watching"),
                    FormBuilderFieldOption(value: "Completed"),
                    FormBuilderFieldOption(value: "On Hold"),
                    FormBuilderFieldOption(value: "Dropped"),
                    FormBuilderFieldOption(value: "Plan to Watch"),
                  ],
                  onChanged: (val) {
                    _nebulaFormKey.currentState?.saveAndValidate();
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "You must choose watch status.";
                    }
                    return null;
                  },
                ),
                Row(
                  children: const [
                    Text(
                      "Progress",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                NumericStepButton(
                  minValue: 0,
                  maxValue: widget.anime.episodesNumber!,
                  onChanged: (val) {
                    progress = val;
                  },
                ),
                MySeparator(
                  width: double.infinity,
                  paddingTop: 10,
                  paddingBottom: 10,
                  borderRadius: 50,
                  opacity: 0.5,
                ),
                Row(
                  children: const [
                    Text(
                      "Score & review (optional)",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(
                    name: "ratingValue",
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
                  name: "reviewText",
                  labelText: "Review",
                  fillColor: Palette.textFieldPurple.withOpacity(0.5),
                  //height: 54,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  paddingBottom: 10,
                  keyboardType: TextInputType.multiline,
                  borderRadius: 20,
                  errorBorderRadius: 20,
                  validator: (val) {
                    if (val != null &&
                        val.isNotEmpty &&
                        !isValidReviewText(val)) {
                      return "Some special characters are not allowed.";
                    } else if (val != null &&
                        val.isNotEmpty &&
                        _nebulaFormKey
                                .currentState?.fields["ratingValue"]?.value !=
                            null &&
                        _nebulaFormKey.currentState?.fields["ratingValue"]
                            ?.value.isEmpty) {
                      return "Score must be selected to leave a review.";
                    } else if (val != null &&
                        val.isNotEmpty &&
                        (_nebulaFormKey.currentState?.fields["ratingValue"]
                                    ?.value ==
                                null ||
                            _nebulaFormKey.currentState?.fields["ratingValue"]
                                ?.value.isEmpty)) {
                      return "Score must be selected to leave a review.";
                    }
                    return null;
                  },
                ),
                MySeparator(
                  width: double.infinity,
                  paddingTop: 10,
                  paddingBottom: 10,
                  borderRadius: 50,
                  opacity: 0.5,
                ),
                Row(
                  children: const [
                    Text(
                      "Date (optional)",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyDateTimePicker(
                  name: "dateStarted",
                  labelText: "Began watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyDateTimePicker(
                  name: "dateFinished",
                  labelText: "Finished watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 50,
                ),
                GradientButton(
                  onPressed: () async {
                    _nebulaFormKey.currentState?.saveAndValidate();

                    if (_nebulaFormKey.currentState?.saveAndValidate() ==
                        true) {
                      try {
                        Map<String, dynamic> animeWatchlist = {
                          "animeId": "${widget.anime.id}",
                          "watchlistId": "${widget.watchlistId}",
                          "watchStatus":
                              "${_nebulaFormKey.currentState!.fields["watchStatus"]?.value}",
                          "progress": "$progress",
                          "dateStarted": (_nebulaFormKey.currentState!
                                      .fields["dateStarted"]?.value !=
                                  null)
                              ? (_nebulaFormKey.currentState!
                                      .fields["dateStarted"]?.value as DateTime)
                                  .toIso8601String()
                              : null,
                          "dateFinished": (_nebulaFormKey.currentState!
                                      .fields["dateFinished"]?.value !=
                                  null)
                              ? (_nebulaFormKey
                                      .currentState!
                                      .fields["dateFinished"]
                                      ?.value as DateTime)
                                  .toIso8601String()
                              : null,
                        };

                        print("AnimeWatchlist object: $animeWatchlist");
                        var ratingValue;

                        if (_nebulaFormKey
                                .currentState!.fields["ratingValue"]?.value ==
                            null) {
                          ratingValue = 0;
                        } else if (_nebulaFormKey.currentState!
                            .fields["ratingValue"]?.value.isEmpty) {
                          ratingValue = 0;
                        } else {
                          ratingValue = _nebulaFormKey
                              .currentState!.fields["ratingValue"]?.value;
                        }

                        Map<String, dynamic> rating = {
                          "userId": LoggedUser.user!.id,
                          "animeId": widget.anime.id,
                          "ratingValue": ratingValue,
                          "reviewText":
                              "${_nebulaFormKey.currentState!.fields["reviewText"]?.value ?? ""}",
                          "dateAdded": DateTime.now().toIso8601String(),
                        };

                        print("Rating object: $rating");

                        await _animeWatchlistProvider.insert(animeWatchlist);

                        if (_nebulaFormKey.currentState!.fields["ratingValue"]
                                    ?.value !=
                                null &&
                            _nebulaFormKey.currentState!.fields["ratingValue"]
                                ?.value.isNotEmpty) {
                          await _ratingProvider.insert(rating);
                        }

                        showInfoDialog(
                            context,
                            const Icon(Icons.task_alt,
                                color: Palette.lightPurple, size: 50),
                            const Text(
                              "Added successfully!",
                              textAlign: TextAlign.center,
                            ));
                      } on Exception catch (e) {
                        showErrorDialog(context, e);
                      }
                    }
                  },
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
