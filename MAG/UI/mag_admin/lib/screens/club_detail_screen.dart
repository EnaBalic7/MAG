import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/separator.dart';

import '../utils/colors.dart';
import '../utils/icons.dart';

class ClubDetailScreen extends StatefulWidget {
  ClubDetailScreen({Key? key}) : super(key: key);

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildClubsIcon(22),
          SizedBox(width: 5),
          Text("Clubs"),
        ],
      ),
      showSearch: true,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 874),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/blackClover.jpg",
                    width: 874,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Black Clover",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 874,
                            height: 150,
                            child: SingleChildScrollView(
                              child: Text(
                                  "Step into the enchanting world of Black Clover as you enter the gates of our illustrious Black Clover club! Immerse yourself in the magical realm of this captivating anime and manga series, where the boundless potential of mana intertwines with the indomitable spirit of our beloved characters. Here within the confines of our club, we passionately delve into every facet of the Black Clover universe, exploring the intricate tapestry of its narrative, characters, and the mesmerizing blend of sorcery and adventure. Our discussions transcend the ordinary, reaching into the very essence of what makes Black Clover an extraordinary journey. Whether you find yourself enchanted by the relentless determination of Asta, the charismatic leadership of Yuno, or the enigmatic allure of the Clover Kingdom, our community is a haven for fans to share their favorite characters, memorable scenes, and unforgettable moments that have left an indelible mark on our hearts. But that's not all; we extend our gaze beyond the current episodes and chapters, eagerly anticipating and speculating on the potential twists and turns that the future holds for our cherished series. From theorizing about upcoming events to contemplating the evolution of our characters, every member is invited to contribute their insights, theories, and wild predictions, fostering an atmosphere of camaraderie and excitement."),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tooltip(
                          message: "Club owner",
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.person_rounded, size: 27),
                              SizedBox(width: 10),
                              Text("Mika", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Tooltip(
                          message: "Number of club members",
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildUsersIcon(27),
                              SizedBox(width: 10),
                              Text("2157", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Tooltip(
                          message: "Date created",
                          child: Row(
                            children: [
                              buildCalendarIcon(25),
                              SizedBox(width: 10),
                              Text("Jul 7, 2023",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    MySeparator(
                      width: 874,
                      borderRadius: 100,
                      paddingTop: 10,
                      opacity: 0.5,
                    ),
                  ],
                ),
                _buildPost(),
                _buildPost(),
                _buildPost(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPost() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        width: 874,
        decoration: BoxDecoration(
            color: Palette.darkPurple, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("assets/images/blackClover.jpg",
                                width: 70, height: 70, fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Celeste_27",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          Text("Aug 30, 2023", style: TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      width: 844,
                      height: 100,
                      child: SingleChildScrollView(
                        child: Text(
                          "Do you think that maybe Julius was the enemy all along? I mean, think about it, there were so many moments everyone could have died in the Spade arc, but everything kept working out right at the very last moment. Let’s not forget the clock that was shown so many times, with its time never making any sense. It seems like there’s time magic at play here. What do you guys think?Do you think that maybe Julius was the enemy all along? I mean, think about it, there were so many moments everyone could have died in the Spade arc, but everything kept working out right at the very last moment. Let’s not forget the clock that was shown so many times, with its time never making any sense. It seems like there’s time magic at play here. What do you guys think?",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up_rounded),
                          SizedBox(width: 5),
                          Text("25")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_down_rounded),
                          SizedBox(width: 5),
                          Text("2")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Row(
                        children: [Text("12 replies")],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
