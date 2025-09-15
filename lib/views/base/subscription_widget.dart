import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final String duration;
  final List<String> pros;
  final List<String> cons;
  final bool isPurchased;
  final bool isPremium;
  final Function()? onTap;
  const SubscriptionWidget({
    super.key,
    required this.title,
    required this.price,
    required this.duration,
    required this.subTitle,
    this.pros = const [],
    this.cons = const [],
    this.isPurchased = false,
    this.isPremium = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(24),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1B1B1B),
                  isPremium ? Color(0xff194746) : Color(0xFF373737),
                ],
                transform: GradientRotation(158.11),
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isPremium
                    ? AppColors.cyan.shade300
                    : AppColors.gray.shade600,
                width: isPremium ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        height: 44 / 46,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "/$duration",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(title, style: AppTexts.dsms.copyWith(color: Colors.white)),
                const SizedBox(height: 12),
                Text(
                  subTitle,
                  style: AppTexts.tmdm.copyWith(color: AppColors.gray.shade50),
                ),
                const SizedBox(height: 20),
                Column(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < pros.length; i++)
                      Row(
                        children: [
                          CustomSvg(asset: AppIcons.tickCircle),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              pros[i],
                              style: AppTexts.tmdr.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onTap: onTap,
                  text: isPurchased ? "current_plan".tr : "choose_plan".tr,
                  leading: isPurchased ? "assets/icons/tick_circle.svg" : null,
                  isSecondary: !isPremium,
                  coloredIcon: isPurchased,
                  isDisabled: isPurchased,
                ),
              ],
            ),
          ),
          if (isPremium)
            Positioned(
              right: 0,
              top: 0,
              child: CustomSvg(asset: "assets/icons/decoration.svg"),
            ),
        ],
      ),
    );
  }
}
