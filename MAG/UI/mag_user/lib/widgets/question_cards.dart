import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:mag_user/widgets/pagination_buttons.dart';
import 'package:shimmer/shimmer.dart';

import '../models/qa.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../utils/util.dart';
import 'gradient_button.dart';

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
    this.getFilter,
    required this.fetchPage,
    required this.filter,
    required this.page,
    required this.pageSize,
  }) : super(key: key);

  @override
  State<QuestionCards> createState() => _QuestionCardsState();
}

class _QuestionCardsState extends State<QuestionCards> {
  late Future<SearchResult<QA>> _qAFuture;
  final ScrollController _scrollController = ScrollController();

  int totalItems = 0;

  @override
  void initState() {
    _qAFuture = widget.fetchQA();

    setTotalItems();

    super.initState();
  }

  void setTotalItems() async {
    var qAResult = await _qAFuture;
    if (mounted) {
      setState(() {
        totalItems = qAResult.count;
      });
    }
  }

  Future<SearchResult<QA>> _loadDataForever() {
    return Future.delayed(Duration(milliseconds: 500), () {})
        .then((_) => _loadDataForever());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult<QA>>(
        future: _qAFuture,
        // future: _loadDataForever(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Center(
                child: Wrap(
                  children: List.generate(6, (_) => _buildQAIndicator()),
                ),
              ),
            );
            // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var qAList = snapshot.data!.result;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      children: _buildQACards(qAList),
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
          _qAFuture = Future.value(result);
          widget.page = requestedPage;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e);
    }
  }

  List<Widget> _buildQACards(List<QA> qAList) {
    return List.generate(
      qAList.length,
      (index) => _buildQACard(qAList[index]),
    );
  }

  Widget _buildQACard(QA qa) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 5,
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Palette.textFieldPurple.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(qa.question.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 23),
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: _buildPopupMenu(qa),
                  ),
                )
              ],
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientButton(
                      contentPaddingLeft: 5,
                      contentPaddingRight: 5,
                      contentPaddingBottom: 1,
                      contentPaddingTop: 0,
                      borderRadius: 50,
                      gradient: Palette.navGradient4,
                      child: Text(
                        qa.category!.name.toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Palette.lightPurple,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                qa.answer.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ]),
        ),
      ).asGlass(
        blurX: 5,
        blurY: 5,
        tintColor: Palette.buttonPurple,
        clipBorderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildQAIndicator() {
    Size screenSize = MediaQuery.of(context).size;
    double containerWidth = screenSize.width;
    double containerHeight = screenSize.height * 0.15;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 5,
      ),
      child: Container(
        height: containerHeight,
        width: containerWidth,
        constraints: const BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Palette.textFieldPurple.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Palette.lightPurple,
                  highlightColor: Palette.white,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: containerWidth * 0.6),
                    child: Container(
                      width: 200,
                      height: 12,
                    ).asGlass(),
                  ).asGlass(
                      clipBorderRadius: BorderRadius.circular(4),
                      tintColor: Palette.lightPurple),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Shimmer.fromColors(
                      baseColor: Palette.lightPurple,
                      highlightColor: Palette.white,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: containerWidth),
                        height: 11,
                      ).asGlass(
                        clipBorderRadius: BorderRadius.circular(3),
                        tintColor: Palette.lightPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ).asGlass(
        blurX: 5,
        blurY: 5,
        tintColor: Palette.buttonPurple,
        clipBorderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildPopupMenu(QA qa) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palette.darkPurple.withOpacity(0.5),
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
        color: Palette.popupMenu,
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
                    const Text(
                      "Are you sure you want to delete this question?",
                      textAlign: TextAlign.center,
                    ), () async {
                  //  await _qAProvider.delete(qa.id!);
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
}
