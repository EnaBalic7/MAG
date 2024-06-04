import 'package:flutter/material.dart';

import '../models/post.dart';
import '../utils/colors.dart';

class PostCard extends StatefulWidget {
  final Post? post;
  const PostCard({Key? key, this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.95;
    double? cardHeight = screenSize.height * 0.2;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
        color: Palette.darkPurple,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile pic & username"),
              Text("date posted"),
            ],
          ),
          SizedBox(
            width: cardWidth,
            child: Text(
                "Profile pic & username  mainAxisAlignment: MainAxisAlignment.spaceBetween,  mainAxisAlignment: MainAxisAlignment.spaceBetween,  mainAxisAlignment: MainAxisAlignment.spaceBetween,",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ]),
      ),
    );
  }
}
