import 'package:flutter/material.dart';
import 'package:mag_admin/utils/icons.dart';
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
            Row(
              children: [
                Container(
                    width: 265,
                    height: 403,
                    child: Column(
                      children: [
                        Image.network(
                          "https://wallpapers.com/images/hd/anime-girl-background-bs0kczie5vqucxqj.jpg",
                          width: 265,
                          height: 224,
                        )
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
      title_widget: Text("Anime"),
    );
  }
}
