import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/anime_watchlist.dart';
import '../providers/anime_watchlist_provider.dart';
import '../providers/rating_provider.dart';
import '../providers/watchlist_provider.dart';
import '../utils/util.dart';
import '../widgets/form_builder_datetime_picker.dart';
import '../widgets/form_builder_text_field.dart';
import '../widgets/numeric_step_button.dart';
import '../widgets/separator.dart';
import '../models/anime.dart';
import '../models/rating.dart';
import '../models/watchlist.dart';
import '../utils/colors.dart';
import 'circular_progress_indicator.dart';
import 'form_builder_choice_chip.dart';
import 'gradient_button.dart';

// ignore: must_be_immutable
class NebulaForm extends StatefulWidget {
  final Anime anime;

  /// If provided -> adding, if not provided -> editing
  ///
  /// If zero, it means user has no watchlist and it must be created before inserting Anime into it
  int? watchlistId;

  /// When accessing NebulaForm from NebulaScreen, this object must be passed for editing
  final AnimeWatchlist? animeWatchlist;

  NebulaForm({
    super.key,
    required this.anime,
    this.watchlistId,
    this.animeWatchlist,
  });

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
  int? _watchlistId;

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
  final FocusNode _focusNode11 = FocusNode();
  final FocusNode _focusNode12 = FocusNode();

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
    _focusNode11.dispose();
    _focusNode12.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _animeWatchlistProvider = context.read<AnimeWatchlistProvider>();
    _ratingProvider = context.read<RatingProvider>();
    _watchlistProvider = context.read<WatchlistProvider>();

    _initialValueFuture = setInitialValue();

