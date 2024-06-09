import 'package:flutter/material.dart';

import '../models/post.dart';

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
  int _likes = 0;
  int _dislikes = 0;

  @override
  void initState() {
    _likes = widget.post.likesCount!;
    _dislikes = widget.post.dislikesCount!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(Icons.thumb_up_rounded),
            const SizedBox(width: 5),
            Text("$_likes"),
          ],
        ),
        const SizedBox(width: 25),
        Row(
          children: [
            const Icon(Icons.thumb_down_rounded),
            const SizedBox(width: 5),
            Text("$_dislikes"),
          ],
        ),
      ],
    );
  }
}
