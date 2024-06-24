import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'dart:ui' as UI;
import 'package:intl/intl.dart';
import 'package:mag_user/providers/comment_provider.dart';
import 'package:mag_user/providers/post_provider.dart';
import 'package:mag_user/providers/user_comment_action_provider.dart';
import 'package:mag_user/providers/user_post_action_provider.dart';
import 'package:mag_user/providers/user_provider.dart';
import 'package:mag_user/screens/post_detail_screen.dart';
import 'package:mag_user/widgets/like_dislike_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/comment.dart';
import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';

class ContentCard extends StatefulWidget {
  final Post? post;
  final Comment? comment;
  final Color? cardColor;
  final bool? navigateToPostDetails;
  final int? contentMaxLines;
  final bool? largeProfilePhoto;

  const ContentCard({
    Key? key,
    this.post,
    this.comment,
    this.cardColor,
    this.navigateToPostDetails = true,
    this.contentMaxLines = 3,
    this.largeProfilePhoto,
  })  : assert(post != null || comment != null,
            "Either post or comment must be provided."),
        assert(!(post != null && comment != null),
            "Only one of post or comment can be provided."),
        super(key: key);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  late final UserProvider _userProvider;
  late Future<SearchResult<User>> _userFuture;
  bool isExpanded = false;
  bool isOverflowing = false;
  late final PostProvider _postProvider;
  late final CommentProvider _commentProvider;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _userFuture = _userProvider.get(filter: {
      "Id": (widget.post != null)
          ? "${widget.post!.userId}"
          : "${widget.comment!.userId}",
      "ProfilePictureIncluded": "true"
    });

    _postProvider = context.read<PostProvider>();
    _commentProvider = context.read<CommentProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double cardWidth = screenSize.width * 0.95;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
          color: widget.cardColor ?? Palette.darkPurple,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildCardTop(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final text = widget.post != null
                            ? widget.post!.content!
                            : widget.comment!.content!;
                        final textSpan = TextSpan(
                            text: text,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500));
                        final textPainter = TextPainter(
                          text: textSpan,
                          maxLines: widget.contentMaxLines,
                          textDirection: UI.TextDirection.ltr,
                        )..layout(maxWidth: constraints.maxWidth);

