import 'package:crypto_education/models/video.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/video_widget.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:crypto_education/views/screens/profile/subscription_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayback extends StatefulWidget {
  final Video video;
  const VideoPlayback(this.video, {super.key});

  @override
  State<VideoPlayback> createState() => _VideoPlaybackState();
}

class _VideoPlaybackState extends State<VideoPlayback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Stack(children: [VideoWidget(widget.video.videoFile ?? "")]),
          ),
          Container(
            width: double.infinity,
            color: AppColors.cyan.shade900,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                widget.video.title,
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
          Expanded(child: Chat(video: widget.video)),
        ],
      ),
    );
  }

  Future<dynamic> premiumFeatureSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      isDismissible: false,
      enableDrag: false,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.cyan),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "premium_feature".tr,
                  textAlign: TextAlign.center,
                  style: AppTexts.tmdr.copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  "premium_question".tr,
                  style: AppTexts.txls.copyWith(color: AppColors.cyan),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "cancel".tr,
                        isSecondary: true,
                        onTap: () async {
                          Get.back();
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "subscribe".tr,
                        onTap: () {
                          Get.to(() => SubscriptionPlan());
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
