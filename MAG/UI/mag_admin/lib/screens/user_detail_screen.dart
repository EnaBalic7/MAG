import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/separator.dart';

import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../widgets/gradient_button.dart';
import 'package:intl/intl.dart';

class UserDetailScreen extends StatefulWidget {
  User? user;
  String? profilePicture;
  UserDetailScreen({Key? key, this.user, this.profilePicture})
      : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      showBackArrow: true,
      child: Center(
        child: Row(children: [
          _buildUserInfo(),
          _buildUserContent(),
        ]),
      ),
    );
  }

  Padding _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 60,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.darkPurple,
              ),
              width: 430,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://cdn.oneesports.gg/cdn-data/2023/04/Anime_DemonSlayer_Muzan_3.jpg",
                          width: 360,
                          height: 330,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user!.username}"),
                            subtitle: Text("Username",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: Icon(Icons.person_rounded,
                                color: Palette.lightPurple.withOpacity(0.7),
                                size: 40),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user!.firstName}"),
                            subtitle: Text("First name",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: Icon(Icons.person_rounded,
                                color: Palette.lightPurple.withOpacity(0.7),
                                size: 40),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user!.lastName}"),
                            subtitle: Text("Last name",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: Icon(Icons.person_rounded,
                                color: Palette.lightPurple.withOpacity(0.7),
                                size: 40),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user!.email}"),
                            subtitle: Text("E-mail",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: Icon(Icons.email_rounded,
                                color: Palette.lightPurple.withOpacity(0.7),
                                size: 40),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text(DateFormat('MMM d, y')
                                .format(widget.user!.dateJoined!)),
                            subtitle: Text("Date joined",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: Icon(Icons.calendar_month_rounded,
                                color: Palette.lightPurple.withOpacity(0.7),
                                size: 40),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildUserContent() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 150, top: 0),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Reviews", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.star_rounded,
                            color: Palette.starYellow, size: 22),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCard(),
                      _buildSeeMoreButton(),
                    ],
                  ),
                  MySeparator(
                    width: 600,
                    borderRadius: 50,
                    opacity: 0.5,
                    marginVertical: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Posts", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.list_alt,
                            color: Palette.lightPurple, size: 20),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCard(),
                      _buildSeeMoreButton(),
                    ],
                  ),
                  MySeparator(
                    width: 600,
                    borderRadius: 50,
                    opacity: 0.5,
                    marginVertical: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Comments", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.comment_rounded,
                            color: Palette.lightPurple, size: 20),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCard(),
                      _buildSeeMoreButton(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buildSeeMoreButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Palette.lightPurple),
        splashFactory: InkRipple.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors
                  .transparent; // Set to transparent for the pressed state
            }
            return Colors.transparent; // Default overlay color
          },
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "See more",
            style: TextStyle(fontSize: 16),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 16)
        ],
      ),
    );
  }
}

//Adjust this part
Widget _buildCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 0, right: 0),
    child: Container(
      constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
      height: 180,
      width: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://cdn.oneesports.gg/cdn-data/2023/04/Anime_DemonSlayer_Muzan_3.jpg",
                          width: 43,
                          height: 43,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Muzan Kibutsuji",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        Text("Attack on Titan"),
                      ],
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 23),
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      IconButton(
                        constraints:
                            BoxConstraints(maxHeight: 24, maxWidth: 24),
                        alignment: Alignment.topCenter,
                        tooltip: "Hide from viewers",
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        padding: EdgeInsets.zero,
                        splashRadius: 0.1,
                        onPressed: () {},
                        icon: Icon(
                          Icons.visibility_off_outlined,
                          size: 24,
                        ),
                      ),
                      PopupMenuButton<String>(
                        tooltip: "More actions",
                        offset: Offset(195, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Palette.lightPurple.withOpacity(0.3)),
                        ),
                        icon: Icon(Icons.more_vert_rounded),
                        splashRadius: 1,
                        padding: EdgeInsets.zero,
                        color: Color.fromRGBO(50, 48, 90, 1),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              hoverColor: Palette.lightPurple.withOpacity(0.1),
                              onTap: () async {},
                            ),
                          ),
                          PopupMenuItem<String>(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                              hoverColor: Palette.lightRed.withOpacity(0.1),
                              leading: buildTrashIcon(24),
                              title: Text('Delete',
                                  style: TextStyle(color: Palette.lightRed)),
                              subtitle: Text('Delete permanently',
                                  style: TextStyle(
                                      color:
                                          Palette.lightRed.withOpacity(0.5))),
                              onTap: () async {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              alignment: Alignment.topLeft,
              constraints: BoxConstraints(minHeight: 30, maxHeight: 100),
              //height: 100,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Text(
                  "I find this very entertaining. The screams of titan's victims feeds my soul. I only wish I could be there. I think I will go on a killing spree to satisfy my bloodlust.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
