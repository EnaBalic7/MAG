import 'package:flutter/material.dart';
import 'package:mag_user/screens/login_screen.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/separator.dart';

import '../models/user.dart';
import '../screens/profile_screen.dart';
import '../utils/colors.dart';
import '../utils/util.dart';

class UserProfileDialog extends StatefulWidget {
  final User loggedUser;
  const UserProfileDialog({Key? key, required this.loggedUser})
      : super(key: key);

  @override
  State<UserProfileDialog> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double imageWidth = screenSize.width * 0.25;
    double imageHeight = imageWidth;

    return Dialog(
      alignment: Alignment.topCenter,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(
                        imageFromBase64String(
                            widget.loggedUser.profilePicture!.profilePicture!),
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: screenSize.width * 0.4, maxHeight: 50),
                      child: Text("${widget.loggedUser.username}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Palette.selectedGenre,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: screenSize.width * 0.4, maxHeight: 50),
                      child: Text(
                        "${widget.loggedUser.firstName} ${widget.loggedUser.lastName}",
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            MySeparator(
              width: double.infinity,
              paddingTop: 20,
              paddingBottom: 5,
              borderRadius: 50,
              opacity: 0.8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(user: widget.loggedUser),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.buttonPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Settings'),
                      SizedBox(width: 5),
                      Icon(Icons.settings_rounded, size: 15),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Authorization.username = "";
                    Authorization.password = "";
                    LoggedUser.user = null;

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.buttonPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Log Out'),
                      const SizedBox(width: 5),
                      buildLogoutIcon(16, color: Palette.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