                        isOverflowing = textPainter.didExceedMaxLines;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                text,
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    isExpanded ? 10000 : widget.contentMaxLines,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            if (isOverflowing)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: isExpanded
                                    ? const Text("See less",
                                        style: TextStyle(
                                            color: Palette.lightYellow))
                                    : const Text(
                                        "See more",
                                        style: TextStyle(color: Palette.rose),
                                      ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.post != null
                          ? LikeDislikeButton(post: widget.post!)
                          : LikeDislikeButton(comment: widget.comment!),
                      const SizedBox(width: 25),
                      (widget.post != null)
                          ? GestureDetector(
                              onTap: () {
                                if (widget.post != null &&
                                    widget.navigateToPostDetails == true) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PostDetailScreen(post: widget.post!),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                  "${widget.post!.comments!.length} Replies"))
                          : const Text(""),
                    ],
                  ),
                  _showPopup(),
                ],
              ),
            ],
          ),
        ),
      ).asGlass(
        blurY: 3,
        blurX: 3,
        clipBorderRadius: BorderRadius.circular(15),
        tintColor: Palette.midnightPurple,
      ),
    );
  }

  Padding _buildCardTop() {
    if (widget.largeProfilePhoto == true) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildUsername(),
              ],
            )
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUsername(),
          (widget.largeProfilePhoto != true)
              ? Text(widget.post != null
                  ? DateFormat('MMM d, y').format(widget.post!.datePosted!)
                  : DateFormat('MMM d, y')
                      .format(widget.comment!.dateCommented!))
              : const Text(""),
        ],
      ),
    );
  }

  Widget _buildUsername() {
    final Size screenSize = MediaQuery.of(context).size;
    double cardWidth = screenSize.width * 0.95;

    return FutureBuilder<SearchResult<User>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildProgressIndicator(cardWidth);
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var user = snapshot.data!;
            if (user.count == 1 && widget.largeProfilePhoto != true) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      imageFromBase64String(
                          user.result.single.profilePicture!.profilePicture!),
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text("${user.result.single.username}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              );
            } else if (user.count == 1 && widget.largeProfilePhoto == true) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      imageFromBase64String(
                          user.result.single.profilePicture!.profilePicture!),
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${user.result.single.username}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 5),
                      Text(
                        widget.post != null
                            ? DateFormat('MMM d, y')
                                .format(widget.post!.datePosted!)
                            : DateFormat('MMM d, y')
                                .format(widget.comment!.dateCommented!),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const Text("User not found");
          }
        });
  }

  Widget _buildProgressIndicator(double cardWidth) {
    if (widget.largeProfilePhoto == true) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
                  height: 64,
                  width: 64,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)))
              .asGlass(
            tintColor: Palette.lightPurple,
            clipBorderRadius: BorderRadius.circular(100),
            blurX: 3,
            blurY: 3,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Shimmer.fromColors(
                baseColor: Palette.lightPurple,
                highlightColor: Palette.white,
                child: Container(
                  constraints: BoxConstraints(maxWidth: cardWidth * 0.3),
                  child: const SizedBox(
                    width: 150,
                    height: 15,
                  ).asGlass(),
                ).asGlass(
                    clipBorderRadius: BorderRadius.circular(4),
                    tintColor: Palette.lightPurple),
              ),
              const SizedBox(height: 8),
              Shimmer.fromColors(
                baseColor: Palette.lightPurple,
                highlightColor: Palette.white,
                child: SizedBox(
                  width: cardWidth * 0.25,
                  height: 10,
                ).asGlass(
                  clipBorderRadius: BorderRadius.circular(3),
                  tintColor: Palette.lightPurple,
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
                height: 32,
                width: 32,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)))
            .asGlass(
          tintColor: Palette.lightPurple,
          clipBorderRadius: BorderRadius.circular(100),
          blurX: 3,
          blurY: 3,
        ),
        const SizedBox(width: 5),
        Shimmer.fromColors(
          baseColor: Palette.lightPurple,
          highlightColor: Palette.white,
          child: Container(
            constraints: BoxConstraints(maxWidth: cardWidth * 0.3),
            child: const SizedBox(
              width: 150,
              height: 12,
            ).asGlass(),
          ).asGlass(
              clipBorderRadius: BorderRadius.circular(4),
              tintColor: Palette.lightPurple),
        ),
      ],
    );
  }

  Widget _buildPopupMenu(dynamic object) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palette.darkPurple.withOpacity(0.8),
      ),
      child: PopupMenuButton<String>(
        tooltip: "Actions",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
        ),
        icon: const Icon(Icons.more_horiz_rounded),
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
              title: const Text('Delete',
                  style: TextStyle(color: Palette.lightRed)),
              onTap: () {
                Navigator.pop(context);
                showConfirmationDialog(
                    context,
                    const Icon(Icons.warning_rounded,
                        color: Palette.lightRed, size: 55),
                    (widget.post != null)
                        ? const Text(
                            "Are you sure you want to delete this post?",
                            textAlign: TextAlign.center,
                          )
                        : const Text(
                            "Are you sure you want to delete this comment?",
                            textAlign: TextAlign.center,
                          ), () async {
                  try {
                    if (widget.post != null) {
                      await _postProvider.delete((object as Post).id!);
                    } else {
                      await _commentProvider.delete((object as Comment).id!);
                    }
                  } on Exception catch (e) {
                    showErrorDialog(context, e);
                  }
                });
              },
            ),
          ),
        ],
      ),
    ).asGlass(
      blurX: 1,
      blurY: 1,
      clipBorderRadius: BorderRadius.circular(20),
      tintColor: Palette.darkPurple,
    );
  }

  Widget _showPopup() {
    if (widget.post != null && widget.post!.userId == LoggedUser.user!.id) {
      return Container(child: _buildPopupMenu(widget.post));
    } else if (widget.comment != null &&
        widget.comment!.userId == LoggedUser.user!.id) {
      return Container(child: _buildPopupMenu(widget.comment));
    }

    return Text("");
  }
}
