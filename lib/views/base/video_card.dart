import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_education/models/topic.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/screens/playlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCard extends StatelessWidget {
  final Topic topic;
  const VideoCard(this.topic, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => Playlist(topic));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray.shade800,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: topic.thumbnail == null
                  ? Container(
                      height: 68,
                      width: 104,
                      color: Colors.white.withValues(alpha: 0.06),
                      child: Icon(
                        Icons.video_collection_outlined,
                        color: Colors.grey,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: topic.thumbnail!,
                      fadeInDuration: Duration(),
                      fadeOutDuration: Duration(),
                      height: 68,
                      width: 104,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.name, style: AppTexts.tmds),
                  Text(
                    "${topic.completedVideos}/${topic.totalVideos} completed",
                    style: AppTexts.txsr.copyWith(
                      color: AppColors.cyan.shade300,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomSvg(asset: AppIcons.navArrowRight),
          ],
        ),
      ),
    );
  }
}
