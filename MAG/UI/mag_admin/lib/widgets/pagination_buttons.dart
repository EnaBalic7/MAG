import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';

class MyPaginationButtons extends StatefulWidget {
  int page;
  int pageSize;
  int totalItems;
  Future<void> Function(int) fetchPage;
  MyPaginationButtons({
    Key? key,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.fetchPage,
  }) : super(key: key);

  @override
  State<MyPaginationButtons> createState() => _MyPaginationButtonsState();
}

class _MyPaginationButtonsState extends State<MyPaginationButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.totalItems > 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: widget.page > 0
                        ? () => widget.fetchPage(widget.page - 1)
                        : null,
                    child: Icon(Icons.arrow_back_ios_rounded),
                  ),
                ),
                Text(
                    'Page ${widget.page + 1} of ${(widget.totalItems / widget.pageSize).ceil()}'),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: widget.page + 1 ==
                            (widget.totalItems / widget.pageSize).ceil()
                        ? null
                        : () => widget.fetchPage(widget.page + 1),
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: widget.totalItems <= 0,
            child: Stack(
              children: [
                Positioned(
                  //top: 100,
                  // left: 50,
                  child: Text(
                    "No results found.",
                    style: TextStyle(
                        fontSize: 25,
                        color: Palette.lightPurple.withOpacity(0.6)),
                  ),
                ),
                /*Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      "assets/images/starFrame.png",
                      width: 300,
                    )),*/
              ],
            )),
      ],
    );
  }
}
