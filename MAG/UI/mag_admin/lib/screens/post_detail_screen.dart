import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../providers/club_provider.dart';
import '../providers/comment_provider.dart';
import '../screens/club_detail_screen.dart';
import '../screens/user_detail_screen.dart';
import '../widgets/master_screen.dart';
import '../widgets/pagination_buttons.dart';
import '../widgets/separator.dart';
import '../models/club.dart';
import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';

// ignore: must_be_immutable
class PostDetailScreen extends StatefulWidget {
  Post post;
  int ownerId;
  PostDetailScreen({
    super.key,
    required this.post,
    required this.ownerId,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late UserProvider _userProvider;
  late CommentProvider _commentProvider;
  late Future<SearchResult<Comment>> _commentFuture;
  late PostProvider _postProvider;
  late ClubProvider _clubProvider;

  int page = 0;
  int pageSize = 15;
  int totalItems = 0;
  int? replies;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _commentProvider = context.read<CommentProvider>();
    _commentFuture = _commentProvider.get(filter: {
      "PostId": "${widget.post.id}",
      "NewestFirst": "true",
      "Page": "$page",
      "PageSize": "$pageSize",
    });
    _postProvider = context.read<PostProvider>();

    _commentProvider.addListener(() {
      _reloadComments();
      setTotalItems();
    });

    _clubProvider = context.read<ClubProvider>();
    replies = widget.post.comments!.length;
    setTotalItems();

    super.initState();
  }

  void _reloadComments() async {
    var commentsList = _commentProvider.get(filter: {
      "PostId": "${widget.post.id}",
      "NewestFirst": "true",
      "Page": "$page",
      "PageSize": "$pageSize",
    });

    var tmp = await _commentProvider.get(filter: {
      "PostId": "${widget.post.id}",
    });

    replies = tmp.result.length;

    if (mounted) {
      setState(() {
        _commentFuture = commentsList;
      });
    }
  }

  void setTotalItems() async {
    var commentResult = await _commentFuture;
    if (mounted) {
      setState(() {
        totalItems = commentResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: Row(
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
              paddingBottom: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Comments",
                style: TextStyle(fontSize: 20),
              ),
            ),
            FutureBuilder<SearchResult<Comment>>(
                future: _commentFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyProgressIndicator(); // Loading state
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Error state
                  } else {
                    // Data loaded successfully
                    var commentsList = snapshot.data!.result;
                    return Expanded(
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            Column(
                              children: _buildCommentCards(commentsList),
                            ),
                            MyPaginationButtons(
                              page: page,
                              pageSize: pageSize,
                              totalItems: totalItems,
                              fetchPage: fetchPage,
                              noResults: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No one has commented under this post yet...",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    color: Palette.lightPurple.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _commentProvider.get(
        filter: {
          "PostId": "${widget.post.id}",
          "NewestFirst": "true",
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      if (mounted) {
        setState(() {
          _commentFuture = Future.value(result);
          page = requestedPage;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        showErrorDialog(context, e);
      }
    }
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
                                    _buildClubOwnerIconForComment(user),
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

  FutureBuilder<SearchResult<User>> _buildClubOwnerIconForComment(User user) {
    return FutureBuilder<SearchResult<User>>(
        future: _userProvider.get(filter: {
          "Id": "${widget.ownerId}",
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              width: 10,
              height: 10,
              strokeWidth: 2,
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            User clubOwnerObj = snapshot.data!.result.first;
            return Visibility(
                visible: user.username == clubOwnerObj.username,
                child:
                    Tooltip(message: "Club owner", child: buildCrownIcon(15)));
          }
        });
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
                                    _buildClubOwnerIconForPost(user),
                                  ],
                                ),
                                FutureBuilder<SearchResult<Club>>(
                                    future: _clubProvider.get(filter: {
                                      "Id": "${post.clubId}",
                                      "CoverIncluded": "true",
                                    }),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const MyProgressIndicator(
                                          width: 10,
                                          height: 10,
                                          strokeWidth: 2,
                                        ); // Loading state
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            'Error: ${snapshot.error}'); // Error state
                                      } else {
                                        // Data loaded successfully
                                        Club club = snapshot.data!.result.first;
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        ClubDetailScreen(
                                                            club: club)));
                                          },
                                          child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Text(
                                                "${club.name}",
                                              )),
                                        );
                                      }
                                    }),
                                Text(
                                    DateFormat('MMM d, y')
                                        .format(post.datePosted!),
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
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
                        children: [Text("$replies replies")],
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

  FutureBuilder<SearchResult<User>> _buildClubOwnerIconForPost(User user) {
    return FutureBuilder<SearchResult<User>>(
        future: _userProvider.get(filter: {
          "Id": "${widget.ownerId}",
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              width: 10,
              height: 10,
              strokeWidth: 2,
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            User clubOwner = snapshot.data!.result.first;
            return Visibility(
                visible: user.username == clubOwner.username,
                child:
                    Tooltip(message: "Club owner", child: buildCrownIcon(15)));
          }
        });
  }

  Widget _buildPopupMenu(Object object) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
      ),
      icon: const Icon(Icons.more_vert_rounded),
      splashRadius: 1,
      padding: EdgeInsets.zero,
      color: const Color.fromRGBO(50, 48, 90, 1),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title:
                const Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              Navigator.pop(context);
              (object is Post)
                  ? showConfirmationDialog(
                      context,
                      const Icon(Icons.warning_rounded,
                          color: Palette.lightRed, size: 55),
                      const Text("Are you sure you want to delete this post?"),
                      () async {
                      Navigator.pop(context);
                      await _postProvider.delete((object as Post).id!);

                      if (context.mounted) {
                        showInfoDialog(
                            context,
                            const Icon(Icons.task_alt,
                                color: Palette.lightPurple, size: 50),
                            const Text(
                              "Post has been deleted.",
                              textAlign: TextAlign.center,
                            ));
                      }
                    })
                  : showConfirmationDialog(
                      context,
                      const Icon(Icons.warning_rounded,
                          color: Palette.lightRed, size: 55),
                      const Text(
                          "Are you sure you want to delete this comment?"),
                      () async {
                      await _commentProvider.delete((object as Comment).id!);
                    });
            },
          ),
        ),
      ],
    );
  }
}
