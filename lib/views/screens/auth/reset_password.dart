import 'package:crypto_education/controllers/auth_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = Get.find<AuthController>();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();

  void callBack() async {
    final message = await auth.resetPassword(passCtrl.text, conPassCtrl.text);

    if (message == "success") {
      Get.offAll(() => Signin());
      customSnackbar("password_reset_success".tr, "sign_in_again".tr);
    } else {
      customSnackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "reset_password".tr),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "reset_password".tr,
                  style: AppTexts.dxss.copyWith(color: AppColors.cyan.shade300),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: passCtrl,
                  title: "password".tr,
                  leading: AppIcons.lock,
                  isPassword: true,
                  hintText: "enter_password".tr,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: conPassCtrl,
                  title: "confirm_password".tr,
                  leading: AppIcons.lock,
                  isPassword: true,
                  hintText: "re_enter_password".tr,
                ),
                const SizedBox(height: 40),
                Obx(
                  () => CustomButton(
                    text: "verify".tr,
                    isLoading: auth.isLoading.value,
                    onTap: callBack,
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
