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
  final bool? hasImage;
  final bool? hasCompleted;

  const VideoCard(
    this.topic, {
    super.key,
    this.hasImage = true,
    this.hasCompleted = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => Playlist(topic));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray.shade800,
        ),
        child: Row(
          children: [
            /// Thumbnail
            hasImage == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: topic.thumbnail == null
                        ? Container(
                            height: 68,
                            width: 104,
                            color: Colors.white.withOpacity(0.06),
                            child: const Icon(
                              Icons.video_collection_outlined,
                              color: Colors.grey,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: topic.thumbnail!,
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            height: 68,
                            width: 104,
                            fit: BoxFit.cover,
                          ),
                  )
                : SizedBox(),
            const SizedBox(width: 16),

            /// Title & completion text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.name,
                    style: AppTexts.tmds,
                    maxLines: 2, // allow 2 lines max
                    overflow: TextOverflow.ellipsis, // cut with ...
                  ),
                  const SizedBox(height: 4),
                  hasCompleted == true
                      ? Text(
                          "${topic.completedVideos}/${topic.totalVideos} completed",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.cyan.shade300,
                          ),
                        )
                      : Text(
                          "${topic.totalVideos} Videos",
                          style: AppTexts.txsr.copyWith(
                            color: AppColors.cyan.shade300,
                          ),
                        ),
                ],
              ),
            ),

            /// Right arrow
            const SizedBox(width: 8),
            CustomSvg(asset: AppIcons.navArrowRight),
          ],
        ),
      ),
    );
  }
}
