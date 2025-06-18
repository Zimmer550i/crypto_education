import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/base/profile_picture.dart';

class DesignSystem extends StatefulWidget {
  const DesignSystem({super.key});

  @override
  State<DesignSystem> createState() => _DesignSystemState();
}

class _DesignSystemState extends State<DesignSystem> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Design System"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 16,
          children: [
            ProfilePicture(
              image: "https://picsum.photos/500/500",
              isEditable: true,
            ),
            CustomTextField(
              leading: AppIcons.mail,
              title: "Email",
              hintText: "Enter your email",
            ),
            CustomTextField(
              leading: AppIcons.lock,
              title: "Password",
              hintText: "Enter your password",
              isPassword: true,
            ),
            CustomButton(text: "Primary"),
            CustomButton(text: "Secondary", isSecondary: true),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        index: index,
        onChanged: (val) {
          setState(() {
            index = val;
          });
        },
      ),
    );
  }
}
