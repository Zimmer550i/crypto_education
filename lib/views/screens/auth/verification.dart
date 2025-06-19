import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/screens/auth/reset_password.dart';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatefulWidget {
  final bool isPasswordReset;
  const Verification({super.key, this.isPasswordReset = false});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  void callBack() async {
    if(widget.isPasswordReset) {
      Get.to(() => ResetPassword());
    }else{
      Get.off(() => Signin());
    }
  }

  void resendOtp() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "OTP Verification"),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Verify Email",
                  style: AppTexts.dxss.copyWith(color: AppColors.cyan.shade300),
                ),
                const SizedBox(height: 32),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    textStyle: AppTexts.txlm,
                    decoration: BoxDecoration(
                      color: AppColors.gray[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                  cursor: Container(
                    height: 25,
                    width: 3,
                    color: AppColors.cyan,
                  ),
                  validator: (value) {
                    if (value == "111111") {
                      Get.to(() => Signin());
                      return null;
                    }
                    return "Incorrect OTP";
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Verify", onTap: callBack),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t get the code?",
                      style: AppTexts.txsr.copyWith(
                        color: AppColors.gray.shade50,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: resendOtp,
                      child: Text(
                        " Resend ",
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
    );
  }
}
