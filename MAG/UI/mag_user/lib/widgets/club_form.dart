import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
                    if (val != null && val != "" && !isValidReviewText(val)) {
                      return "Illegal characters.";
                    } else if (val != null && val != "" && val.length > 50) {
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
                    if (val != null &&
                        val.isNotEmpty &&
                        !isValidReviewText(val)) {
                      return "Some special characters are not allowed.";
                    } else if (val != null &&
                        val.isNotEmpty &&
                        val.length > 300) {
                      return "Exceeded character limit: ${val.length}/300";
                    }
                    return null;
                  },
                ),
                Container(
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
                  onPressed: () {},
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

  Future getImage() async {
    try {
      var result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.single.path != null) {
        _image = File(result.files.single.path!);
        setState(() {
          _base64Image = base64Encode(_image!.readAsBytesSync());
        });
      }
    } catch (e) {
      // Do nothing
    }
  }
}
