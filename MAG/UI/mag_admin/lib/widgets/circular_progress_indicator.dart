import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Palette.lightPurple.withOpacity(0.7),
    );
  }
}
