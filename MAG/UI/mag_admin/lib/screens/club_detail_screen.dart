import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/screens/user_detail_screen.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/separator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/club.dart';
import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../widgets/circular_progress_indicator.dart';

class ClubDetailScreen extends StatefulWidget {
  Club club;

  ClubDetailScreen({Key? key, required this.club}) : super(key: key);

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  ScrollController _scrollController = ScrollController();
  late UserProvider _userProvider;
  late PostProvider _postProvider;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildClubsIcon(22),
          SizedBox(width: 5),
          Text("${widget.club.name}"),
        ],
      ),
      showBackArrow: true,
      child: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 874),
              child: Column(
                children: [
                  (widget.club.cover != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            imageFromBase64String(widget.club.cover!.cover!),
                            width: 874,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${widget.club.name}",
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
                              constraints:
                                  BoxConstraints(maxHeight: 150, maxWidth: 874),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Text("${widget.club.description}"),
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
                                FutureBuilder<SearchResult<User>>(
                                  future: _userProvider.get(filter: {
                                    "Id": "${widget.club.ownerId!}",
                                    "ProfilePictureIncluded": "true"
                                  }),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return MyProgressIndicator(); // Loading state
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Error: ${snapshot.error}'); // Error state
                                    } else {
                                      // Data loaded successfully
                                      var clubOwner =
                                          snapshot.data!.result.single;
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserDetailScreen(
                                                          user: clubOwner)));
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text("${clubOwner.username}",
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                      );
                                    }
                                  },
                                ),
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
                                Text("${widget.club.memberCount}",
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          Tooltip(
                            message: "Date created",
                            child: Row(
                              children: [
                                buildCalendarIcon(25),
                                SizedBox(width: 10),
                                Text(
                                    DateFormat('MMM d, y')
                                        .format(widget.club.dateCreated!),
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
                  FutureBuilder<SearchResult<Post>>(
                    future: _postProvider.get(filter: {
                      "NewestFirst": "true",
                      "ClubId": "${widget.club.id}"
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        // Data loaded successfully
                        var postList = snapshot.data!.result;
                        return Column(children: _buildPosts(postList));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPosts(List<Post> postList) {
    return List.generate(
      postList.length,
      (index) => _buildPost(postList[index]),
    );
  }

  Widget _buildPost(Post post) {
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
                  FutureBuilder<SearchResult<User>>(
                    future: _userProvider.get(filter: {
                      "Id": "${post.userId}",
                      "ProfilePictureIncluded": "true"
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        // Data loaded successfully
                        User user = snapshot.data!.result.first;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                      imageFromBase64String(
                                          user.profilePicture!.profilePicture!),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${user.username}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Text(
                                    DateFormat('MMM d, y')
                                        .format(post.datePosted!),
                                    style: TextStyle(fontSize: 12)),
                              ],
                            )
                          ],
                        );
                      }
                    },
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
                          "${post.content}",
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
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up_rounded),
                          SizedBox(width: 5),
                          Text("${post.likesCount}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_down_rounded),
                          SizedBox(width: 5),
                          Text("${post.dislikesCount}")
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
