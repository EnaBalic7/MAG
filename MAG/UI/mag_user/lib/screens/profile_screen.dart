import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glass/glass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../models/user_profile_picture.dart';
import '../providers/user_profile_picture_provider.dart';
import '../utils/icons.dart';
import '../widgets/gradient_button.dart';
import '../widgets/master_screen.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/form_builder_text_field.dart';

class ProfileScreen extends StatefulWidget {
  User user;
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UserProfilePictureProvider _userProfilePictureProvider;
  late UserProvider _userProvider;
  File? _image;
  String? _base64Image;
  late Size screenSize;
  double? textFieldWidth;
  double? imageWidth;
  double? containerWidth;
  double? containerHeight;

  Future getImage() async {
    try {
      var result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.single.path != null) {
        File originalImage = File(result.files.single.path!);

        print("Original Image Size: ${originalImage.lengthSync()} bytes");

        Uint8List compressedImage = await compressImage(originalImage);

        print("Compressed Image Size: ${compressedImage.length} bytes");

        setState(() {
          _base64Image = base64Encode(compressedImage);
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking or compressing image: $e");
    }
  }

  @override
  void initState() {
    _initialValue = {
      'firstName': widget.user.firstName ?? "",
      'lastName': widget.user.lastName ?? "",
      'username': widget.user.username ?? "",
      'email': widget.user.email ?? "",
    };
    _base64Image = widget.user.profilePicture!.profilePicture!;
    _userProfilePictureProvider = context.read<UserProfilePictureProvider>();
    _userProvider = context.read<UserProvider>();

    _userProvider.addListener(() {
      _reloadUserData();
    });

    super.initState();
  }

  void _reloadUserData() async {
    var userResult = await _userProvider.get(filter: {
      "Username": "${Authorization.username}",
      "ProfilePictureIncluded": "true",
    });

    if (mounted) {
      setState(() {
        if (userResult.count == 1) {
          LoggedUser.user = userResult.result.single;
          widget.user = userResult.result.single;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    containerWidth = screenSize.width;
    containerHeight = screenSize.height;
    textFieldWidth = containerWidth! * 0.9;
    imageWidth = containerWidth! * 0.9;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: containerWidth,
          height: containerHeight! - (containerHeight! * 0.151),
          decoration: BoxDecoration(
            color: Palette.midnightPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilder(
                  key: _formKey,
                  initialValue: _initialValue,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Palette.lightPurple.withOpacity(0.5),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(17)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(
                                imageFromBase64String(_base64Image!),
                                //width: imageWidth,
                                height: 200,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        child: Wrap(
                          alignment: screenSize.width >= 256
                              ? WrapAlignment.spaceBetween
                              : WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Tooltip(
                              message: "Date joined",
                              verticalOffset: 15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  buildCalendarIcon(18),
                                  const SizedBox(width: 5),
                                  Text(
                                      DateFormat('MMM d, y')
                                          .format(widget.user.dateJoined!),
                                      style: const TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            FormBuilderField(
                              name: "profilePicture",
                              builder: (field) {
                                return GradientButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    width: 135,
                                    height: 30,
                                    borderRadius: 50,
                                    paddingTop: 10,
                                    paddingBottom: 10,
                                    hideBorder: true,
                                    gradient: const LinearGradient(colors: [
                                      Palette.buttonPurple,
                                      Palette.buttonPurple,
                                    ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.photo, color: Palette.white),
                                        SizedBox(width: 5),
                                        Text("Change photo",
                                            style: TextStyle(
                                                color: Palette.white)),
                                      ],
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      MyFormBuilderTextField(
                        name: "username",
                        labelText: "Username",
                        fillColor: Palette.darkPurple,
                        width: textFieldWidth,
                        height: 43,
                        readOnly: true,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      MyFormBuilderTextField(
                        name: "firstName",
                        labelText: "First name",
                        fillColor: Palette.darkPurple,
                        width: textFieldWidth,
                        height: 43,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      MyFormBuilderTextField(
                        name: "lastName",
                        labelText: "Last name",
                        fillColor: Palette.darkPurple,
                        width: textFieldWidth,
                        height: 43,
                        paddingBottom: 25,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      MyFormBuilderTextField(
                        name: "email",
                        labelText: "E-mail",
                        fillColor: Palette.darkPurple,
                        width: textFieldWidth,
                        height: 43,
                        borderRadius: 50,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ],
                  )),
              GradientButton(
                  onPressed: () {
                    _saveProfileData();
                  },
                  width: 90,
                  height: 30,
                  borderRadius: 50,
                  paddingTop: 30,
                  gradient: Palette.buttonGradient,
                  child: const Text("Save",
                      style: TextStyle(
                          color: Palette.white, fontWeight: FontWeight.w500))),
            ],
          ),
        ).asGlass(
          tintColor: Palette.darkPurple,
          frosted: false,
        ),
      ),
    );
  }

  void _saveProfileData() async {
    _formKey.currentState?.saveAndValidate();
    var request = Map.from(_formKey.currentState!.value);

    UserProfilePicture pic;

    Map<dynamic, dynamic> userData = {
      "firstName": request["firstName"],
      "lastName": request["lastName"],
      "email": request["email"],
      "profilePictureId": widget.user.profilePictureId,
    };

    Map<dynamic, dynamic> profilePic = {"profilePicture": _base64Image};

    try {
      if (_base64Image != widget.user.profilePicture!.profilePicture) {
        if (widget.user.profilePictureId == 1) {
          pic = await _userProfilePictureProvider.insert(profilePic);
          userData["profilePictureId"] = pic.id;
        } else {
          await _userProfilePictureProvider
              .update(widget.user.profilePictureId!, request: profilePic);
          userData["profilePictureId"] = widget.user.profilePictureId!;
        }
      }

      await _userProvider.update(widget.user.id!, request: userData).then((_) {
        showInfoDialog(
            context,
            const Icon(Icons.task_alt, color: Palette.lightPurple, size: 50),
            const Text(
              "Updated successfully!",
              textAlign: TextAlign.center,
            ));
      }).catchError((error) {
        showInfoDialog(
            context,
            const Icon(Icons.warning_rounded,
                color: Palette.lightRed, size: 55),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
            ));
      });
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }
}
