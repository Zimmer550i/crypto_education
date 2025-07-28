import 'package:crypto_education/controllers/auth_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:crypto_education/views/screens/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final auth = Get.find<AuthController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();

  void signUpCallback() async {
    final message = await auth.signup(
      nameCtrl.text,
      emailCtrl.text,
      passCtrl.text,
      conPassCtrl.text,
    );

    if (message == "success") {
      Get.to(() => Verification(email: emailCtrl.text));
      Get.snackbar(
        "account_created_successfully".tr,
        "please_check_email_for_verification".tr,
      );
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("set_up_account".tr, style: AppTexts.dlgm),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: nameCtrl,
                    title: "name".tr,
                    leading: AppIcons.user,
                    hintText: "enter_name".tr,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: emailCtrl,
                    title: "email".tr,
                    leading: AppIcons.mail,
                    hintText: "enter_email".tr,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passCtrl,
                    title: "password".tr,
                    isPassword: true,
                    leading: AppIcons.lock,
                    hintText: "enter_password".tr,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: conPassCtrl,
                    title: "confirm_password".tr,
                    leading: AppIcons.lock,
                    isPassword: true,
                    hintText: "re_enter_password".tr,
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => CustomButton(
                      text: "sign_up".tr,
                      isLoading: auth.isLoading.value,
                      onTap: signUpCallback,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_have_account".tr,
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.gray.shade50,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.off(() => Signin());
                        },
                        child: Text(
                          "sign_in".tr,
                          style: AppTexts.txss.copyWith(
                            color: AppColors.cyan.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
