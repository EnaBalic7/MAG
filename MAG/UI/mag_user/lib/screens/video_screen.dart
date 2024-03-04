import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/colors.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;
  ValueNotifier<int> playbackPosition;
  late ValueNotifier<bool> isPlaying;

  VideoScreen({
    Key? key,
    required this.videoId,
    required this.playbackPosition,
    required this.isPlaying,
  }) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController controller;
  late Timer _progressTimer;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.isPlaying.value,
        startAt: widget.playbackPosition.value,
      ),
    );

    _progressTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateVideoProgress();
    });

    super.initState();
  }

  void updateVideoProgress() {
    widget.playbackPosition.value = controller.value.position.inSeconds;
    widget.isPlaying.value = controller.value.isPlaying;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
            RemainingDuration(),
            GestureDetector(
                onTap: () {
                  _leaveFullScreen();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Icon(Icons.fullscreen_exit_rounded,
                      color: Palette.white, size: 36),
                ))
          ],
        ),
      ),
    );
  }

  void _leaveFullScreen() {
    controller.pause();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Navigator.of(context)
        .pop([controller.value.position.inSeconds, controller.value.isPlaying]);
  }

  @override
  void dispose() {
    controller.dispose();
    _progressTimer.cancel();
    super.dispose();
  }
}
