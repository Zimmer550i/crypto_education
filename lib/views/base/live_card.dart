import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flutter/material.dart';

class LiveCard extends StatelessWidget {
  const LiveCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Container(
          color: AppColors.gray.shade800,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  "assets/images/live.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Facts and Background: What are virtual currencies ?",
                        style: AppTexts.tmds,
                      ),
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