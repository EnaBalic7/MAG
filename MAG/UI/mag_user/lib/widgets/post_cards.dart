import 'package:flutter/material.dart';
import 'package:mag_user/providers/post_provider.dart';
import 'package:mag_user/widgets/pagination_buttons.dart';
import 'package:mag_user/widgets/content_card.dart';
import 'package:mag_user/widgets/content_indicator.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../utils/util.dart';

typedef FetchPage = Future<SearchResult<Post>> Function(
    Map<String, dynamic> filter);

class PostCards extends StatefulWidget {
  final int selectedIndex;
  final Future<SearchResult<Post>> Function() fetchPosts;
  Map<String, dynamic> filter;
  final FetchPage fetchPage;
  int page;
  int pageSize;

  PostCards({
    Key? key,
    required this.selectedIndex,
    required this.fetchPosts,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  State<PostCards> createState() => _PostCardsState();
}

class _PostCardsState extends State<PostCards> {
  late Future<SearchResult<Post>> _postFuture;
  final ScrollController _scrollController = ScrollController();
  late final PostProvider _postProvider;

  int totalItems = 0;

  @override
  void initState() {
    _postFuture = widget.fetchPosts();
    _postProvider = context.read<PostProvider>();

    setTotalItems();

    _postProvider.addListener(() {
      setTotalItems();
    });

    super.initState();
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
    return FutureBuilder<SearchResult<Post>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: List.generate(6, (_) => const ContentIndicator()),
                ),
              ),
            );
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var postList = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildPostCards(postList),
                    ),
                    MyPaginationButtons(
                      page: widget.page,
                      pageSize: widget.pageSize,
                      totalItems: totalItems,
                      fetchPage: fetchPage,
                      hasSearch: false,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<void> fetchPage(int requestedPage) async {
    try {
      var result = await widget.fetchPage({
        ...widget.filter,
        "Page": "$requestedPage",
        "PageSize": "${widget.pageSize}",
      });

      if (mounted) {
        setState(() {
          _postFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildPostCards(List<Post> postList) {
    return List.generate(
        postList.length, (index) => ContentCard(post: postList[index]));
  }
}
