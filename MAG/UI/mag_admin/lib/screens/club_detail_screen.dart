import 'package:flutter/material.dart';
import 'package:mag_admin/providers/comment_provider.dart';
import 'package:mag_admin/screens/post_detail_screen.dart';
import 'package:mag_admin/screens/user_detail_screen.dart';
import 'package:mag_admin/utils/util.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/pagination_buttons.dart';
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
  final ScrollController _scrollController = ScrollController();
  late UserProvider _userProvider;
  late PostProvider _postProvider;

  late Future<SearchResult<Post>> _postFuture;
  late CommentProvider _commentProvider;
  User? owner;

  int page = 0;
  int pageSize = 15;
  int totalItems = 0;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();
    _postFuture = _postProvider.get(filter: {
      "NewestFirst": "true",
      "ClubId": "${widget.club.id}",
      "CommentsIncluded": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    _commentProvider = context.read<CommentProvider>();

    _postProvider.addListener(() {
      _reloadPosts();
    });

    _commentProvider.addListener(() {
      _reloadPosts();
    });

    setTotalItems();

    super.initState();
  }

  void _reloadPosts() {
    var postList = _postProvider.get(filter: {
      "NewestFirst": "true",
      "ClubId": "${widget.club.id}",
      "CommentsIncluded": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    if (mounted) {
      setState(() {
        _postFuture = postList;
      });
    }
  }

  void setTotalItems() async {
    var postResult = await _postFuture;

    if (mounted) {
      setState(() {
        totalItems = postResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: Row(
        children: [
          buildClubsIcon(22),
          const SizedBox(width: 5),
          Text("${widget.club.name}"),
        ],
      ),
      showBackArrow: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 874),
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.club.name}",
                              style: const TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                                maxHeight: 150, maxWidth: 874),
                            child: Text("${widget.club.description}"),
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
                              const Icon(Icons.person_rounded, size: 27),
                              const SizedBox(width: 10),
                              FutureBuilder<SearchResult<User>>(
                                future: _userProvider.get(filter: {
                                  "Id": "${widget.club.ownerId!}",
                                  "ProfilePictureIncluded": "true"
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const MyProgressIndicator(); // Loading state
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        'Error: ${snapshot.error}'); // Error state
                                  } else {
                                    // Data loaded successfully
                                    var clubOwner =
                                        snapshot.data!.result.single;
                                    owner = clubOwner;
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
                                            style:
                                                const TextStyle(fontSize: 20)),
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
                              const SizedBox(width: 10),
                              Text("${widget.club.memberCount}",
                                  style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        Tooltip(
                          message: "Date created",
                          child: Row(
                            children: [
                              buildCalendarIcon(25),
                              const SizedBox(width: 10),
                              Text(
                                  DateFormat('MMM d, y')
                                      .format(widget.club.dateCreated!),
                                  style: const TextStyle(fontSize: 20)),
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
                  future: _postFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const MyProgressIndicator(); // Loading state
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Error state
                    } else {
                      // Data loaded successfully
                      var postList = snapshot.data!.result;
                      return Column(
                        children: [
                          Column(children: _buildPosts(postList)),
                          MyPaginationButtons(
                              page: page,
                              pageSize: pageSize,
                              totalItems: totalItems,
                              fetchPage: fetchPage)
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _postProvider.get(
        filter: {
          "NewestFirst": "true",
          "ClubId": "${widget.club.id}",
          "CommentsIncluded": "true",
          "Page": "$requestedPage",
          "PageSize": "$pageSize",
        },
      );

      if (mounted) {
        setState(() {
          _postFuture = Future.value(result);
          page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildPosts(List<Post> postList) {
    return List.generate(
      postList.length,
      (index) => _buildPost(postList[index]),
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
                                        visible:
                                            user.username == owner?.username,
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
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  _buildPopupMenu(post),
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
                        controller: ScrollController(),
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
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PostDetailScreen(
                                          post: post,
                                          clubOwner: owner!,
                                        )));
                              },
                              child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child:
                                      Text("${post.comments?.length} replies")))
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

  Widget _buildPopupMenu(Post post) {
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
          padding: EdgeInsets.zero,
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            hoverColor: Palette.lightRed.withOpacity(0.1),
            leading: buildTrashIcon(24),
            title:
                const Text('Delete', style: TextStyle(color: Palette.lightRed)),
            subtitle: Text('Delete permanently',
                style: TextStyle(color: Palette.lightRed.withOpacity(0.5))),
            onTap: () {
              Navigator.pop(context);
              showConfirmationDialog(
                  context,
                  const Icon(Icons.warning_rounded,
                      color: Palette.lightRed, size: 55),
                  const Text("Are you sure you want to delete this post?"),
                  () async {
                await _postProvider.delete(post.id!);
              });
            },
          ),
        ),
      ],
    );
  }
}
