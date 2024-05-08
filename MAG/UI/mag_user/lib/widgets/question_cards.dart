import 'package:flutter/material.dart';

import '../models/qa.dart';
import '../models/search_result.dart';

typedef FetchPage = Future<SearchResult<QA>> Function(
    Map<String, dynamic> filter);

class QuestionCards extends StatefulWidget {
  final Future<SearchResult<QA>> Function() fetchQA;
  final Future<Map<String, dynamic>> Function()? getFilter;
  final FetchPage fetchPage;
  Map<String, dynamic> filter;
  int page;
  int pageSize;

  QuestionCards({
    Key? key,
    required this.fetchQA,
    required this.getFilter,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  State<QuestionCards> createState() => _QuestionCardsState();
}

class _QuestionCardsState extends State<QuestionCards> {
  late Future<SearchResult<QA>> _QAFuture;
  final ScrollController _scrollController = ScrollController();

  int totalItems = 0;

  @override
  void initState() {
    _QAFuture = widget.fetchQA();

    setTotalItems();

    super.initState();
  }

  void setTotalItems() async {
    var QAResult = await _QAFuture;
    if (mounted) {
      setState(() {
        totalItems = QAResult.count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("Card");
  }
}
