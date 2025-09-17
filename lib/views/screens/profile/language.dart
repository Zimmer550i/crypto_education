import 'package:crypto_education/controllers/localization_controller.dart';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final locale = Get.find<LocalizationController>();
  final user = Get.find<UserController>();

  int selected = 0;

  @override
  void initState() {
    super.initState();

    if (locale.locale.languageCode == "de") {
      selected = 1;
    } else {
      selected = 0;
    }
  }

  void changeLanguage() async {
    String language = selected == 0 ? "english" : "german";

    if (selected == 0) {
      locale.setLanguage(Locale.fromSubtags(languageCode: "en"));
    } else {
      locale.setLanguage(Locale.fromSubtags(languageCode: "de"));
    }

    final message = await user.changeLanguage(language);

    if (message == "success") {
      if (mounted) {
        Get.back();
      }
    } else {
      customSnackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "language".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomRadioButton(
                value: selected == 0,
                title: "English",
                onClick: () {
                  setState(() {
                    selected = 0;
                  });
                  // locale.setLanguage(Locale.fromSubtags(languageCode: "en"));
                },
              ),
              const SizedBox(height: 16),
              CustomRadioButton(
                value: selected == 1,
                title: "Deutsch",
                onClick: () {
                  setState(() {
                    selected = 1;
                  });
                  // locale.setLanguage(Locale.fromSubtags(languageCode: "de"));
                },
              ),
              Spacer(),
              Obx(
                () => CustomButton(
                  text: "confirm".tr,
                  isLoading: user.isLoading.value,
                  onTap: changeLanguage,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
