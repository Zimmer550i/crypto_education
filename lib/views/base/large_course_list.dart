import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_education/models/courses_model.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/screens/home/category_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LargeCourseList extends StatelessWidget {
  final CourseModel courses;
  const LargeCourseList(this.courses, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CategoryList(course: courses,hasImage: false,hasCompleted: false,));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray.shade800,
          border: Border.all(color: Colors.cyan.shade300,width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail image
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: courses.thumbnail,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  height: 180, // bigger preview image
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// Course title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                courses.name,
                style: AppTexts.txlb,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
