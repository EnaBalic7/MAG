import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/club_provider.dart';
import '../providers/post_provider.dart';
import '../screens/club_detail_screen.dart';
import '../screens/post_detail_screen.dart';
import '../utils/icons.dart';
import '../widgets/master_screen.dart';
import '../models/club.dart';
import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/pagination_buttons.dart';

// ignore: must_be_immutable
class PostsScreen extends StatefulWidget {
  User user;
  PostsScreen({super.key, required this.user});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostProvider _postProvider;
  late Future<SearchResult<Post>> _postFuture;
  late ClubProvider _clubProvider;
  int? ownerId;

  int page = 0;
  int pageSize = 6;
  int totalItems = 0;

  @override
  void initState() {
    _postProvider = context.read<PostProvider>();
    _postFuture = _postProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "CommentsIncluded": "true",
      "Page": "$page",
      "PageSize": "$pageSize"
    });

    _clubProvider = context.read<ClubProvider>();

    _postProvider.addListener(() {
      _reloadData();
      setTotalItems();
    });

    setTotalItems();

    super.initState();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {
        _postFuture = _postProvider.get(filter: {
          "UserId": "${widget.user.id}",
          "NewestFirst": "true",
          "CommentsIncluded": "true",
          "Page": "$page",
          "PageSize": "$pageSize"
        });
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.user.profilePicture!.profilePicture != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    imageFromBase64String(
                        widget.user.profilePicture!.profilePicture!),
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                )
              : const Text(""),
          const SizedBox(width: 5),
          Text("${widget.user.username}: "),
          const SizedBox(width: 5),
          const Text("Posts"),
          const SizedBox(width: 5),
          buildPostIcon(24),
        ],
      ),
      showBackArrow: true,
      child: FutureBuilder<SearchResult<Post>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var postList = snapshot.data!.result;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildPostCards(postList),
                    ),
                    MyPaginationButtons(
                        page: page,
                        pageSize: pageSize,
                        totalItems: totalItems,
                        fetchPage: fetchPage),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await _postProvider.get(
        filter: {
          "UserId": "${widget.user.id}",
          "NewestFirst": "true",
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
      if (mounted) {
        showErrorDialog(context, e);
      }
    }
  }

  List<Widget> _buildPostCards(List<Post> postList) {
    return List.generate(
      postList.length,
      (index) => _buildPostCard(postList[index]),
    );
  }

  Widget _buildPostCard(Post post) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, right: 20, top: 20),
      child: Container(
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 300),
        height: 215,
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
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            imageFromBase64String(
                                widget.user.profilePicture!.profilePicture!),
                            width: 43,
                            height: 43,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 350),
                            child: Text(
                                "${widget.user.firstName} ${widget.user.lastName}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          FutureBuilder<SearchResult<Club>>(
                              future: _clubProvider.get(filter: {
                                "Id": "${post.clubId!}",
                                "CoverIncluded": "True"
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

                                  Club? tmp = snapshot.data?.result.first;

                                  if (tmp != null) {
                                    ownerId = tmp.ownerId;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ClubDetailScreen(club: tmp),
                                          ),
                                        );
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text("${tmp.name}"),
                                      ),
                                    );
                                  } else {
                                    return const Text("Club not found");
                                  }
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        DateFormat('MMM d, y').format(
                          post.datePosted!,
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                _buildPopupMenu(post)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.topLeft,
                constraints:
                    const BoxConstraints(minHeight: 30, maxHeight: 100),
                //height: 100,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Text(
                        "${post.content}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 30),
              child: Padding(
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
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PostDetailScreen(
                                          post: post,
                                          ownerId: ownerId!,
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
              ),
            )
          ]),
        ),
      ),
    );
  }

  ConstrainedBox _buildPopupMenu(Post post) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 23),
      child: Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            PopupMenuButton<String>(
              tooltip: "More actions",
              offset: const Offset(195, 0),
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
                    hoverColor: Palette.lightRed.withOpacity(0.1),
                    leading: buildTrashIcon(24),
                    title: const Text('Delete',
                        style: TextStyle(color: Palette.lightRed)),
                    subtitle: Text('Delete permanently',
                        style: TextStyle(
                            color: Palette.lightRed.withOpacity(0.5))),
                    onTap: () async {
                      Navigator.pop(context);
                      showConfirmationDialog(
                          context,
                          const Icon(Icons.warning_rounded,
                              color: Palette.lightRed, size: 55),
                          const Text(
                              "Are you sure you want to delete this post?"),
                          () async {
                        await _postProvider.delete(post.id!);
                      });
                    },
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