    _watchlistId = widget.watchlistId;

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
    if (_watchlistId != null && _watchlistId != 0) {
      return _buildAddForm(context);
    } else if (_watchlistId == 0) {
      _addFirstWatchlist();
      return _buildAddForm(context);
    }
    return _buildEditForm(context);
  }

  void _addFirstWatchlist() async {
    // Check if logged user has a watchlist
    var watchlistObj = await _watchlistProvider
        .get(filter: {"UserId": "${LoggedUser.user!.id}"});

    // If not, add one
    if (watchlistObj.count == 0) {
      Watchlist watchlist =
          Watchlist(null, LoggedUser.user!.id, DateTime.now());
      var usersWatchlist = await _watchlistProvider.insert(watchlist);
      setState(() {
        _watchlistId = usersWatchlist.id!;
      });
    }
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
                const Row(
                  children: [
                    Text(
                      "Watch status",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(
                  focusNode: _focusNode1,
                  name: "watchStatus",
                  onChanged: (val) {
                    _nebulaFormKey.currentState?.saveAndValidate();
                  },
                  options: const [
                    FormBuilderChipOption(
                        value: "Watching",
                        child: Text("Watching",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: "Completed",
                        child: Text("Completed",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: "On Hold",
                        child: Text("On Hold",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: "Dropped",
                        child: Text("Dropped",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: "Plan to Watch",
                        child: Text("Plan to Watch",
                            style: TextStyle(color: Palette.darkPurple))),
                  ],
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "You must choose watch status.";
                    }
                    return null;
                  },
                ),
                const Row(
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                FormBuilderField(
                  focusNode: _focusNode2,
                  name: "progress",
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(color: Palette.lightRed),
                          errorText: field.errorText,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(0)),
                      child: NumericStepButton(
                        minValue: 0,
                        maxValue: widget.anime.episodesNumber!,
                        onChanged: (val) {
                          progress = val;
                          field.didChange(val);
                        },
                      ),
                    );
                  },
                  onChanged: (val) {
                    _nebulaFormKey.currentState?.saveAndValidate();
                  },
                  validator: (val) {
                    final watchStatus = _nebulaFormKey
                        .currentState!.fields['watchStatus']?.value;

                    if (watchStatus == "Plan to Watch" &&
                        val != null &&
                        val != "" &&
                        val is int &&
                        val > 0) {
                      return "Cannot choose progress with selected watch status.";
                    } else if (watchStatus == "Completed" &&
                        progress < widget.anime.episodesNumber!) {
                      return "Must select max. number of episodes.";
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
                const Row(
                  children: [
                    Text(
                      "Score & review (optional)",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                MyFormBuilderChoiceChip(
                  focusNode: _focusNode3,
                  name: "ratingValue",
                  selectedColor: Palette.lightYellow,
                  options: const [
                    FormBuilderChipOption(
                        value: 10,
                        child: Text("10",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 9,
                        child: Text("9",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 8,
                        child: Text("8",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 7,
                        child: Text("7",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 6,
                        child: Text("6",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 5,
                        child: Text("5",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 4,
                        child: Text("4",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 3,
                        child: Text("3",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 2,
                        child: Text("2",
                            style: TextStyle(color: Palette.darkPurple))),
                    FormBuilderChipOption(
                        value: 1,
                        child: Text("1",
                            style: TextStyle(color: Palette.darkPurple))),
                  ],
                  onChanged: (val) {
                    _nebulaFormKey.currentState?.saveAndValidate();
                  },
                  validator: (val) {
                    final watchStatus = _nebulaFormKey
                        .currentState!.fields['watchStatus']?.value;

                    if (watchStatus == "Plan to Watch" &&
                        val != null &&
                        val != "" &&
                        val is int &&
                        val > 0) {
                      return "Cannot leave score with selected watch status.";
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyFormBuilderTextField(
                  focusNode: _focusNode4,
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
                  contentPadding:
                      const EdgeInsets.only(left: 10, right: 10, top: 25),
                  validator: (val) {
                    if (val != null &&
                        val.isNotEmpty &&
                        !isValidReviewText(val)) {
                      return "Some special characters are not allowed.";
                    } else if (LoggedUser.user!.userRoles!.any(
                      (element) =>
                          element.canReview == false &&
                          val != null &&
                          val.isNotEmpty,
                    )) {
                      return "Not permitted to leave review.";
                    } else if (val != null &&
                        val != "" &&
                        _nebulaFormKey
                                .currentState?.fields["watchStatus"]?.value ==
                            "Plan to Watch") {
                      return "Cannot leave review with selected watch status.";
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
                const Row(
                  children: [
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
                  focusNode: _focusNode5,
                  name: "dateStarted",
                  formKey: _nebulaFormKey,
                  labelText: "Began watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 50,
                  validator: (val) {
                    final watchStatus = _nebulaFormKey
                        .currentState!.fields['watchStatus']?.value;

                    final beganDate = _nebulaFormKey.currentState
                        ?.fields["dateStarted"]?.value as DateTime?;
                    final finishedDate = _nebulaFormKey.currentState
                        ?.fields["dateFinished"]?.value as DateTime?;

                    if (watchStatus == "Plan to Watch" && val != null) {
                      return "Cannot choose date with selected watch status.";
                    } else if (beganDate != null &&
                        finishedDate != null &&
                        beganDate.isAfter(finishedDate)) {
                      return "Begin date cannot be after finish date.";
                    } else if (beganDate != null &&
                        beganDate.isAfter(DateTime.now())) {
                      return "Begin date cannot be in the future";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MyDateTimePicker(
                  focusNode: _focusNode6,
                  name: "dateFinished",
                  formKey: _nebulaFormKey,
                  labelText: "Finished watching",
                  fillColor: Palette.ratingPurple,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 50,
                  validator: (val) {
                    final watchStatus = _nebulaFormKey
                        .currentState!.fields['watchStatus']?.value;

                    final beganDate = _nebulaFormKey.currentState
                        ?.fields["dateStarted"]?.value as DateTime?;
                    final finishedDate = _nebulaFormKey.currentState
                        ?.fields["dateFinished"]?.value as DateTime?;

                    if (watchStatus == "Plan to Watch" && val != null) {
                      return "Cannot choose date with selected watch status.";
                    } else if (beganDate != null &&
                        finishedDate != null &&
                        finishedDate.isBefore(beganDate)) {
                      return "Finish date cannot be before begin date.";
                    }
                    return null;
                  },
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

                        dynamic ratingValue;

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

                        await _animeWatchlistProvider.insert(animeWatchlist);

                        if (_nebulaFormKey.currentState!.fields["ratingValue"]
                                    ?.value !=
                                null &&
                            _nebulaFormKey.currentState!.fields["ratingValue"]
                                    ?.value !=
                                "") {
                          await _ratingProvider.insert(rating);
                        }

                        if (context.mounted) {
                          Navigator.of(context).pop();

                          showInfoDialog(
                              context,
                              const Icon(Icons.task_alt,
                                  color: Palette.lightPurple, size: 50),
                              const Text(
                                "Added successfully!",
                                textAlign: TextAlign.center,
                              ));
                        }
                      } on Exception catch (e) {
                        if (context.mounted) {
                          showErrorDialog(context, e);
                        }
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
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Palette.white),
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
                        const Row(
                          children: [
                            Text(
                              "Watch status",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        MyFormBuilderChoiceChip(
                          focusNode: _focusNode7,
                          name: "watchStatus",
                          initialValue: initialValue?["watchStatus"],
                          onChanged: (val) {
                            _nebulaFormKey.currentState?.saveAndValidate();
                          },
                          options: const [
                            FormBuilderChipOption(
                                value: "Watching",
                                child: Text("Watching",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: "Completed",
                                child: Text("Completed",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: "On Hold",
                                child: Text("On Hold",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: "Dropped",
                                child: Text("Dropped",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: "Plan to Watch",
                                child: Text("Plan to Watch",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                          ],
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "You must choose watch status.";
                            } else if (val == "Plan to Watch") {
                              return "Cannot change to selected watch status.";
                            }
                            return null;
                          },
                        ),
                        const Row(
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        FormBuilderField(
                          focusNode: _focusNode8,
                          name: "progress",
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  errorStyle:
                                      const TextStyle(color: Palette.lightRed),
                                  errorText: field.errorText,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0)),
                              child: NumericStepButton(
                                minValue: 0,
                                maxValue: widget.anime.episodesNumber!,
                                onChanged: (val) {
                                  progress = val;
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    field.didChange(val);
                                  });
                                },
                                initialValue: widget.animeWatchlist!.progress,
                              ),
                            );
                          },
                          validator: (val) {
                            final watchStatus = _nebulaFormKey
                                .currentState!.fields['watchStatus']?.value;

                            if (watchStatus == "Completed" &&
                                progress < widget.anime.episodesNumber!) {
                              return "Must select max. number of episodes.";
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
                        const Row(
                          children: [
                            Text(
                              "Score & review (optional)",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        MyFormBuilderChoiceChip(
                          focusNode: _focusNode9,
                          name: "ratingValue",
                          initialValue: initialValue?["ratingValue"],
                          selectedColor: Palette.lightYellow,
                          options: const [
                            FormBuilderChipOption(
                                value: 10,
                                child: Text("10",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 9,
                                child: Text("9",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 8,
                                child: Text("8",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 7,
                                child: Text("7",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 6,
                                child: Text("6",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 5,
                                child: Text("5",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 4,
                                child: Text("4",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 3,
                                child: Text("3",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 2,
                                child: Text("2",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                            FormBuilderChipOption(
                                value: 1,
                                child: Text("1",
                                    style:
                                        TextStyle(color: Palette.darkPurple))),
                          ],
                          onChanged: (val) {
                            _nebulaFormKey.currentState?.saveAndValidate();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyFormBuilderTextField(
                          focusNode: _focusNode10,
                          name: "reviewText",
                          labelText: "Review",
                          fillColor: Palette.textFieldPurple.withOpacity(0.5),
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.center,
                          paddingBottom: 10,
                          keyboardType: TextInputType.multiline,
                          borderRadius: 20,
                          errorBorderRadius: 20,
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 10, top: 25),
                          validator: (val) {
                            if (val != null &&
                                val.isNotEmpty &&
                                !isValidReviewText(val)) {
                              return "Some special characters are not allowed.";
                            } else if (LoggedUser.user!.userRoles!.any(
                              (element) =>
                                  element.canReview == false &&
                                  val != null &&
                                  val.isNotEmpty,
                            )) {
                              return "Not permitted to leave review.";
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
                        const Row(
                          children: [
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
                          focusNode: _focusNode11,
                          name: "dateStarted",
                          formKey: _nebulaFormKey,
                          labelText: "Began watching",
                          fillColor: Palette.ratingPurple,
                          width: double.infinity,
                          borderRadius: 50,
                          validator: (val) {
                            final watchStatus = _nebulaFormKey
                                .currentState!.fields['watchStatus']?.value;

                            final beganDate = _nebulaFormKey.currentState
                                ?.fields["dateStarted"]?.value as DateTime?;
                            final finishedDate = _nebulaFormKey.currentState
                                ?.fields["dateFinished"]?.value as DateTime?;

                            if (watchStatus == "Plan to Watch" && val != null) {
                              return "Cannot choose date with selected watch status.";
                            } else if (beganDate != null &&
                                finishedDate != null &&
                                beganDate.isAfter(finishedDate)) {
                              return "Begin date cannot be after finish date.";
                            } else if (beganDate != null &&
                                beganDate.isAfter(DateTime.now())) {
                              return "Begin date cannot be in the future";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyDateTimePicker(
                          focusNode: _focusNode12,
                          name: "dateFinished",
                          formKey: _nebulaFormKey,
                          labelText: "Finished watching",
                          fillColor: Palette.ratingPurple,
                          width: double.infinity,
                          borderRadius: 50,
                          validator: (val) {
                            final watchStatus = _nebulaFormKey
                                .currentState!.fields['watchStatus']?.value;

                            final beganDate = _nebulaFormKey.currentState
                                ?.fields["dateStarted"]?.value as DateTime?;
                            final finishedDate = _nebulaFormKey.currentState
                                ?.fields["dateFinished"]?.value as DateTime?;

                            if (watchStatus == "Plan to Watch" && val != null) {
                              return "Cannot choose date with selected watch status.";
                            } else if (beganDate != null &&
                                finishedDate != null &&
                                finishedDate.isBefore(beganDate)) {
                              return "Finish date cannot be before begin date.";
                            }
                            return null;
                          },
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

                                    if (rating.count == 1) {
                                      await _ratingProvider
                                          .delete(rating.result[0].id!);
                                    }

                                    if (context.mounted) {
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
                                  }
                                } on Exception catch (e) {
                                  if (context.mounted) {
                                    showErrorDialog(context, e);
                                  }
                                }
                              },
                              borderRadius: 50,
                              height: 30,
                              width: 80,
                              paddingTop: 20,
                              gradient: Palette.redGradient,
                              child: const Text(
                                "Remove",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Palette.white),
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

                                    var rating = await _ratingProvider.get(
                                        filter: {
                                          "UserId": "${LoggedUser.user!.id}",
                                          "AnimeId": "${widget.anime.id}"
                                        });

                                    dynamic ratingValue;

                                    if (_nebulaFormKey.currentState!
                                            .fields["ratingValue"]?.value ==
                                        null) {
                                      ratingValue = 0;
                                    } else {
                                      ratingValue = _nebulaFormKey.currentState!
                                          .fields["ratingValue"]?.value;
                                    }

                                    if (rating.count == 0 &&
                                        _nebulaFormKey.currentState!
                                                .fields["ratingValue"]?.value !=
                                            null &&
                                        _nebulaFormKey.currentState!
                                                .fields["ratingValue"]?.value !=
                                            "") {
                                      String? reviewText = _nebulaFormKey
                                              .currentState!
                                              .fields["reviewText"]
                                              ?.value ??
                                          "";

                                      Rating rating = Rating(
                                          null,
                                          LoggedUser.user!.id,
                                          widget.anime.id,
                                          ratingValue,
                                          reviewText,
                                          DateTime.now());

                                      _ratingProvider.insert(rating);
                                    } else if (rating.count == 1) {
                                      if (_nebulaFormKey.currentState!
                                              .fields["ratingValue"]?.value ==
                                          null) {
                                        _ratingProvider
                                            .delete(rating.result[0].id!);
                                      } else {
                                        rating.result[0].ratingValue =
                                            ratingValue;
                                        rating.result[0].reviewText =
                                            _nebulaFormKey
                                                    .currentState!
                                                    .fields["reviewText"]
                                                    ?.value ??
                                                "";

                                        _ratingProvider.update(
                                            rating.result[0].id!,
                                            request: rating.result[0]);
                                      }
                                    }

                                    if (context.mounted) {
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
                                    }
                                  } on Exception catch (e) {
                                    if (context.mounted) {
                                      showErrorDialog(context, e);
                                    }
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Palette.white),
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
