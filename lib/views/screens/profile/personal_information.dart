import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:crypto_education/views/screens/profile/edit_personal_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Personal Information"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Align(
              child: ProfilePicture(
                image: "https://thispersondoesnotexist.com",
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Name",
              style: AppTexts.tlgs.copyWith(color: AppColors.cyan.shade300),
            ),
            const SizedBox(height: 8),
            Text(
              "Jenny Flores",
              style: AppTexts.tmdm.copyWith(color: AppColors.gray.shade200),
            ),
            const SizedBox(height: 16),
            Text(
              "Email",
              style: AppTexts.tlgs.copyWith(color: AppColors.cyan.shade300),
            ),
            const SizedBox(height: 8),
            Text(
              "Wasiul0491@gmail.com",
              style: AppTexts.tmdm.copyWith(color: AppColors.gray.shade200),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: "Edit Profile",
              leading: AppIcons.pen,
              isSecondary: true,
              onTap: () {
                Get.to(() => EditPersonalInformation(), transition: Transition.fade);
              },
            ),
          ],
        ),
      ),
    );
  }
}
