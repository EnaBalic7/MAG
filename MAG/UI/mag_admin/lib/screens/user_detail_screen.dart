import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/anime_provider.dart';
import '../providers/club_provider.dart';
import '../providers/comment_provider.dart';
import '../providers/post_provider.dart';
import '../providers/rating_provider.dart';
import '../screens/club_detail_screen.dart';
import '../screens/comments_screen.dart';
import '../screens/post_detail_screen.dart';
import '../screens/posts_screen.dart';
import '../screens/reviews_screen.dart';
import '../widgets/master_screen.dart';
import '../widgets/separator.dart';
import '../models/anime.dart';
import '../models/club.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../models/rating.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import 'anime_detail_screen.dart';

// ignore: must_be_immutable
class UserDetailScreen extends StatefulWidget {
  User user;
  UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late RatingProvider _ratingProvider;
  late Future<SearchResult<Rating>> _ratingFuture;
  late Future<SearchResult<Post>> _postFuture;
  late Future<SearchResult<Comment>> _commentFuture;
  late PostProvider _postProvider;
  late CommentProvider _commentProvider;
  late AnimeProvider _animeProvider;
  late ClubProvider _clubProvider;
  int? clubId;
  int? ownerId;

  Rating? rating;
  Post? post;
  Comment? comment;

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      titleWidget: Text("User details: ${widget.user.username}"),
      showBackArrow: true,
      child: Center(
        child: Row(children: [
          _buildUserInfo(),
          _buildUserContent(),
        ]),
      ),
    );
  }

  @override
  void initState() {
    _ratingProvider = context.read<RatingProvider>();
    _ratingFuture = _ratingProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    _postProvider = context.read<PostProvider>();
    _postFuture = _postProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    _commentProvider = context.read<CommentProvider>();
    _commentFuture = _commentProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    _animeProvider = context.read<AnimeProvider>();
    _clubProvider = context.read<ClubProvider>();

    _ratingProvider.addListener(() {
      _reloadReview();
    });

    _postProvider.addListener(() {
      _reloadPost();
    });

    _commentProvider.addListener(() {
      _reloadComment();
    });

    super.initState();
  }

  void _reloadReview() {
    var rating = _ratingProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    if (mounted) {
      setState(() {
        _ratingFuture = rating;
      });
    }
  }

  void _reloadPost() {
    var post = _postProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    if (mounted) {
      setState(() {
        _postFuture = post;
      });
    }
  }

  void _reloadComment() {
    var comment = _commentProvider.get(filter: {
      "UserId": "${widget.user.id}",
      "NewestFirst": "true",
      "Page": "0",
      "PageSize": "1"
    });

    if (mounted) {
      setState(() {
        _commentFuture = comment;
      });
    }
  }

  Padding _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(
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
                      padding: const EdgeInsets.only(top: 15),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            imageFromBase64String(
                                widget.user.profilePicture!.profilePicture!),
                            width: 360,
                            height: 330,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user.username}",
                                style: const TextStyle(
                                    color: Palette.lightPurple)),
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user.firstName}",
                                style: const TextStyle(
                                    color: Palette.lightPurple)),
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text("${widget.user.lastName}",
                                style: const TextStyle(
                                    color: Palette.lightPurple)),
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text(widget.user.email ?? '-',
                                style: const TextStyle(
                                    color: Palette.lightPurple)),
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Palette.listTile,
                        ),
                        child: Column(children: [
                          ListTile(
                            horizontalTitleGap: 25,
                            title: Text(
                                DateFormat('MMM d, y')
                                    .format(widget.user.dateJoined!),
                                style: const TextStyle(
                                    color: Palette.lightPurple)),
                            subtitle: Text("Date joined",
                                style: TextStyle(
                                    color:
                                        Palette.lightPurple.withOpacity(0.5))),
                            leading: buildCalendarIcon(40,
                                color: Palette.lightPurple.withOpacity(0.7)),
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
        padding: const EdgeInsets.only(left: 150, top: 0),
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
                      const Text("Reviews", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: buildStarTrailIcon(22),
                      )
                    ],
                  ),
                  _ratingFutureBuilder(),
                  MySeparator(
                    width: 600,
                    borderRadius: 50,
                    opacity: 0.5,
                    marginVertical: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Posts", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: buildPostIcon(23),
                      )
                    ],
                  ),
                  _postFutureBuilder(),
                  MySeparator(
                    width: 600,
                    borderRadius: 50,
                    opacity: 0.5,
                    marginVertical: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Comments", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: buildCommentIcon(19),
                      )
                    ],
                  ),
                  _commentFutureBuilder(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<SearchResult<Comment>> _commentFutureBuilder() {
    return FutureBuilder<SearchResult<Comment>>(
        future: _commentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            if (snapshot.data!.result.isEmpty) {
              comment = null;
            } else {
              comment = snapshot.data!.result.single;
            }
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCard(object: comment),
              Visibility(
                  visible: comment != null,
                  child:
                      _buildSeeMoreButton(CommentsScreen(user: widget.user))),
            ],
          );
        });
  }

  FutureBuilder<SearchResult<Post>> _postFutureBuilder() {
    return FutureBuilder<SearchResult<Post>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            if (snapshot.data!.result.isEmpty) {
              post = null;
            } else {
              post = snapshot.data!.result.single;
            }
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCard(object: post),
              Visibility(
                visible: post != null,
                child: _buildSeeMoreButton(PostsScreen(user: widget.user)),
              ),
            ],
          );
        });
  }

  FutureBuilder<SearchResult<Rating>> _ratingFutureBuilder() {
    return FutureBuilder<SearchResult<Rating>>(
        future: _ratingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            if (snapshot.data!.result.isEmpty) {
              rating = null;
            } else {
              rating = snapshot.data!.result.single;
            }
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCard(object: rating),
              Visibility(
                visible: rating != null,
                child: _buildSeeMoreButton(ReviewsScreen(
                  user: widget.user,
                )),
              ),
            ],
          );
        });
  }

  TextButton _buildSeeMoreButton(Widget screenName) {
    return TextButton(
      key: UniqueKey(),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screenName));
      },
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Palette.lightPurple),
        splashFactory: InkRipple.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors
                  .transparent; // Set to transparent for the pressed state
            }
            return Colors.transparent; // Default overlay color
          },
        ),
      ),
      child: const Row(
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

  //Adjust this part
  Widget _buildCard({dynamic object}) {
    if (object == null) {
      return Text("No content to show",
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Palette.lightPurple.withOpacity(0.5),
          ));
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, right: 0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
        height: 194,
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
                          Text(
                              "${widget.user.firstName} ${widget.user.lastName}",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Visibility(
                            visible: rating != null && object is Rating,
                            child: FutureBuilder<SearchResult<Anime>>(
                                future: rating != null
                                    ? _animeProvider.get(filter: {
                                        "Id": "${rating!.animeId!}",
                                        "GenresIncluded": "True"
                                      })
                                    : null,
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

                                    Anime? tmp = snapshot.data?.result.single;
                                    if (tmp != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AnimeDetailScreen(anime: tmp),
                                            ),
                                          );
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text("${tmp.titleEn}"),
                                        ),
                                      );
                                    } else {
                                      return const Text("Anime not found");
                                    }
                                  }
                                }),
                          ),
                          Visibility(
                            visible: post != null && object is Post,
                            child: FutureBuilder<SearchResult<Club>>(
                                future: post != null
                                    ? _clubProvider.get(filter: {
                                        "Id": "${post!.clubId!}",
                                        "CoverIncluded": "true"
                                      })
                                    : null,
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
                                            child: Text("${tmp.name}")),
                                      );
                                    } else {
                                      return const Text("Club not found");
                                    }
                                  }
                                }),
                          ),
                          Visibility(
                            visible: comment != null && object is Comment,
                            child: FutureBuilder<Post>(
                                future: comment != null
                                    ? _postProvider.getById(comment!.postId!)
                                    : null,
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

                                    Post? post = snapshot.data;

                                    if (post != null) {
                                      clubId = post.clubId;
                                      _getClubOwnerId();
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PostDetailScreen(
                                                post: post,
                                                ownerId: ownerId!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text("Post #${post.id}"),
                                        ),
                                      );
                                    } else {
                                      return const Text("Post not found");
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: rating != null && object is Rating,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildStarIcon(15),
                            const SizedBox(width: 3),
                            rating != null
                                ? Text("${rating!.ratingValue.toString()}/10",
                                    style: const TextStyle(
                                        color: Palette.starYellow,
                                        fontSize: 13))
                                : const Text(""),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: rating != null
                            ? Text(
                                DateFormat('MMM d, y').format(
                                  rating!.dateAdded!,
                                ),
                                style: const TextStyle(fontSize: 13),
                              )
                            : const Text(""),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: post != null && object is Post,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: post != null
                        ? Text(
                            DateFormat('MMM d, y').format(
                              post!.datePosted!,
                            ),
                            style: const TextStyle(fontSize: 13),
                          )
                        : const Text(""),
                  ),
                ),
                Visibility(
                  visible: comment != null && object is Comment,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: comment != null
                        ? Text(
                            DateFormat('MMM d, y').format(
                              comment!.dateCommented!,
                            ),
                            style: const TextStyle(fontSize: 13),
                          )
                        : const Text(""),
                  ),
                ),
                const SizedBox(width: 10)
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
                      Visibility(
                        visible: object is Rating,
                        child: Text(
                          "${rating?.reviewText}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: object is Post,
                        child: Text(
                          "${post?.content}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: object is Comment,
                        child: Text(
                          "${comment?.content}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _getClubOwnerId() async {
    if (post != null) {
      Club club = await _clubProvider.getById(post!.clubId!);
      ownerId = club.ownerId;
      return;
    } else if (comment != null) {
      Comment cmt = await _commentProvider.getById(comment!.id!);
      Post pst = await _postProvider.getById(cmt.postId!);
      Club club = await _clubProvider.getById(pst.clubId!);
      ownerId = club.ownerId;
    }
  }
}
