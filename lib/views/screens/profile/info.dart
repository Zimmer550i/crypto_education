import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Info extends StatefulWidget {
  final String title;
  final String data;
  const Info({super.key, required this.title, required this.data});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    user.getSettingsInfo(widget.data).then((val) {
      if (val != "success") {
        customSnackbar("error_occurred".tr, val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Obx(
                () => user.isLoading.value
                ? const CustomLoading()
                : Html(
              data: user.settingsInfo[widget.data] ??
                  "<p style=\"color: red; text-align: center;\">${"error_fetching_data".tr}</p>",
              style: {
                "p": Style(
                  fontSize: FontSize(16),
                  lineHeight: LineHeight(1.5),
                  color: Colors.white,
                ),
                "strong": Style(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize(16),
                  color: Colors.white,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
