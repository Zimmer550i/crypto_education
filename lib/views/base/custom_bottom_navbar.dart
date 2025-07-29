import 'package:crypto_education/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int)? onChanged;

  const CustomBottomNavbar({super.key, required this.index, this.onChanged});

  final List<String> assets = const [
    AppIcons.home,
    AppIcons.videos,
    AppIcons.chat,
    AppIcons.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray[600]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 22.8,
            offset: Offset(0, -4), // Shadow on top
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.cyan[300],
        backgroundColor: Color(0xff212121),
        showUnselectedLabels: false,
        items: [
          for (int i = 0; i < 4; i++)
            BottomNavigationBarItem(
              label: ["home".tr, "videos".tr, "chat".tr, "profile".tr][i],
              icon: CustomSvg(
                asset: assets[i],
                color: i == index ? AppColors.cyan[300] : AppColors.gray[300],
              ),
            ),
        ],
      ),
    );
  }
}
