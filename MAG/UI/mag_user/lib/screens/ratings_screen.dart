import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../widgets/master_screen.dart';

class RatingsScreen extends StatefulWidget {
  final Anime anime;
  const RatingsScreen({Key? key, required this.anime}) : super(key: key);

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        showBackArrow: true,
        showSearch: false,
        showProfileIcon: false,
        showNavBar: false,
        title: "Reviews",
        child: _buildReviews());
  }

  Widget _buildReviews() {
    return Text("");
  }
}
