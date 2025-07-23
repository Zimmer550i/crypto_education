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
        "Account created successfully",
        "Please check your email to get verification code.",
      );
    } else {
      Get.snackbar("Error Occured", message);
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
                  Text("Set Up Your Account", style: AppTexts.dlgm),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: nameCtrl,
                    title: "Name",
                    leading: AppIcons.user,
                    hintText: "Enter your name",
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: emailCtrl,
                    title: "Email",
                    leading: AppIcons.mail,
                    hintText: "Enter your email",
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passCtrl,
                    title: "Password",
                    isPassword: true,
                    leading: AppIcons.lock,
                    hintText: "Enter your password",
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: conPassCtrl,
                    title: "Confirm Password",
                    leading: AppIcons.lock,
                    isPassword: true,
                    hintText: "Re-Enter your password",
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => CustomButton(
                      text: "Sign Up",
                      isLoading: auth.isLoading.value,
                      onTap: signUpCallback,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                          " Sign In ",
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
