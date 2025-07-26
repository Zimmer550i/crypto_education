import 'package:crypto_education/controllers/auth_controller.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/screens/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  final String email;
  const ForgetPassword({super.key, required this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final auth = Get.find<AuthController>();
  final emailCtrl = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailCtrl.text = widget.email;
  }

  void callBack() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.sendOtp(emailCtrl.text);

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(() => Verification(isPasswordReset: true, email: emailCtrl.text));
      Get.snackbar(
        "otp_sent_success".tr,
        "${"enter_otp".tr} ${widget.email}",
      );
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "forgot_password".tr),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  controller: emailCtrl,
                  title: "email".tr,
                  leading: AppIcons.mail,
                  hintText: "enter_email".tr,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: "send_otp".tr,
                  isLoading: isLoading,
                  onTap: callBack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
