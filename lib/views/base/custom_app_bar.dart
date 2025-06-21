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
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            const SizedBox(width: 20,),
            Expanded(child: Center(child: Text(title, style: AppTexts.tmds, maxLines: 3,))),
            const SizedBox(width: 20,),
            SizedBox(width: 24),
          ],
        ),
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
