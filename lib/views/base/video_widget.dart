import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/custom_flick_landscape_controls.dart';
import 'package:crypto_education/utils/custom_flick_portrait_controls.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget(this.url, {super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;

  /*
  Bug: When the video pauses when load buffers there is no loading animation.
  */

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    flickManager = FlickManager(videoPlayerController: _controller);
    _controller.addListener(() {
      if (_controller.value.hasError) {
        debugPrint('❌ Error: ${_controller.value.errorDescription}');
        debugPrint('Controller value: ${_controller.value}');
        setState(() {
          
        });
      }
    });
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
        playerLoadingFallback: Stack(
          children: [
            Center(child: CircularProgressIndicator(color: AppColors.cyan)),
            Positioned(
              top: 12,
              left: 20,
              child: FlickAutoHideChild(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Color(0xff1b1b1b).withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: CustomSvg(asset: AppIcons.arrowLeft)),
                  ),
                ),
              ),
            ),
          ],
        ),
        playerErrorFallback: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_controller.value.errorDescription ?? ""),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 20,
              child: FlickAutoHideChild(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Color(0xff1b1b1b).withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: CustomSvg(asset: AppIcons.arrowLeft)),
                  ),
                ),
              ),
            ),
          ],
        ),
        controls: CustomFlickPortraitControls(),
      ),
      flickVideoWithControlsFullscreen: FlickVideoWithControls(
        videoFit: BoxFit.contain,
        controls: CustomFlickLandscapeControls(),
      ),
    );
  }
}
