import 'package:flutter/material.dart';
import 'package:mag_admin/widgets/master_screen.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Center(
        child: Column(
          children: [
            Text("Anime cards"),
          ],
        ),
      ),
      title_widget: Text("Anime"),
    );
  }
}
