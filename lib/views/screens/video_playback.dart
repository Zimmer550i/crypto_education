import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/video_widget.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayback extends StatelessWidget {
  const VideoPlayback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                VideoWidget(),
                Positioned(
                  top: 12,
                  left: 20,
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
                      child: Center(
                        child: CustomSvg(asset: AppIcons.arrowLeft),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.cyan.shade900,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "How to ride your skateboard and Basic Equipment",
                style: AppTexts.tlgm,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.gray.shade700,
          ),
          Expanded(child: Chat(expanded: false)),
        ],
      ),
    );
  }
}
