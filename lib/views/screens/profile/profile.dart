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
import 'package:crypto_education/views/screens/profile/language.dart';
import 'package:crypto_education/views/screens/profile/personal_information.dart';
import 'package:crypto_education/views/screens/profile/subscription_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              ...[
                ClickableButtonModel(
                  icon: AppIcons.userCrown,
                  title: "personal_information".tr,
                  route: PersonalInformation(),
                ),
                ClickableButtonModel(
                  icon: "assets/icons/language.svg",
                  title: "language".tr,
                  route: Language(),
                ),
                ClickableButtonModel(
                  icon: AppIcons.crown,
                  title: "subscription_plan".tr,
                  route: SubscriptionPlan(),
                ),
                ClickableButtonModel(
                  icon: AppIcons.info,
                  title: "terms_of_service".tr,
                  route: Info(
                    title: "terms_of_service".tr,
                    data: "terms_conditions",
                  ),
                ),
                ClickableButtonModel(
                  icon: AppIcons.privacy,
                  title: "privacy_policy".tr,
                  route: Info(
                    title: "privacy_policy".tr,
                    data: "privacy_policies",
                  ),
                ),
                ClickableButtonModel(
                  icon: AppIcons.about,
                  title: "about_us".tr,
                  route: Info(title: "about_us".tr, data: "about_us"),
                ),
                ClickableButtonModel(icon: AppIcons.logout, title: "logout".tr),
              ].map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      if (e.route != null) {
                        Get.to(() => e.route!);
                      }
                      if (e.title == "logout".tr) {
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
                  "are_you_sure_logout".tr,
                  textAlign: TextAlign.center,
                  style: AppTexts.tmdr.copyWith(color: AppColors.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  "logout_question".tr,
                  style: AppTexts.txls.copyWith(color: AppColors.cyan),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "logout".tr,
                        isSecondary: true,
                        onTap: () async {
                          Get.find<AuthController>().logout();
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "cancel".tr,
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
