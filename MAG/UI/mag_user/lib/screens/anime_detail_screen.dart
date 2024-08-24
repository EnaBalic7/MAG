import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass/glass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/genre_provider.dart';
import '../providers/rating_provider.dart';
import '../screens/ratings_screen.dart';
import '../screens/video_screen.dart';
import '../utils/icons.dart';
import '../widgets/master_screen.dart';
import '../widgets/separator.dart';
import '../models/anime.dart';
import '../models/genre.dart';
import '../models/rating.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../utils/util.dart';
import '../widgets/circular_progress_indicator.dart';
import '../widgets/gradient_button.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Anime anime;
  final int selectedIndex;

  const AnimeDetailScreen(
      {super.key, required this.selectedIndex, required this.anime});

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  late GenreProvider _genreProvider;
  late Future<SearchResult<Genre>> _genreFuture;
  late YoutubePlayerController _youtubePlayerController;
  late ValueNotifier<int> playbackPosition;
  late ValueNotifier<bool> isPlaying;
  late RatingProvider _ratingProvider;
  late Future<SearchResult<Rating>> _ratingFuture;
  late UserProvider _userProvider;

  @override
  void initState() {
    _genreProvider = context.read<GenreProvider>();
    _genreFuture = _genreProvider.get(filter: {"SortAlphabetically": "true"});

    _userProvider = context.read<UserProvider>();

    _ratingProvider = context.read<RatingProvider>();
    _ratingFuture = _ratingProvider.get(filter: {
      "AnimeId": "${widget.anime.id}",
      "NewestFirst": "true",
      "TakeItems": 1
    });

    String videoLink = "${widget.anime.trailerUrl}";
    String videoId = extractVideoId(videoLink);

    playbackPosition = ValueNotifier<int>(0);
    isPlaying = ValueNotifier<bool>(false);

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: isPlaying.value,
      ),
    );

    // When entering fullscreen playback continues from where it left off
    _youtubePlayerController.addListener(updateVideoProgress);

    super.initState();
  }

  void _updatePlaybackStatus(int position, bool isPlaying) {
    setState(() {
      playbackPosition.value = position;
      this.isPlaying.value = isPlaying;
    });
  }

  void updateVideoProgress() {
    playbackPosition.value = _youtubePlayerController.value.position.inSeconds;
    isPlaying.value = _youtubePlayerController.value.isPlaying;
  }

  DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.contains("0001-01-01")) {
      return null;
    }
    return DateTime.tryParse(dateString);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double? imgWidth = screenSize.width * 0.7;

    return MasterScreenWidget(
        selectedIndex: widget.selectedIndex,
        showNavBar: false,
        showProfileIcon: false,
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
                    child: (widget.anime.imageUrl != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.anime.imageUrl!,
                              width: imgWidth,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Text("${widget.anime.titleEn}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                _buildGenres(),
                _buildDetails(),
                _buildSynopsis(),
                _buildTrailer(),
                MySeparator(
                  width: MediaQuery.of(context).size.width * 0.8,
                  paddingTop: 20,
                  paddingBottom: 10,
                  borderRadius: 50,
                  opacity: 0.8,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text("Reviews",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                ),
                _buildRating(),
              ],
            ),
          ),
        ));
  }

  Widget _buildSeeMoreRatings() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RatingsScreen(anime: widget.anime)));
        },
        child: const Text("See more",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
      ),
    );
  }

  Widget _buildRating() {
    return FutureBuilder<SearchResult<Rating>>(
        future: _ratingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(); // Loading state
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Error state
          } else {
            // Data loaded successfully

            Rating? rating;
            if (snapshot.data!.result.isNotEmpty) {
              rating = snapshot.data!.result.single;
            }

            return _buildReviewCard(rating);
          }
        });
  }

  Widget _buildReviewCard(Rating? rating) {
    if (rating == null) {
      return Text("No reviews yet",
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Palette.lightPurple.withOpacity(0.5)));
    }

    final Size screenSize = MediaQuery.of(context).size;
    double? ratingHeight =
        rating.reviewText != "" ? screenSize.width * 0.45 : 42;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
            child: Container(
              constraints: const BoxConstraints(
                // minHeight: 100,
                maxHeight: 200,
                minWidth: 315,
              ),
              height: ratingHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.lightPurple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(15),
                color: Palette.darkPurple.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      buildStarIcon(15),
                                      const SizedBox(width: 3),
                                      Text(
                                        "${rating.ratingValue.toString()}/10",
                                        style: const TextStyle(
                                          color: Palette.starYellow,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Text(" by"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildUsername(rating),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('MMM d, y').format(
                            rating.dateAdded!,
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: rating.reviewText != "",
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: Text(
                              "${rating.reviewText}",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).asGlass(
                blurX: 5,
                blurY: 5,
                tintColor: Palette.darkPurple,
                clipBorderRadius: BorderRadius.circular(15)),
          ),
          _buildSeeMoreRatings(),
        ],
      ),
    );
  }

  Widget _buildUsername(Rating rating) {
    return FutureBuilder<SearchResult<User>>(
        future: _userProvider.get(filter: {"Id": "${rating.userId}"}),
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
            User? user;
            if (snapshot.data!.result.isNotEmpty) {
              user = snapshot.data!.result.single;
            }

            return (user != null)
                ? Container(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Text("${user.username}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  )
                : const Text("");
          }
        });
  }

  Widget _buildTrailer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Visibility(
      visible: widget.anime.trailerUrl != null && widget.anime.trailerUrl != "",
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Trailer",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ValueListenableBuilder<int>(
                  valueListenable: playbackPosition,
                  builder: (context, position, _) {
                    //print("Playback position: $position");
                    // Widget tree that depends on playbackPosition
                    return YoutubePlayer(
                      width: screenSize.width,
                      controller: _youtubePlayerController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                      bottomActions: [
                        const CurrentPosition(),
                        const ProgressBar(
                          isExpanded: true,
                          colors: ProgressBarColors(
                            playedColor: Colors.red,
                            handleColor: Colors.redAccent,
                          ),
                        ),
                        const RemainingDuration(),
                        GestureDetector(
                            onTap: () {
                              _youtubePlayerController.pause();
                              _enterFullScreen();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.fullscreen_rounded,
                                  color: Palette.white, size: 30),
                            ))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enterFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    String videoLink = "${widget.anime.trailerUrl}";

    // Using custom method
    //  String videoId = extractVideoId(videoLink);

    // Using method from package:
    String videoId = YoutubePlayer.convertUrlToId(videoLink) ?? "";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoScreen(
                  videoId: videoId,
                  playbackPosition: playbackPosition,
                  isPlaying: isPlaying,
                  updatePlaybackStatus: _updatePlaybackStatus,
                ))).then((value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      _youtubePlayerController.seekTo(Duration(seconds: value[0]));

      if (value[1] == true) {
        _youtubePlayerController.play();
      } else if (value[1] == false) {
        _youtubePlayerController.pause();
      }
    });
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    playbackPosition.dispose();

    super.dispose();
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(widget.anime.studio!,
                        style: const TextStyle(color: Palette.lightPurple)),
                  )
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Text(widget.anime.titleJp!,
                        style: const TextStyle(color: Palette.lightPurple)),
                  )
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
                  Text(
                      "${widget.anime.season!} ${parseDate(widget.anime.beginAir!.toIso8601String())?.year ?? ""}",
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
                  _buildAired()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text _buildAired() {
    DateTime? begin = parseDate(widget.anime.beginAir!.toIso8601String());
    DateTime? finish = parseDate(widget.anime.finishAir!.toIso8601String());

    return Text(
        "${(begin != null) ? DateFormat('MMM d, y').format(widget.anime.beginAir!) : ""} - ${(finish != null) ? DateFormat('MMM d, y').format(widget.anime.finishAir!) : ""}",
        style: const TextStyle(color: Palette.lightPurple));
  }

  Widget _buildGenres() {
    return FutureBuilder<SearchResult<Genre>>(
        future: _genreFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyProgressIndicator(
              height: 48,
              width: 48,
              strokeWidth: 4,
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
