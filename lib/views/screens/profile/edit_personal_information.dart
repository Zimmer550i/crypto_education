import 'dart:io';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/custom_text_field.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPersonalInformation extends StatefulWidget {
  const EditPersonalInformation({super.key});

  @override
  State<EditPersonalInformation> createState() =>
      _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {
  final user = Get.find<UserController>();
  File? _image;
  final nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = user.userInfo.value?.fullName ?? "Your Name Here";
  }

  void onCallBack() async {
    Map<String, dynamic> payload = {"full_name": nameCtrl.text};

    if (_image != null) {
      payload.addAll({"image": _image});
    }
    final message = await user.updateInfo(payload);

    if (message == "success") {
      Get.back();
      Get.snackbar("Successful", "Profile information successfully updated");
    } else {
      Get.snackbar("Error Occured", message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Personal Information"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Align(
              child: ProfilePicture(
                image: ApiService.getImgUrl(user.userInfo.value?.image),
                imageFile: _image,
                isEditable: true,
                imagePickerCallback: (val) {
                  setState(() {
                    _image = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(controller: nameCtrl, title: "Name"),
            const SizedBox(height: 32),
            Obx(
              () => CustomButton(
                text: "Save Changes",
                isLoading: user.isLoading.value,
                onTap: () {
                  onCallBack();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
