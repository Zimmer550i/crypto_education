import 'package:crypto_education/utils/custom_flick_landscape_controls.dart';
import 'package:crypto_education/utils/custom_flick_portrait_controls.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;
  double progress = 0.40;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://www.w3schools.com/html/mov_bbb.mp4'),
      // Uri.parse('https://mail.google.com/mail/u/0/#inbox'),
    );
    flickManager = FlickManager(videoPlayerController: _controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: flickManager,
      flickVideoWithControls: FlickVideoWithControls(
        controls: CustomFlickPortraitControls(),
      ),
      flickVideoWithControlsFullscreen: FlickVideoWithControls(
        videoFit: BoxFit.contain,
        controls: CustomFlickLandscapeControls(),
      ),
    );
  }
}
