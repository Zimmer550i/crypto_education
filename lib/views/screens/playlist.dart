import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/screens/video_playback.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Crypto Basics"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                for (int i = 0; i < 20; i++)
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => VideoPlayback());
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Facts and Background: What are virtual currencies ?",
                                    style: AppTexts.tmdm,
                                  ),
                                  Text(
                                    "24mins",
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
    );
  }
}
