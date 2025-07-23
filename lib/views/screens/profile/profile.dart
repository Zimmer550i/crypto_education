import 'package:crypto_education/controllers/auth_controller.dart';
// ignore: unused_import
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/models/clickable_button_model.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/screens/profile/info.dart';
import 'package:crypto_education/views/screens/profile/personal_information.dart';
import 'package:crypto_education/views/screens/profile/subscription_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  final List<ClickableButtonModel> options = const [
    ClickableButtonModel(
      icon: AppIcons.userCrown,
      title: "Personal Information",
      route: PersonalInformation(),
    ),
    ClickableButtonModel(
      icon: AppIcons.crown,
      title: "Subscription Plan",
      route: SubscriptionPlan(),
    ),
    ClickableButtonModel(
      icon: AppIcons.info,
      title: "Terms of Services",
      route: Info(title: "Terms of Service", data: "terms_conditions"),
    ),
    ClickableButtonModel(
      icon: AppIcons.privacy,
      title: "Privacy Policy",
      route: Info(title: "Privacy Policy", data: "privacy_policies"),
    ),
    ClickableButtonModel(
      icon: AppIcons.about,
      title: "About Us",
      route: Info(title: "About Us", data: "about_us"),
    ),
    ClickableButtonModel(icon: AppIcons.logout, title: "Logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              ...options.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      if (e.route != null) {
                        Get.to(() => e.route!);
                      }
                      if (e.title == "Logout") {
                        logoutSheet(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray.shade800,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black.withAlpha((8 * 2.55).toInt()),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CustomSvg(asset: e.icon!, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            e.title!,
                            style: AppTexts.tlgs.copyWith(
                              color: AppColors.gray.shade50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> logoutSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.cyan),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "Are you sure you want to",
                  style: AppTexts.tmdr.copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  "Logout?",
                  style: AppTexts.txls.copyWith(color: AppColors.cyan),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "Logout",
                        isSecondary: true,
                        onTap: () async {
                          Get.find<AuthController>().logout();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
