import 'package:flutter/material.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/providers/club_provider.dart';
import 'package:mag_admin/providers/comment_provider.dart';
import 'package:mag_admin/providers/post_provider.dart';
import 'package:mag_admin/providers/rating_provider.dart';
import 'package:mag_admin/screens/anime_screen.dart';
import 'package:mag_admin/screens/reviews_screen.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:mag_admin/widgets/separator.dart';
import 'package:provider/provider.dart';
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
import 'package:intl/intl.dart';

import 'anime_detail_screen.dart';

class UserDetailScreen extends StatefulWidget {
  User? user;
  String? profilePicture;
  UserDetailScreen({Key? key, this.user, this.profilePicture})
      : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late RatingProvider _ratingProvider;
  late PostProvider _postProvider;
  late CommentProvider _commentProvider;
  late AnimeProvider _animeProvider;
  late ClubProvider _clubProvider;

  Rating? rating;
  Post? post;
  Comment? comment;

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: widget.user != null
          ? Text("User details: ${widget.user!.username}")
          : Text(""),
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
    _postProvider = context.read<PostProvider>();
    _commentProvider = context.read<CommentProvider>();
    _animeProvider = context.read<AnimeProvider>();
    _clubProvider = context.read<ClubProvider>();

    super.initState();
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
                          child: Image.memory(
                            imageFromBase64String(widget.profilePicture!),
                            width: 360,
                            height: 330,
                            fit: BoxFit.cover,
                          )),
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
                      Text("Posts", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
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
                      Text("Comments", style: TextStyle(fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
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
        future: _commentProvider.get(filter: {
          "UserId": "${widget.user!.id}",
          "NewestFirst": "true",
          "Page": "0",
          "PageSize": "1"
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
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
                  child: _buildSeeMoreButton(AnimeScreen())),
            ],
          );
        });
  }

  FutureBuilder<SearchResult<Post>> _postFutureBuilder() {
    return FutureBuilder<SearchResult<Post>>(
        future: _postProvider.get(filter: {
          "UserId": "${widget.user!.id}",
          "NewestFirst": "true",
          "Page": "0",
          "PageSize": "1"
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
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
                child: _buildSeeMoreButton(AnimeScreen()),
              ),
            ],
          );
        });
  }

  FutureBuilder<SearchResult<Rating>> _ratingFutureBuilder() {
    return FutureBuilder<SearchResult<Rating>>(
        future: _ratingProvider.get(filter: {
          "UserId": "${widget.user!.id}",
          "NewestFirst": "true",
          "Page": "0",
          "PageSize": "1"
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
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
                  widget.user!,
                  profilePicture: widget.profilePicture,
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

  //Adjust this part
  Widget _buildCard({dynamic object}) {
    if (object == null) {
      return Container(
          child: Text("No content to show",
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Palette.lightPurple.withOpacity(0.5),
              )));
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, right: 0),
      child: Container(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
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
                        padding: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            imageFromBase64String(widget.profilePicture!),
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
                              "${widget.user!.firstName} ${widget.user!.lastName}",
                              style: TextStyle(
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
                                    return CircularProgressIndicator(); // Loading state
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
                                      return Text("Anime not found");
                                    }
                                  }
                                }),
                          ),
                          Visibility(
                            visible: post != null && object is Post,
                            child: FutureBuilder<Club>(
                                future: post != null
                                    ? _clubProvider.getById(post!.clubId!)
                                    : null,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Loading state
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        'Error: ${snapshot.error}'); // Error state
                                  } else {
                                    // Data loaded successfully

                                    Club? tmp = snapshot.data;
                                    if (tmp != null) {
                                      return Text("${tmp.name}");
                                    } else {
                                      return Text("Club not found");
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
                                    return CircularProgressIndicator(); // Loading state
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        'Error: ${snapshot.error}'); // Error state
                                  } else {
                                    // Data loaded successfully

                                    Post? tmp = snapshot.data;
                                    if (tmp != null) {
                                      return Text("Post #${tmp.id}");
                                    } else {
                                      return Text("Club not found");
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildPopupMenu()
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
                  child: Column(
                    children: [
                      Visibility(
                        visible: object is Rating,
                        child: Text(
                          "${rating?.reviewText}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: object is Post,
                        child: Text(
                          "${post?.content}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Visibility(
                        visible: object is Comment,
                        child: Text(
                          "${comment?.content}",
                          style: TextStyle(fontSize: 15),
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

  ConstrainedBox _buildPopupMenu() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 23),
      child: Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            /* IconButton(
              constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
              alignment: Alignment.topCenter,
              tooltip: "Hide from viewers",
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              padding: EdgeInsets.zero,
              splashRadius: 0.1,
              onPressed: () {},
              icon: Icon(
                Icons.visibility_off_outlined,
                size: 24,
              ),
            ),*/
            PopupMenuButton<String>(
              tooltip: "More actions",
              offset: Offset(195, 0),
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
                    leading: Icon(Icons.text_snippet_rounded,
                        color: Palette.lightPurple),
                    title: Text('See details',
                        style: TextStyle(color: Palette.lightPurple)),
                    subtitle: Text('See more information about this',
                        style: TextStyle(
                            color: Palette.lightPurple.withOpacity(0.5))),
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
                            color: Palette.lightRed.withOpacity(0.5))),
                    onTap: () async {},
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
