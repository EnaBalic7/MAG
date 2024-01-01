import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mag_admin/models/comment.dart';
import 'package:mag_admin/screens/user_detail_screen.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/separator.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';

class PostDetailScreen extends StatefulWidget {
  Post post;
  User clubOwner;
  PostDetailScreen({
    Key? key,
    required this.post,
    required this.clubOwner,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late UserProvider _userProvider;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          buildPostIcon(22),
          const SizedBox(width: 5),
          Text("Post #${widget.post.id}"),
        ],
      ),
      showBackArrow: true,
      child: Center(
        child: Column(
          children: [
            _buildPost(widget.post),
            MySeparator(
              width: 824,
              opacity: 0.5,
              paddingTop: 20,
              paddingBottom: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Comments",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: _buildCommentCards(widget.post.comments!),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCommentCards(List<Comment> commentList) {
    return List.generate(
      commentList.length,
      (index) => _buildComment(commentList[index]),
    );
  }

  Widget _buildComment(Comment comment) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        width: 804,
        decoration: BoxDecoration(
            color: Palette.darkPurple, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<SearchResult<User>>(
                    future: _userProvider.get(filter: {
                      "Id": "${comment.userId}",
                      "ProfilePictureIncluded": "true"
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        // Data loaded successfully
                        User user = snapshot.data!.result.first;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                      imageFromBase64String(
                                          user.profilePicture!.profilePicture!),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetailScreen(
                                                        user: user)));
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text("${user.username}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Visibility(
                                        visible: user.username ==
                                            widget.clubOwner.username,
                                        child: Tooltip(
                                            message: "Club owner",
                                            child: buildCrownIcon(15))),
                                  ],
                                ),
                                Text(
                                    DateFormat('MMM d, y')
                                        .format(comment.dateCommented!),
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            )
                          ],
                        );
                      }
                    },
                  ),
                  _buildPopupMenu(comment)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 774,
                      height: 70,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Text(
                          "${comment.content}",
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up_rounded),
                          const SizedBox(width: 5),
                          Text("${comment.likesCount}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_down_rounded),
                          const SizedBox(width: 5),
                          Text("${comment.dislikesCount}")
                        ],
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

  Widget _buildPost(Post post) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        width: 874,
        decoration: BoxDecoration(
            color: Palette.darkPurple, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<SearchResult<User>>(
                    future: _userProvider.get(filter: {
                      "Id": "${post.userId}",
                      "ProfilePictureIncluded": "true"
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MyProgressIndicator(); // Loading state
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Error state
                      } else {
                        // Data loaded successfully
                        User user = snapshot.data!.result.first;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
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
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetailScreen(
                                                        user: user)));
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text("${user.username}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Visibility(
                                        visible: user.username ==
                                            widget.clubOwner.username,
                                        child: Tooltip(
                                            message: "Club owner",
                                            child: buildCrownIcon(15))),
                                  ],
                                ),
                                Text(
                                    DateFormat('MMM d, y')
                                        .format(post.datePosted!),
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            )
                          ],
                        );
                      }
                    },
                  ),
                  _buildPopupMenu(post)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    // ignore: sized_box_for_whitespace
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
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up_rounded),
                          const SizedBox(width: 5),
                          Text("${post.likesCount}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_down_rounded),
                          const SizedBox(width: 5),
                          Text("${post.dislikesCount}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [Text("${post.comments?.length} replies")],
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

  Widget _buildPopupMenu(Object object) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title: Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              Navigator.pop(context);
              (object is Post)
                  ? showConfirmationDialog(
                      context,
                      Icon(Icons.warning_rounded,
                          color: Palette.lightRed, size: 55),
                      Text("Are you sure you want to delete this post?"),
                      () async {
                      /*await _genreAnimeProvider.deleteByAnimeId(anime.id!);
                _animeProvider.delete(anime.id!);*/
                    })
                  : showConfirmationDialog(
                      context,
                      Icon(Icons.warning_rounded,
                          color: Palette.lightRed, size: 55),
                      Text("Are you sure you want to delete this comment?"),
                      () async {
                      /*await _genreAnimeProvider.deleteByAnimeId(anime.id!);
                _animeProvider.delete(anime.id!);*/
                    });
            },
          ),
        ),
      ],
    );
  }
}
