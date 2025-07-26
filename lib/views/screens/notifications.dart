import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/utils/formatter.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    user.readNotifications().then((val) {
      if (val != "success") {
        debugPrint(val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "notifications".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                const SizedBox(height: 16),
                for (var i in user.notifications)
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: i.isRead ? Colors.transparent : AppColors.cyan,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
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
                            child: Center(
                              child: CustomSvg(asset: AppIcons.bell),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  i.message,
                                  style: AppTexts.tsmm.copyWith(
                                    color: i.isRead
                                        ? AppColors.gray.shade200
                                        : AppColors.gray.shade800,
                                  ),
                                ),
                                Row(
                                  spacing: 4,
                                  children: [
                                    CustomSvg(
                                      asset: AppIcons.clock,
                                      color: i.isRead
                                          ? AppColors.gray.shade400
                                          : AppColors.gray.shade700,
                                    ),
                                    Text(
                                      Formatter.dateFormatter(i.createdAt),
                                      style: AppTexts.txsr.copyWith(
                                        color: i.isRead
                                            ? AppColors.gray.shade400
                                            : AppColors.gray.shade700,
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
