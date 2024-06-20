import 'package:flutter/material.dart';
import 'package:mag_user/providers/user_post_action_provider.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../models/post.dart';
import '../providers/comment_provider.dart';
import '../providers/post_provider.dart';
import '../utils/colors.dart';

class LikeDislikeButton extends StatefulWidget {
  final Post? post;
  final Comment? comment;

  const LikeDislikeButton({
    Key? key,
    this.post,
    this.comment,
  })  : assert(post != null || comment != null,
            "Either post or comment must be provided."),
        assert(!(post != null && comment != null),
            "Only one of post or comment can be provided."),
        super(key: key);

  @override
  State<LikeDislikeButton> createState() => _LikeDislikeButtonState();
}

class _LikeDislikeButtonState extends State<LikeDislikeButton> {
  String userAction = 'none';

  late Post post;
  late final PostProvider _postProvider;
  late final UserPostActionProvider _userPostActionProvider;

  late Comment comment;
  late final CommentProvider _commentProvider;
  // Must implement UserCommentActionProvider
  // late final UserCommentActionProvider _userCommentActionProvider;

  @override
  void initState() {
    if (widget.post != null) {
      post = widget.post!;
    } else {
      comment = widget.comment!;
    }

    _postProvider = context.read<PostProvider>();
    _userPostActionProvider = context.read<UserPostActionProvider>();
    _loadUserAction();

    super.initState();
  }

  void _loadUserAction() async {
    String? action;
    if (widget.post != null) {
      action = await _userPostActionProvider.getUserAction(widget.post!.id!);
    } else {
      // Implement _userCommentActionProvider
      //  action = await _userCommentActionProvider.getUserAction(widget.comment!.id!);
    }

    setState(() {
      userAction = action ?? 'none';
    });
  }

  void _toggleLike() async {
    if (widget.post != null) {
      await _postProvider.toggleLike(post);
    } else {
      // Implement toggleLike in CommentProvider
      //  await _commentProvider.toggleLike(comment);
    }

    _loadUserAction();
  }

  void _toggleDislike() async {
    if (widget.post != null) {
      await _postProvider.toggleDislike(post);
    } else {
      // Implement toggleDislike in CommentProvider
      //  await _commentProvider.toggleDislike(comment);
    }
    _loadUserAction();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: _toggleLike,
              child: Icon(
                userAction == 'like'
                    ? Icons.thumb_up_rounded
                    : Icons.thumb_up_off_alt,
                color: userAction == 'like'
                    ? Palette.turquoiseLight
                    : Palette.lightPurple,
              ),
            ),
            const SizedBox(width: 5),
            (widget.post != null)
                ? Text("${post.likesCount}")
                : Text("${comment.likesCount}"),
          ],
        ),
        const SizedBox(width: 25),
        Row(
          children: [
            GestureDetector(
              onTap: _toggleDislike,
              child: Icon(
                userAction == 'dislike'
                    ? Icons.thumb_down_rounded
                    : Icons.thumb_down_off_alt,
                color: userAction == 'dislike'
                    ? Palette.lightRed
                    : Palette.lightPurple,
              ),
            ),
            const SizedBox(width: 5),
            (widget.post != null)
                ? Text("${post.dislikesCount}")
                : Text("${comment.dislikesCount}"),
          ],
        ),
      ],
    );
  }
}
