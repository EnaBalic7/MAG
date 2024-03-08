import 'package:flutter/material.dart';

class NebulaCards extends StatefulWidget {
  const NebulaCards({Key? key}) : super(key: key);

  @override
  State<NebulaCards> createState() => _NebulaCardsState();
}

class _NebulaCardsState extends State<NebulaCards>
    with AutomaticKeepAliveClientMixin<NebulaCards> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
