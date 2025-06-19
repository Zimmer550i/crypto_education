import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/screens/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  final String? email;
  const ForgetPassword({super.key, this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl.text = widget.email ?? "";
  }

  void callBack() async {
    Get.to(() => Verification(isPasswordReset: true,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forgot Password"),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  controller: emailCtrl,
                  title: "Email",
                  leading: AppIcons.mail,
                  hintText: "Enter your email",
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Send OTP", onTap: callBack),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
