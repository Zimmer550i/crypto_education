import 'package:crypto_education/controllers/auth_controller.dart';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDeletation extends StatelessWidget {
  const AccountDeletation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "account_deletion_title".tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomSvg(
                    asset: AppIcons.accountDeletation,
                    size: 160,
                    color: AppColors.cyan,
                  ),
                ),
                Center(
                  child: Text(
                    "instant_account_deletion".tr,
                    textAlign: TextAlign.center,
                    style: AppTexts.tlgb.copyWith(
                      color: AppColors.gray.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text("account_deletion_description".tr, style: AppTexts.tsmr),
                const SizedBox(height: 16),
                Text(
                  "what_happens_when_you_delete_your_account".tr,
                  style: AppTexts.txsb,
                ),
                const SizedBox(height: 8),
                Text("account_deletion_point_1".tr, style: AppTexts.txsr),
                const SizedBox(height: 4),
                Text("account_deletion_point_2".tr, style: AppTexts.txsr),
                const SizedBox(height: 4),
                Text("account_deletion_point_3".tr, style: AppTexts.txsr),
                const SizedBox(height: 16),
                Text("instant_deletion_process".tr, style: AppTexts.txsb),
                const SizedBox(height: 8),
                Text(
                  "instant_deletion_process_point_1".tr,
                  style: AppTexts.txsr,
                ),
                const SizedBox(height: 4),
                Text(
                  "instant_deletion_process_point_2".tr,
                  style: AppTexts.txsr,
                ),
                const SizedBox(height: 16),
                Text(
                  "can_i_recover_my_account_after_deletion".tr,
                  style: AppTexts.txsb,
                ),
                const SizedBox(height: 8),
                Text("account_recovery_info".tr, style: AppTexts.txsr),
                const SizedBox(height: 16),
                Text("considerations_before_deletion".tr, style: AppTexts.txsb),
                const SizedBox(height: 8),
                Text("consideration_point_1".tr, style: AppTexts.txsr),
                const SizedBox(height: 4),
                Text("consideration_point_2".tr, style: AppTexts.txsr),
                const SizedBox(height: 28),
                Center(
                  child: GestureDetector(
                    onTap: () => deletationSheet(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "delete_account_button".tr,
                            textAlign: TextAlign.center,
                            style: AppTexts.tsmb.copyWith(
                              color: AppColors.gray.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> deletationSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      builder: (_) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.gray.shade200),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 75),
                Text(
                  "your_account_will_be".tr,
                  style: AppTexts.tmdr.copyWith(color: AppColors.gray.shade300),
                ),
                const SizedBox(height: 4),
                Text(
                  "deleted".tr,
                  style: AppTexts.txlb.copyWith(color: AppColors.red),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                        text: "sure_button".tr,
                        isSecondary: true,
                        onTap: () async {
                          Get.back();
                          final message = await Get.find<UserController>()
                              .deleteUserAccount();
                          if (message == "success") {
                            Get.find<AuthController>().logout();
                          } else {
                            customSnackbar("error_occured".tr, message);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: "go_back_button".tr,
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
