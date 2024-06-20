import 'package:flutter/material.dart';
import 'package:mag_user/providers/user_post_action_provider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../providers/post_provider.dart';
import '../utils/colors.dart';

class LikeDislikeButton extends StatefulWidget {
  final Post post;
  const LikeDislikeButton({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<LikeDislikeButton> createState() => _LikeDislikeButtonState();
}

class _LikeDislikeButtonState extends State<LikeDislikeButton> {
  late Post post;
  String userAction = 'none';
  late final PostProvider _postProvider;
  late final UserPostActionProvider _userPostActionProvider;

  @override
  void initState() {
    post = widget.post;
    _postProvider = context.read<PostProvider>();
    _userPostActionProvider = context.read<UserPostActionProvider>();
    _loadUserAction();

    super.initState();
  }

  void _loadUserAction() async {
    String? action =
        await _userPostActionProvider.getUserAction(widget.post.id!);
    setState(() {
      userAction = action ?? 'none';
    });
  }

  void _toggleLike() async {
    await _postProvider.toggleLike(post);
    _loadUserAction();
  }

  void _toggleDislike() async {
    await _postProvider.toggleDislike(post);
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
                userAction == 'like' ? Icons.thumb_up : Icons.thumb_up_off_alt,
                color: userAction == 'like'
                    ? Palette.turquoiseLight
                    : Palette.lightPurple,
              ),
            ),
            const SizedBox(width: 5),
            Text("${post.likesCount}"),
          ],
        ),
        const SizedBox(width: 25),
        Row(
          children: [
            GestureDetector(
              onTap: _toggleDislike,
              child: Icon(
                userAction == 'dislike'
                    ? Icons.thumb_down
                    : Icons.thumb_down_off_alt,
                color: userAction == 'dislike'
                    ? Palette.lightRed
                    : Palette.lightPurple,
              ),
            ),
            const SizedBox(width: 5),
            Text("${post.dislikesCount}"),
          ],
        ),
      ],
    );
  }
}
