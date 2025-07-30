import 'package:crypto_education/controllers/video_controller.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_loading.dart';
import 'package:crypto_education/views/base/pull_to_refresh.dart';
import 'package:crypto_education/views/base/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final video = Get.find<VideoController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      if (video.topics.isEmpty) {
        video.getTopics().then((message) {
          if (message != "success") {
            customSnackbar("error_occurred".tr, message);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PullToRefresh(
            onRefresh: () async {
              video.getTopics().then((message) {
                if (message != "success") {
                  customSnackbar("error_occurred".tr, message);
                }
              });
            },
            child: Column(
              children: [
                const SizedBox(height: 24),
                Obx(
                  () => Column(
                    children: [
                      if (video.topics.isEmpty && !video.isLoading.value)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: Text("no_videos".tr, style: AppTexts.txsr),
                          ),
                        ),
                      if (video.isLoading.value)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        ),
                      for (var topic in video.topics)
                        Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 12),
                          child: VideoCard(topic),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
