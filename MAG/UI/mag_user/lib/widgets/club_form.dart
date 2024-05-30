import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mag_user/providers/club_provider.dart';
import 'package:provider/provider.dart';

import '../models/club_cover.dart';
import '../providers/club_cover_provider.dart';
import '../widgets/gradient_button.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import 'form_builder_text_field.dart';

class ClubForm extends StatefulWidget {
  const ClubForm({Key? key}) : super(key: key);

  @override
  State<ClubForm> createState() => _ClubFormState();
}

class _ClubFormState extends State<ClubForm> {
  File? _image;
  String? _base64Image;
  final _clubFormKey = GlobalKey<FormBuilderState>();
  late final ClubCoverProvider _clubCoverProvider;
  late final ClubProvider _clubProvider;

  @override
  void initState() {
    _clubCoverProvider = context.read<ClubCoverProvider>();
    _clubProvider = context.read<ClubProvider>();

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Create your own club",
                      style: TextStyle(fontSize: 17)),
                ),
                MyFormBuilderTextField(
                  labelText: "Name",
                  name: "name",
                  fillColor: Palette.textFieldPurple.withOpacity(0.5),
                  height: 43,
                  borderRadius: 50,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "This field cannot be empty.";
                    } else if (val != "" && !isValidReviewText(val)) {
                      return "Illegal characters.";
                    } else if (val != "" && val.length > 20) {
                      return "Name is too long.";
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
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "This field cannot be empty.";
                    } else if (val.isNotEmpty && !isValidReviewText(val)) {
                      return "Some special characters are not allowed.";
                    } else if (val.isNotEmpty && val.length > 300) {
                      return "Exceeded character limit: ${val.length}/300";
                    }
                    return null;
                  },
                ),
                FormBuilderField(
                  name: "cover",
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
                            },
                            child: const Icon(
                              Icons.upload_rounded,
                              color: Palette.lightPurple,
                            ),
                          ),
                          title: const Text("Upload cover photo"),
                        ),
                      ),
                    );
                  },
                  onChanged: (val) {
                    _clubFormKey.currentState?.saveAndValidate();
                  },
                  validator: (val) {
                    int maxSizeInBytes = 1 * 1024 * 1024;
                    if (isImageSizeValid(_base64Image, maxSizeInBytes) ==
                        false) {
                      print("Image too large");
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
// Add cover first

                        ClubCover? cc;
                        if (_base64Image != null) {
                          var cover = {"cover": _base64Image};
                          cc = await _clubCoverProvider.insert(cover);
                        }

// Then add club with added cover
                        String? name =
                            _clubFormKey.currentState?.fields["name"]?.value;
                        String? description = _clubFormKey
                            .currentState?.fields["description"]?.value;

                        var clubObj = {
                          "ownerId": LoggedUser.user!.id,
                          "name": name,
                          "description": description,
                          "memberCount": 0,
                          "dateCreated": DateTime.now().toIso8601String(),
                          "coverId": (cc != null) ? cc.id : null,
                        };

                        await _clubProvider.insert(clubObj);

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
                    } on Exception catch (e) {
                      showErrorDialog(context, e);
                    }
                  },
                  width: 80,
                  height: 30,
                  borderRadius: 50,
                  gradient: Palette.buttonGradient,
                  child: const Text("Create",
                      style: TextStyle(fontWeight: FontWeight.w500)),
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
      var result = await FilePicker.platform.pickFiles(type: FileType.image);

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
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking or compressing image: $e");
    }
  }
}
