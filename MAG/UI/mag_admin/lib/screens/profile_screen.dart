import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mag_admin/providers/user_profile_picture_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

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
  Map<String, dynamic> _initialValue = {};
  late UserProfilePictureProvider _userProfilePictureProvider;

  @override
  void initState() {
    _initialValue = {
      'firstName': widget.user.firstName ?? "",
      'lastName': widget.user.lastName ?? "",
      'username': widget.user.username ?? "",
      'email': widget.user.email ?? "",
    };

    _userProfilePictureProvider = context.read<UserProfilePictureProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: const Text("My profile"),
      showBackArrow: true,
      showProfileIcon: false,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
              width: 500,
              decoration: BoxDecoration(
                color: Palette.midnightPurple.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          imageFromBase64String(
                              widget.user.profilePicture!.profilePicture!),
                          width: 400,
                          height: 250,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 145),
                      FormBuilderField(
                        name: "id",
                        builder: (field) {
                          return GradientButton(
                              onPressed: () {},
                              width: 135,
                              height: 30,
                              borderRadius: 50,
                              paddingTop: 10,
                              paddingBottom: 10,
                              gradient: Palette.buttonGradient2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.photo, color: Palette.lightPurple),
                                  SizedBox(width: 5),
                                  Text("Change photo",
                                      style: TextStyle(
                                          color: Palette.lightPurple)),
                                ],
                              ));
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  FormBuilder(
                      initialValue: _initialValue,
                      child: Column(
                        children: [
                          MyFormBuilderTextField(
                            name: "username",
                            labelText: "Username",
                            fillColor: Palette.darkPurple,
                            width: 400,
                            height: 50,
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
                            width: 400,
                            height: 50,
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
                            width: 400,
                            height: 50,
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
                            width: 400,
                            height: 50,
                            borderRadius: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ],
                      )),
                  GradientButton(
                      onPressed: () {},
                      width: 100,
                      height: 30,
                      borderRadius: 50,
                      paddingTop: 30,
                      paddingBottom: 30,
                      gradient: Palette.buttonGradient,
                      child: const Text("Save",
                          style: TextStyle(
                              color: Palette.white,
                              fontWeight: FontWeight.w500))),
                ],
              )),
        ),
      ),
    );
  }
}
