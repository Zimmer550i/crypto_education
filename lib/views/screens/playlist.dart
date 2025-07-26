import 'package:crypto_education/controllers/video_controller.dart';
import 'package:crypto_education/models/topic.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_loading.dart';
import 'package:crypto_education/views/screens/video_playback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Playlist extends StatefulWidget {
  final Topic topic;
  const Playlist(this.topic, {super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final video = Get.find<VideoController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((message) {
      video.getVideos(widget.topic.id.toString(), override: true).then((
        message,
      ) {
        if (message != "success") {
          Get.snackbar("error_occurred".tr, message);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.topic.name),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 24),
                  if (video.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomLoading(),
                    ),
                  if (!video.isLoading.value)
                    for (var i in video.videos)
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => VideoPlayback(i));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.gray.shade800,
                            ),
                            child: Row(
                              spacing: 12,
                              children: [
                                CustomSvg(asset: AppIcons.play),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(i.title, style: AppTexts.tmdm),
                                      Text(
                                        "${i.durationSeconds ~/ 60}${"minute".tr}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: AppColors.gray.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
