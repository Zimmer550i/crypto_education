import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  const CustomAppBar({super.key, required this.title, this.hasLeading = true});

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.gray[900],
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(width: 20),
          InkWell(
            onTap: () => hasLeading ? Get.back() : null,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 24,
              width: 24,
              child: hasLeading
                  ? Center(child: CustomSvg(asset: AppIcons.back))
                  : const SizedBox(),
            ),
          ),
          Spacer(),
          Text(title, style: AppTexts.tmds),
          Spacer(),
          SizedBox(width: 24),
          SizedBox(width: 20),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          height: 1,
          width: double.infinity,
          color: AppColors.gray.shade600,
        ),
      ),
    );
  }
}
