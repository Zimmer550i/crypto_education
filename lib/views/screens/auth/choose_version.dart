import 'package:crypto_education/controllers/localization_controller.dart';
import 'package:crypto_education/services/shared_prefs_service.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseVersion extends StatefulWidget {
  const ChooseVersion({super.key});

  @override
  State<ChooseVersion> createState() => _ChooseVersionState();
}

class _ChooseVersionState extends State<ChooseVersion> {
  final locale = Get.find<LocalizationController>();

  int val = 0;

  @override
  void initState() {
    super.initState();

    if (locale.locale.languageCode == "de") {
      val = 1;
    } else {
      val = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text("preferred_version".tr, style: AppTexts.dlgm),
            const SizedBox(height: 24),
            CustomRadioButton(
              value: val == 0,
              title: "English",
              onClick: () {
                val = 0;
                locale.setLanguage(Locale.fromSubtags(languageCode: "en"));
              },
            ),
            const SizedBox(height: 16),
            CustomRadioButton(
              value: val == 1,
              title: "Deutsch",
              onClick: () {
                val = 1;
                locale.setLanguage(Locale.fromSubtags(languageCode: "de"));
              },
            ),

            const SizedBox(height: 48),
            CustomButton(
              text: "continue".tr,
              onTap: () {
                SharedPrefsService.set("language_selected", "selected");
                Get.back();
              },
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
