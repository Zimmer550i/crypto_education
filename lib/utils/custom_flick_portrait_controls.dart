import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';

/// Default portrait controls.
class CustomFlickPortraitControls extends StatelessWidget {
  final bool hasBackButton;
  const CustomFlickPortraitControls({
    super.key,
    this.iconSize = 20,
    this.fontSize = 12,
    this.progressBarSettings,
    this.hasBackButton = true,
  });

  /// Icon size.
  ///
  /// This size is used for all the player icons.
  final double iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double fontSize;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings? progressBarSettings;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: FlickPlayToggle(
                      size: iconSize*1.5,
                      color: AppColors.gray.shade50,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(0xff1b1b1b).withAlpha(128),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (hasBackButton)
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
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xff1b1b1b).withAlpha(128),
                padding: EdgeInsets.only(
                  left: iconSize / 2,
                  right: iconSize / 2,
                  bottom: iconSize / 4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlickVideoProgressBar(
                      flickProgressBarSettings: FlickProgressBarSettings(
                        playedColor: AppColors.cyan,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlickPlayToggle(size: iconSize),
                        SizedBox(width: iconSize / 2),
                        FlickSoundToggle(size: iconSize),
                        SizedBox(width: iconSize / 2),
                        Row(
                          children: <Widget>[
                            FlickCurrentPosition(fontSize: fontSize),
                            FlickAutoHideChild(
                              child: Text(
                                ' / ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                            FlickTotalDuration(fontSize: fontSize),
                          ],
                        ),
                        Expanded(child: Container()),
                        FlickSubtitleToggle(size: iconSize),
                        SizedBox(width: iconSize / 2),
                        FlickFullScreenToggle(size: iconSize),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
