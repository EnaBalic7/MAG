import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/models/anime_watchlist.dart';
import 'package:mag_user/providers/anime_watchlist_provider.dart';
import 'package:mag_user/providers/rating_provider.dart';
import 'package:mag_user/providers/watchlist_provider.dart';
import 'package:mag_user/utils/util.dart';
import 'package:mag_user/widgets/form_builder_datetime_picker.dart';
import 'package:mag_user/widgets/form_builder_text_field.dart';
import 'package:mag_user/widgets/numeric_step_button.dart';
import 'package:mag_user/widgets/separator.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/rating.dart';
import '../models/search_result.dart';
import '../models/watchlist.dart';
import '../utils/colors.dart';
import 'circular_progress_indicator.dart';
import 'form_builder_choice_chip.dart';
import 'gradient_button.dart';

class NebulaForm extends StatefulWidget {
  final Anime anime;

  /// If provided -> adding, if not provided -> editing
  ///
  /// If zero, it means user has no watchlist and it must be created before inserting Anime into it
  int? watchlistId;

  /// When accessing NebulaForm from NebulaScreen, this object must be passed for editing
  final AnimeWatchlist? animeWatchlist;

  NebulaForm({
    Key? key,
    required this.anime,
    this.watchlistId,
    this.animeWatchlist,
  }) : super(key: key);

  @override
  State<NebulaForm> createState() => _NebulaFormState();
}

class _NebulaFormState extends State<NebulaForm> {
  final _nebulaFormKey = GlobalKey<FormBuilderState>();
  late final AnimeWatchlistProvider _animeWatchlistProvider;
  late final RatingProvider _ratingProvider;
  late final WatchlistProvider _watchlistProvider;
  late Future<Map<String, dynamic>> _initialValueFuture;

  int progress = 0;

  @override
  void initState() {
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _ratingProvider = context.read<RatingProvider>();
    _watchlistProvider = context.read<WatchlistProvider>();

    _initialValueFuture = setInitialValue();

    print("Watchlist Id is: ${widget.watchlistId}");

    super.initState();
  }

  Future<Map<String, dynamic>> setInitialValue() async {
    var rating = await _ratingProvider.get(filter: {
      "UserId": "${LoggedUser.user!.id}",
      "AnimeId": "${widget.anime.id}"
    });

    return {
      "watchStatus": widget.animeWatchlist?.watchStatus ?? "",
      "ratingValue":
          (rating.result.isNotEmpty) ? rating.result.first.ratingValue : null,
      "reviewText":
          (rating.result.isNotEmpty) ? rating.result.first.reviewText : "",
      "dateStarted": widget.animeWatchlist?.dateStarted,
      "dateFinished": widget.animeWatchlist?.dateFinished,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widget.watchlistId != null && widget.watchlistId != 0) {
      return _buildAddForm(context);
    } else if (widget.watchlistId == 0) {
      _addFirstWatchlist();
      return _buildAddForm(context);
    }
    return _buildEditForm(context);
  }

  void _addFirstWatchlist() async {
    Watchlist watchlist = Watchlist(null, LoggedUser.user!.id, DateTime.now());
    var usersWatchlist = await _watchlistProvider.insert(watchlist);
    setState(() {
      widget.watchlistId = usersWatchlist.id;
    });
  }

  Dialog _buildAddForm(BuildContext context) {
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
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Palette.stardust),
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
                    selectedColor: Palette.lightYellow,
                    options: const [
                      FormBuilderFieldOption(value: 10),
                      FormBuilderFieldOption(value: 9),
                      FormBuilderFieldOption(value: 8),
                      FormBuilderFieldOption(value: 7),
                      FormBuilderFieldOption(value: 6),
                      FormBuilderFieldOption(value: 5),
                      FormBuilderFieldOption(value: 4),
                      FormBuilderFieldOption(value: 3),
                      FormBuilderFieldOption(value: 2),
                      FormBuilderFieldOption(value: 1),
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
                        (_nebulaFormKey.currentState?.fields["ratingValue"]
                                    ?.value ==
                                null ||
                            _nebulaFormKey.currentState?.fields["ratingValue"]
                                    ?.value ==
                                "")) {
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
                                    ?.value !=
                                "") {
                          await _ratingProvider.insert(rating);
                        }

