import 'package:crypto_education/services/shared_prefs_service.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/screens/auth/choose_version.dart';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/onboard.png", fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "empowering_world".tr,
                        textAlign: TextAlign.center,
                        style: AppTexts.dxsm.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () async {
                          Get.off(() => Signin());
                          if (await SharedPrefsService.get(
                                "language_selected",
                              ) !=
                              "selected") {
                            Get.to(() => ChooseVersion(), duration: Duration());
                          }
                        },
                        text: "get_start".tr,
                        trailing: AppIcons.arrowRight,
                      ),
                    ],
                  ),
                ),
                SafeArea(top: false, child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
