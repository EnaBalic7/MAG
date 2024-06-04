import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:mag_user/widgets/separator.dart';

import '../models/club.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/gradient_button.dart';
import '../widgets/post_card.dart';

class ClubDetailScreen extends StatefulWidget {
  final Club club;
  final int selectedIndex;
  const ClubDetailScreen({
    Key? key,
    required this.club,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double coverWidth = screenSize.width;
    return MasterScreenWidget(
      showProfileIcon: false,
      selectedIndex: widget.selectedIndex,
      title: widget.club.name,
      showBackArrow: true,
      child: SingleChildScrollView(
        child: Column(children: [
          ClipRRect(
              child: Image.memory(
            imageFromBase64String(widget.club.cover!.cover!),
            width: coverWidth,
            height: 200,
            fit: BoxFit.cover,
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text("${widget.club.name}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Created: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Palette.lightPurple)),
                      TextSpan(
                        text: DateFormat('MMM d, y')
                            .format(widget.club.dateCreated!),
                        style: const TextStyle(color: Palette.lightPurple),
                      ),
                    ],
                  ),
                ),
                GradientButton(
                  onPressed: () {
                    // Implement joining club
                  },
                  width: 70,
                  height: 23,
                  gradient: Palette.buttonGradient,
                  borderRadius: 50,
                  child: const Text("Join",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Text("${widget.club.description}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                buildUsersIcon(18),
                const SizedBox(width: 5),
                Text("${widget.club.memberCount}")
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: MySeparator(width: coverWidth),
          ),
          PostCard(),
        ]),
      ),
    );
  }
}
