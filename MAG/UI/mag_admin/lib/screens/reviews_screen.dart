import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mag_admin/providers/anime_provider.dart';
import 'package:mag_admin/providers/rating_provider.dart';
import 'package:mag_admin/utils/icons.dart';
import 'package:mag_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../models/anime.dart';
import '../models/rating.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import 'anime_detail_screen.dart';

class ReviewsScreen extends StatefulWidget {
  User user;

  ReviewsScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late RatingProvider _ratingProvider;
  late AnimeProvider _animeProvider;

  @override
  void initState() {
    _ratingProvider = context.read<RatingProvider>();
    _animeProvider = context.read<AnimeProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Row(
        children: [
          widget.user.profilePicture!.profilePicture != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    imageFromBase64String(
                        widget.user.profilePicture!.profilePicture!),
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(""),
          SizedBox(width: 5),
          widget.user != null ? Text("${widget.user.username}: ") : Text(""),
          SizedBox(width: 5),
          Text("Reviews"),
          SizedBox(width: 5),
          buildStarTrailIcon(24),
        ],
      ),
      showBackArrow: true,
      child: FutureBuilder<SearchResult<Rating>>(
        future: _ratingProvider.get(filter: {"UserId": "${widget.user.id}"}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var ratingList = snapshot.data!.result;
            return SingleChildScrollView(
              child: Center(
                child: Wrap(
                  children: _buildReviewCards(ratingList),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildReviewCards(List<Rating> ratingList) {
    return List.generate(
      ratingList.length,
      (index) => _buildReviewCard(ratingList[index]),
    );
  }

  Widget _buildReviewCard(Rating rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, right: 20, top: 20),
      child: Container(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
        height: 194,
        width: 600,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Palette.darkPurple),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            imageFromBase64String(
                                widget.user.profilePicture!.profilePicture!),
                            width: 43,
                            height: 43,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${widget.user.firstName} ${widget.user.lastName}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          FutureBuilder<SearchResult<Anime>>(
                              future: _animeProvider.get(filter: {
                                "Id": "${rating.animeId!}",
                                "GenresIncluded": "True"
                              }),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Loading state
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Error: ${snapshot.error}'); // Error state
                                } else {
                                  // Data loaded successfully

                                  Anime? tmp = snapshot.data?.result.single;
                                  if (tmp != null) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AnimeDetailScreen(anime: tmp),
                                          ),
                                        );
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Text("${tmp.titleEn}"),
                                      ),
                                    );
                                  } else {
                                    return Text("Anime not found");
                                  }
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildStarIcon(15),
                    SizedBox(width: 3),
                    Text("${rating.ratingValue.toString()}/10",
                        style:
                            TextStyle(color: Palette.starYellow, fontSize: 13)),
                  ],
                ),
                _buildPopupMenu()
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.topLeft,
                constraints: BoxConstraints(minHeight: 30, maxHeight: 100),
                //height: 100,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Text(
                        "${rating.reviewText}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  ConstrainedBox _buildPopupMenu() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 23),
      child: Container(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            PopupMenuButton<String>(
              tooltip: "More actions",
              offset: Offset(195, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Palette.lightPurple.withOpacity(0.3)),
              ),
              icon: Icon(Icons.more_vert_rounded),
              splashRadius: 1,
              padding: EdgeInsets.zero,
              color: Color.fromRGBO(50, 48, 90, 1),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    hoverColor: Palette.lightRed.withOpacity(0.1),
                    leading: buildTrashIcon(24),
                    title: Text('Delete',
                        style: TextStyle(color: Palette.lightRed)),
                    subtitle: Text('Delete permanently',
                        style: TextStyle(
                            color: Palette.lightRed.withOpacity(0.5))),
                    onTap: () async {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
