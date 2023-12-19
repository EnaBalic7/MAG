import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/screens/club_detail_screen.dart';
import 'package:mag_admin/widgets/gradient_button.dart';
import 'package:mag_admin/widgets/master_screen.dart';

import '../utils/colors.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Center(
        child: Column(
          children: [
            GradientButton(
              width: 100,
              height: 50,
              child: Text("Black Clover"),
              borderRadius: 50,
              gradient: Palette.buttonGradient,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClubDetailScreen(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
