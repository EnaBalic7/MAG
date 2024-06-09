import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mag_user/providers/user_provider.dart';
import 'package:mag_user/widgets/like_dislike_button.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import 'anime_indicator.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final UserProvider _userProvider;
  late Future<SearchResult<User>> _userFuture;

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _userFuture = _userProvider.get(filter: {
      "Id": "${widget.post.userId}",
      "ProfilePictureIncluded": "true"
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double? cardWidth = screenSize.width * 0.95;
    double? cardHeight = screenSize.height * 0.2;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
          color: Palette.darkPurple,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildUsername(),
                          Text(DateFormat('MMM d, y')
                              .format(widget.post.datePosted!)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: Text(widget.post.content!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                LikeDislikeButton(post: widget.post),
              ]),
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return FutureBuilder<SearchResult<User>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  //Implement proper post indicator
                  children: List.generate(6, (_) => const AnimeIndicator()),
                ),
              ),
            );
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var user = snapshot.data!;
            if (user.count == 1) {
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
            }
            return Text("");
          }
        });
  }
}
