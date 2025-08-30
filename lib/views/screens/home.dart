import 'package:crypto_education/controllers/video_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_loading.dart';
import 'package:crypto_education/views/base/live_card.dart';
import 'package:crypto_education/views/base/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/course_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final video = Get.find<VideoController>();
  bool hasLive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      if (video.courses.isEmpty) {
        video.getCourses().then((message) {
          if (message != "success") {
            customSnackbar("error_occurred".tr, message);
          }
        });
      }
      video.getLiveClass().then((message) {
        if (message != "success") {
          customSnackbar("error_occurred".tr, message);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // if (video.liveClass.value != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "live_class".tr,
                    style: AppTexts.tmdm.copyWith(
                      color: AppColors.gray.shade50,
                    ),
                  ),
                ),
                if (video.liveClass.value != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: LiveCard(liveClass: video.liveClass.value!),
                  ),
                if (video.liveClass.value == null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: Text("no_live_classes".tr, style: AppTexts.txsr),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "featured_topics".tr,
                    style: AppTexts.tmdm.copyWith(
                      color: AppColors.gray.shade50,
                    ),
                  ),
                ),
                Obx(
                  () => Column(
                    children: [
                      if (video.isLoading.value)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        ),
                      for (var courses in video.courses)
                        Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 12),
                          child: CourseList(courses),
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
