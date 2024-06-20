import 'package:flutter/material.dart';
import 'package:mag_user/models/comment.dart';
import 'package:mag_user/providers/comment_provider.dart';
import 'package:mag_user/widgets/comment_cards.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late final CommentProvider _commentProvider;

  int page = 0;
  int pageSize = 20;

  Map<String, dynamic> _filter = {};

  @override
  void initState() {
    _commentProvider = context.read<CommentProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      showBackArrow: true,
      showNavBar: false,
      title: "Post",
      showProfileIcon: false,
      child: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Text("Top Part"),
            CommentCards(
                fetchComments: fetchComments,
                fetchPage: fetchPage,
                filter: _filter,
                page: page,
                pageSize: pageSize)
          ]),
        ),
      ),
    );
  }

  Future<SearchResult<Comment>> fetchComments() {
    return _commentProvider.get(filter: {
      ..._filter,
      "Page": "$page",
      "PageSize": "$pageSize",
    });
  }

  Future<SearchResult<Comment>> fetchPage(Map<String, dynamic> filter) {
    return _commentProvider.get(filter: filter);
  }
}
