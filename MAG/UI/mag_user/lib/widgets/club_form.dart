import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../providers/club_provider.dart';
import '../providers/club_user_provider.dart';
import '../models/club.dart';
import '../models/club_cover.dart';
import '../providers/club_cover_provider.dart';
import '../widgets/gradient_button.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import 'form_builder_text_field.dart';

// ignore: must_be_immutable
class ClubForm extends StatefulWidget {
  /// If not null, it means editing is in question
  Club? club;
  ClubForm({
    super.key,
    this.club,
  });

  @override
  State<ClubForm> createState() => _ClubFormState();
}

class _ClubFormState extends State<ClubForm> {
  String? _base64Image;
  final _clubFormKey = GlobalKey<FormBuilderState>();
  late final ClubCoverProvider _clubCoverProvider;
  late final ClubProvider _clubProvider;
  late final ClubUserProvider _clubUserProvider;
  Map<String, dynamic> _initialValue = {};
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _clubCoverProvider = context.read<ClubCoverProvider>();
    _clubProvider = context.read<ClubProvider>();
    _clubUserProvider = context.read<ClubUserProvider>();

    _initialValue = {
      "name": widget.club?.name ?? "",
      "description": widget.club?.description ?? "",
    };

    if (widget.club != null) {
      _base64Image = widget.club?.cover?.cover;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clubFormKey.currentState?.validate();
    });

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
          key: _clubFormKey,
          initialValue: _initialValue,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: (widget.club == null)
                      ? const Text("Create your own club",
                          style: TextStyle(fontSize: 17))
                      : const Text("Edit your club",
                          style: TextStyle(fontSize: 17)),
                ),
                MyFormBuilderTextField(
                  labelText: "Name",
                  name: "name",
                  fillColor: Palette.textFieldPurple.withOpacity(0.5),
                  height: 43,
                  borderRadius: 50,
                  focusNode: _focusNode1,
                  validator: (val) {
                    if (val == null || isEmptyOrWhiteSpace(val)) {
                      return "This field cannot be empty.";
                    } else if (val != "" && !isValidReviewText(val)) {
                      return "Illegal characters.";
                    } else if (val != "" && val.length > 20) {
                      return "Character limit exceeded: ${val.length}/20";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MyFormBuilderTextField(
                  name: "description",
                  labelText: "Description",
                  fillColor: Palette.textFieldPurple.withOpacity(0.5),
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  paddingBottom: 10,
                  keyboardType: TextInputType.multiline,
                  borderRadius: 20,
                  errorBorderRadius: 20,
                  focusNode: _focusNode2,
                  validator: (val) {
                    if (val == null || isEmptyOrWhiteSpace(val)) {
                      return "This field cannot be empty.";
                    } else if (val.isNotEmpty && !isValidReviewText(val)) {
                      return "Some special characters are not allowed.";
                    } else if (val.isNotEmpty && val.length > 300) {
                      return "Character limit exceeded: ${val.length}/300";
                    }
                    return null;
                  },
                ),
                FormBuilderField(
                  name: "cover",
                  focusNode: _focusNode3,
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(color: Palette.lightRed),
                          errorText: field.errorText,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(0)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.ratingPurple,
                            borderRadius: BorderRadius.circular(50)),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          leading: const Icon(Icons.image_rounded,
                              color: Palette.lightPurple),
                          trailing: GestureDetector(
                            onTap: () {
                              getImage();
                              field.didChange(_base64Image);
                              _clubFormKey.currentState?.saveAndValidate();
                            },
                            child: const Icon(
                              Icons.upload_rounded,
                              color: Palette.lightPurple,
                            ),
                          ),
                          title: const Text("Upload cover photo",
                              style: TextStyle(color: Palette.lightPurple)),
                        ),
                      ),
                    );
                  },
                  validator: (val) {
                    int maxSizeInBytes = 300000; // 300 KB
                    if (_base64Image == null) {
                      return "Must select cover photo";
                    } else if (isImageSizeValid(_base64Image, maxSizeInBytes) ==
                        false) {
                      return "Image file is too large.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _base64Image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          imageFromBase64String(_base64Image!),
                          //width: imageWidth,
                          height: 200,
                          fit: BoxFit.cover,
                        ))
                    : Container(),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () async {
                    try {
                      if (_clubFormKey.currentState?.saveAndValidate() ==
                          true) {
                        String? name =
                            _clubFormKey.currentState?.fields["name"]?.value;
                        String? description = _clubFormKey
                            .currentState?.fields["description"]?.value;

                        if (widget.club == null) {
                          // Add cover first
                          ClubCover? cc;
                          if (_base64Image != null) {
                            var cover = {"cover": _base64Image};
                            cc = await _clubCoverProvider.insert(cover);
                          }

                          // Then add club with added cover
                          var clubObj = {
                            "ownerId": LoggedUser.user!.id,
                            "name": name,
                            "description": description,
                            "memberCount": 0,
                            "dateCreated": DateTime.now().toIso8601String(),
                            "coverId": (cc != null) ? cc.id : null,
                          };

                          Club addedClub = await _clubProvider.insert(clubObj);

                          // Add club owner to his club
                          var clubUserObj = {
                            "clubId": addedClub.id,
                            "userId": LoggedUser.user!.id,
                          };

                          await _clubUserProvider.insert(clubUserObj);

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            showInfoDialog(
                                context,
                                const Icon(Icons.task_alt,
                                    color: Palette.lightPurple, size: 50),
                                const Text(
                                  "Club created!",
                                  textAlign: TextAlign.center,
                                ));
                          }
                        } else if (widget.club != null) {
                          // Update club name and description
                          var clubUpdateObj = {
                            "name": name,
                            "description": description,
                          };

                          await _clubProvider.update(widget.club!.id!,
                              request: clubUpdateObj);

                          // Update club cover photo
                          Map<String, dynamic>? cover;
                          if (_base64Image != null &&
                              _base64Image != widget.club!.cover!.cover) {
                            cover = {"cover": _base64Image};
                            await _clubCoverProvider
                                .update(widget.club!.coverId!, request: cover);
                          }

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            showInfoDialog(
                                context,
                                const Icon(Icons.task_alt,
                                    color: Palette.lightPurple, size: 50),
                                const Text(
                                  "Club info updated!",
                                  textAlign: TextAlign.center,
                                ));
                          }
                        }
                      }
                    } on Exception catch (e) {
                      if (context.mounted) {
                        showErrorDialog(context, e);
                      }
                    }
                  },
                  width: 80,
                  height: 30,
                  borderRadius: 50,
                  gradient: Palette.buttonGradient,
                  child: (widget.club == null)
                      ? const Text("Create",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Palette.white))
                      : const Text("Save",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Palette.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    try {
      var result = await FilePicker.platform
          .pickFiles(type: FileType.image, compressionQuality: 0);

      if (result != null && result.files.single.path != null) {
        File originalImage = File(result.files.single.path!);

        print("Original Image Path: ${originalImage.path}");
        print("Original Image Size: ${originalImage.lengthSync()} bytes");

        Uint8List compressedImage = await compressImage(originalImage);

        print("Compressed Image Size: ${compressedImage.length} bytes");

        setState(() {
          _base64Image = base64Encode(compressedImage);
        });

        _clubFormKey.currentState?.fields['cover']?.didChange(_base64Image);

        _clubFormKey.currentState?.saveAndValidate();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking or compressing image: $e");
    }
  }
}
