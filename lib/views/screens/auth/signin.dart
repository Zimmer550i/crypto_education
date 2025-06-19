import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/screens/auth/forget_password.dart';
import 'package:crypto_education/views/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void signInCallback() async {}

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
                  Text("Sign In Your Account", style: AppTexts.dlgm),
                  const SizedBox(height: 24),
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
                    leading: AppIcons.lock,
                    hintText: "Enter your password",
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.to(() => ForgetPassword());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: AppTexts.txss.copyWith(
                          color: AppColors.cyan.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: "Sign In", onTap: signInCallback),
                  const SizedBox(height: 20),
                  Row(
                    spacing: 15,
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: Divider(
                          color: AppColors.gray.shade200,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray.shade200,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Divider(
                          color: AppColors.gray.shade200,
                          height: 1.5,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Login With Google",
                    isSecondary: true,
                    leading: AppIcons.google,
                    coloredIcon: true,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTexts.txsr.copyWith(
                          color: AppColors.gray.shade50,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.to(() => Signup());
                        },
                        child: Text(
                          " Sign Up ",
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
