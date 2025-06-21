import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/video_widget.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:flutter/material.dart';

class VideoPlayback extends StatelessWidget {
  const VideoPlayback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "How to ride your skateboard and Basic Equipment"),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          SafeArea(bottom: false, child: VideoWidget()),
          // Container(
          //   color: AppColors.cyan.shade900,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 20,
          //       vertical: 16,
          //     ),
          //     child: Text(
          //       "How to ride your skateboard and Basic Equipment",
          //       style: AppTexts.tlgm,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: 1,
          //   color: AppColors.gray.shade700,
          // ),
          Expanded(child: Chat(expanded: false)),
        ],
      ),
    );
  }
}
