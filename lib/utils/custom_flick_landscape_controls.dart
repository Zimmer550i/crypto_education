import 'package:crypto_education/utils/custom_flick_portrait_controls.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';

/// Default landscape controls.
class CustomFlickLandscapeControls extends StatelessWidget {
  const CustomFlickLandscapeControls({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFlickPortraitControls(
      fontSize: 14,
      iconSize: 30,
      progressBarSettings: FlickProgressBarSettings(
        height: 5,
      ),
      hasBackButton: false,
    );
  }
}
