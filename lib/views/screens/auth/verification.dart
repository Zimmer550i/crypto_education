import 'package:crypto_education/controllers/auth_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/screens/app.dart';
import 'package:crypto_education/views/screens/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatefulWidget {
  final bool isPasswordReset;
  final String email;
  const Verification({
    super.key,
    this.isPasswordReset = false,
    required this.email,
  });

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final auth = Get.find<AuthController>();
  final codeCtrl = TextEditingController();

  void callBack() async {
    final message = await auth.verifyEmail(widget.email, codeCtrl.text);

    if (message == "success") {
      if (widget.isPasswordReset) {
        Get.to(() => ResetPassword());
      } else {
        Get.off(() => App());
      }
      customSnackbar("account_verified".tr, "welcome_crypto_education".tr);
    } else {
      customSnackbar("error_occurred".tr, message);
    }
  }

  void resendOtp() async {
    final message = await auth.sendOtp(widget.email);

    if (message == "success") {
      customSnackbar(
        "otp_sent_success".tr,
        "${"enter_otp".tr} ${widget.email}",
      );
    } else {
      customSnackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "otp_verification".tr),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "verify_email".tr,
                  style: AppTexts.dxss.copyWith(color: AppColors.cyan.shade300),
                ),
                const SizedBox(height: 32),
                Pinput(
                  length: 6,
                  controller: codeCtrl,
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
                ),
                const SizedBox(height: 24),
                Obx(
                  () => CustomButton(
                    text: "verify".tr,
                    isLoading: auth.isLoading.value,
                    onTap: callBack,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "dont_get_code".tr,
                      style: AppTexts.txsr.copyWith(
                        color: AppColors.gray.shade50,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: resendOtp,
                      child: Text(
                        "resend".tr,
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
