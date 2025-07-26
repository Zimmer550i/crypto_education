import 'package:crypto_education/models/live_class.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveCard extends StatelessWidget {
  final LiveClass liveClass;
  const LiveCard({super.key, required this.liveClass});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var url = Uri.parse(liveClass.link);

        if (await canLaunchUrl(url)) {
          launchUrl(url);
        } else {
          Get.snackbar("Error Occured", "Can't launch URL");
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Container(
          color: AppColors.gray.shade800,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset("assets/images/live.jpg", fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(liveClass.title, style: AppTexts.tmds),
                    ),
                    CustomSvg(
                      asset: AppIcons.link,
                      color: AppColors.gray.shade200,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
