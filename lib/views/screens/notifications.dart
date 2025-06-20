import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              for (int i = 0; i < 20; i++)
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.gray.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: CustomSvg(asset: AppIcons.bell)),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Lesson Available: Intro to Smart Contracts",
                              style: AppTexts.tsmm.copyWith(
                                color: AppColors.gray.shade200,
                              ),
                            ),
                        
                            Row(
                              spacing: 4,
                              children: [
                                CustomSvg(asset: AppIcons.clock),
                                Text(
                                  "5 minutes ago",
                                  style: AppTexts.txsr.copyWith(
                                    color: AppColors.gray.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
