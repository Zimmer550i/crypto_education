import 'dart:io';
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
  File? _image;
  final nameCtrl = TextEditingController(text: "Jenny Flores");

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
                image: "https://thispersondoesnotexist.com",
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
            CustomButton(
              text: "Save Changes",
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
