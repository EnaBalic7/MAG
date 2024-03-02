import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mag_user/models/club.dart';
import 'package:mag_user/providers/genre_provider.dart';
import 'package:mag_user/utils/icons.dart';
import 'package:mag_user/widgets/master_screen.dart';
import 'package:orientation/orientation.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/anime.dart';
import '../models/genre.dart';
import '../models/search_result.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/gradient_button.dart';

class AnimeDetailScreen extends StatefulWidget {
  Anime anime;
  final int selectedIndex;
  AnimeDetailScreen(
      {Key? key, required this.selectedIndex, required this.anime})
      : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  late GenreProvider _genreProvider;
  late Future<SearchResult<Genre>> _genreFuture;
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    _genreProvider = context.read<GenreProvider>();
    _genreFuture = _genreProvider.get(filter: {"SortAlphabetically": "true"});

    String videoLink = "${widget.anime.trailerUrl}";
    String videoId = extractVideoId(videoLink);

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    // Locks orientation to landscape when entering full-screen
    _youtubePlayerController.addListener(() {
      if (_youtubePlayerController.value.isFullScreen) {
        OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double? imgWidth = screenSize.width * 0.7;

    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: false,
        showBackArrow: true,
        title: "Anime details",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Palette.lightPurple.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.anime.imageUrl!,
                        width: imgWidth,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("${widget.anime.titleEn}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                _buildGenres(),
                _buildDetails(),
                _buildSynopsis(),
                _buildTrailer(),
              ],
            ),
          ),
        ));
  }

  Widget _buildTrailer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: YoutubePlayer(
            controller: _youtubePlayerController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSynopsis() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
        bottom: 20,
      ),
      child: Text(
        "${widget.anime.synopsis}",
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Score",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildStarIcon(16),
                      Text(widget.anime.score.toString(),
                          style: const TextStyle(color: Palette.starYellow))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Episodes",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.anime.episodesNumber.toString(),
                      style: const TextStyle(color: Palette.lightPurple))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Studio",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.anime.studio!,
                      style: const TextStyle(color: Palette.lightPurple))
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Japanese",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.anime.titleJp!,
                      style: const TextStyle(color: Palette.lightPurple))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Season",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${widget.anime.season!} ${widget.anime.beginAir!.year}",
                      style: const TextStyle(color: Palette.lightPurple))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Aired",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "${DateFormat('MMM d, y').format(widget.anime.beginAir!)} - ${DateFormat('MMM d, y').format(widget.anime.finishAir!)}",
                      style: const TextStyle(color: Palette.lightPurple))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenres() {
    return FutureBuilder<SearchResult<Genre>>(
        future: _genreFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              height: 10,
              width: 10,
              strokeWidth: 2,
            ); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully
            var genreList = snapshot.data!;

            List<int> animeGenreIDs = widget.anime.genreAnimes!
                .map((genreAnime) => genreAnime.genreId!)
                .toList();

            List<String> animeGenres = genreList.result
                .where((genre) => animeGenreIDs.contains(genre.id))
                .map((genre) => genre.name!)
                .toList();

            return Wrap(
              spacing: 8,
              children: animeGenres.map((e) {
                return GradientButton(
                  contentPaddingBottom: 3,
                  contentPaddingLeft: 8,
                  contentPaddingRight: 8,
                  contentPaddingTop: 3,
                  gradient: Palette.navGradient4,
                  borderRadius: 50,
                  child: Text(e,
                      style: const TextStyle(color: Palette.lightPurple)),
                );
              }).toList(),
            );
          }
        });
  }
}
