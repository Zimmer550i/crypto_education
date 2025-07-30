import 'package:crypto_education/models/video.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/video_widget.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:flutter/material.dart';

class VideoPlayback extends StatelessWidget {
  final Video video;
  const VideoPlayback(this.video, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Stack(children: [VideoWidget(video.videoFile ?? "")]),
          ),
          Container(
            width: double.infinity,
            color: AppColors.cyan.shade900,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                video.title,
                textAlign: TextAlign.left,
                style: AppTexts.tlgm,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.gray.shade700,
          ),
          Expanded(child: Chat(video: video)),
        ],
      ),
    );
  }
}
