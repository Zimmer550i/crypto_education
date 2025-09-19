import 'package:crypto_education/controllers/video_controller.dart';
import 'package:crypto_education/models/courses_model.dart';
import 'package:crypto_education/views/base/custom_loading.dart';
import 'package:crypto_education/views/base/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_snackbar.dart';
import '../../base/custom_app_bar.dart';

class CategoryList extends StatefulWidget {
  final CourseModel course;
  final bool? hasImage;
  final bool? hasCompleted;

  const CategoryList({super.key,required this.course,this.hasImage = true,
    this.hasCompleted = true, });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final video = Get.find<VideoController>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // clear old data before fetching new
      video.topics.clear();

      video.getCategory(id: widget.course.id, override: true).then((message) {
        if (message != "success") {
          customSnackbar("error_occurred".tr, message);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: widget.course.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 24),
        child: SafeArea(
          child: Obx(() {
            if (video.isLoading.value) {
              return const Center(child: CustomLoading());
            }
            if (video.topics.isEmpty) {
              return const Center(child: Text("No topics found"));
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: video.topics.length,
              itemBuilder: (context, index) {
                final topic = video.topics[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VideoCard(topic,hasImage: widget.hasImage,hasCompleted: widget.hasCompleted,),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