                        Navigator.of(context).pop();

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
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditForm(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _initialValueFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully

            var initialValue = snapshot.data;

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
                  initialValue: initialValue ?? {},
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Palette.stardust),
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
                          initialValue: initialValue?["watchStatus"],
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
                          initialValue: widget.animeWatchlist!.progress,
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
                            initialValue: initialValue?["ratingValue"],
                            selectedColor: Palette.lightYellow,
                            options: const [
                              FormBuilderFieldOption(value: 10),
                              FormBuilderFieldOption(value: 9),
                              FormBuilderFieldOption(value: 8),
                              FormBuilderFieldOption(value: 7),
                              FormBuilderFieldOption(value: 6),
                              FormBuilderFieldOption(value: 5),
                              FormBuilderFieldOption(value: 4),
                              FormBuilderFieldOption(value: 3),
                              FormBuilderFieldOption(value: 2),
                              FormBuilderFieldOption(value: 1),
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
                                (_nebulaFormKey.currentState
                                            ?.fields["ratingValue"]?.value ==
                                        null ||
                                    _nebulaFormKey.currentState
                                            ?.fields["ratingValue"]?.value ==
                                        "")) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GradientButton(
                              onPressed: () async {
                                try {
                                  var animeWatchlist =
                                      await _animeWatchlistProvider
                                          .get(filter: {
                                    "AnimeId": "${widget.anime.id}",
                                    "WatchlistId":
                                        "${widget.animeWatchlist!.watchlistId}"
                                  });

                                  var rating = await _ratingProvider.get(
                                      filter: {
                                        "UserId": "${LoggedUser.user!.id}",
                                        "AnimeId": "${widget.anime.id}"
                                      });

                                  if (animeWatchlist.count == 1) {
                                    await _animeWatchlistProvider
                                        .delete(animeWatchlist.result[0].id!);

                                    await _ratingProvider
                                        .delete(rating.result[0].id!);

                                    Navigator.of(context).pop();

                                    showInfoDialog(
                                        context,
                                        const Icon(Icons.task_alt,
                                            color: Palette.lightPurple,
                                            size: 50),
                                        const Text(
                                          "Removed successfully!",
                                          textAlign: TextAlign.center,
                                        ));
                                  }
                                } on Exception catch (e) {
                                  showErrorDialog(context, e);
                                }
                              },
                              borderRadius: 50,
                              height: 30,
                              width: 80,
                              paddingTop: 20,
                              gradient: Palette.redGradient,
                              child: const Text(
                                "Remove",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            GradientButton(
                              onPressed: () async {
                                _nebulaFormKey.currentState?.saveAndValidate();

                                if (_nebulaFormKey.currentState
                                        ?.saveAndValidate() ==
                                    true) {
                                  try {
                                    var animeWatchlist =
                                        await _animeWatchlistProvider
                                            .get(filter: {
                                      "AnimeId": "${widget.anime.id}",
                                      "WatchlistId":
                                          "${widget.animeWatchlist!.watchlistId}"
                                    });

                                    if (animeWatchlist.count == 1) {
                                      animeWatchlist.result[0].watchStatus =
                                          _nebulaFormKey.currentState!
                                              .fields["watchStatus"]?.value;
                                      animeWatchlist.result[0].progress =
                                          progress;
                                      animeWatchlist.result[0].dateStarted =
                                          (_nebulaFormKey
                                                      .currentState!
                                                      .fields["dateStarted"]
                                                      ?.value !=
                                                  null)
                                              ? (_nebulaFormKey
                                                  .currentState!
                                                  .fields["dateStarted"]
                                                  ?.value as DateTime)
                                              : null;
                                      animeWatchlist.result[0].dateFinished =
                                          (_nebulaFormKey
                                                      .currentState!
                                                      .fields["dateFinished"]
                                                      ?.value !=
                                                  null)
                                              ? (_nebulaFormKey
                                                  .currentState!
                                                  .fields["dateFinished"]
                                                  ?.value as DateTime)
                                              : null;
                                    }

                                    _animeWatchlistProvider.update(
                                        animeWatchlist.result[0].id!,
                                        request: animeWatchlist.result[0]);

                                    print(
                                        "AnimeWatchlist update obj: Id: ${animeWatchlist.result[0].id} AnimeId: ${animeWatchlist.result[0].animeId} Progress: ${animeWatchlist.result[0].progress} WatchStatus: ${animeWatchlist.result[0].watchStatus} DateStarted: ${animeWatchlist.result[0].dateStarted} DateFinished: ${animeWatchlist.result[0].dateFinished}");

                                    var rating = await _ratingProvider.get(
                                        filter: {
                                          "UserId": "${LoggedUser.user!.id}",
                                          "AnimeId": "${widget.anime.id}"
                                        });
                                    if (rating.count == 0) {
                                      // Rating rating = Rating(null, LoggedUser.user!.id, widget.anime.id, );
                                      // _ratingProvider.insert();
                                    } else if (rating.count == 1) {
                                      var ratingValue;

                                      if (_nebulaFormKey.currentState!
                                              .fields["ratingValue"]?.value ==
                                          null) {
                                        ratingValue = 0;
                                      } else {
                                        ratingValue = _nebulaFormKey
                                            .currentState!
                                            .fields["ratingValue"]
                                            ?.value;
                                      }
                                      rating.result[0].ratingValue =
                                          ratingValue;
                                      rating.result[0].reviewText =
                                          _nebulaFormKey
                                                  .currentState!
                                                  .fields["reviewText"]
                                                  ?.value ??
                                              "";

                                      /* _ratingProvider.update(rating.result[0].id!,
                                          request: rating);*/

                                      print(
                                          "Rating update obj: Id: ${rating.result[0].id} AnimeId: ${rating.result[0].animeId} UserId: ${rating.result[0].userId} RatingValue: ${rating.result[0].ratingValue} ReviewText: ${rating.result[0].reviewText}");
                                    }

                                    Navigator.of(context).pop();

                                    showInfoDialog(
                                        context,
                                        const Icon(Icons.task_alt,
                                            color: Palette.lightPurple,
                                            size: 50),
                                        const Text(
                                          "Updated successfully!",
                                          textAlign: TextAlign.center,
                                        ));
                                  } on Exception catch (e) {
                                    showErrorDialog(context, e);
                                  }
                                }
                              },
                              borderRadius: 50,
                              height: 30,
                              width: 80,
                              paddingTop: 20,
                              gradient: Palette.buttonGradient,
                              child: const Text(
                                "Save",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
