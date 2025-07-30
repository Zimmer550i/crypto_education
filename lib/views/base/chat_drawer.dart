import 'package:crypto_education/controllers/chat_controller.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_icons.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final chat = Get.find<ChatController>();
  final chatNameCtrl = TextEditingController();
  int nameEditingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.gray.shade800,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Obx(
              () => Column(
                spacing: 24,
                children: [
                  InkWell(
                    onTap: () {
                      chat.createGlobalChat().then((message) {
                        if (message == "success") {
                        } else {
                          Get.snackbar("error_occurred".tr, message);
                        }
                      });
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CustomSvg(
                            asset: AppIcons.edit,
                            color: AppColors.gray.shade200,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "new_chat".tr,
                            style: AppTexts.tsmr.copyWith(
                              color: AppColors.gray.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.gray.shade100,
                  ),
                  if (chat.isLoading.value)
                    CircularProgressIndicator(color: AppColors.cyan),
                  for (var i in chat.globalSessions)
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        chat.currentGlobalSession = Rxn(i);
                        chat.getGlobalMessages();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0, right: 24),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: i == chat.currentGlobalSession.value
                                ? AppColors.cyan
                                : AppColors.gray.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              chat.globalSessions.indexOf(i) == nameEditingIndex
                                  ? Expanded(
                                      child: TextField(
                                        autofocus: true,
                                        controller: chatNameCtrl,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      i.name,
                                      style: AppTexts.tsmr.copyWith(
                                        color:
                                            i == chat.currentGlobalSession.value
                                            ? AppColors.gray.shade900
                                            : Colors.white,
                                      ),
                                    ),
                              if (nameEditingIndex == -1) Spacer(),
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: nameEditingIndex != -1
                                    ? GestureDetector(
                                        onTap: () {
                                          if (i.name !=
                                              chatNameCtrl.text.trim()) {
                                            chat.renameGlobalSession(
                                              i.objectId,
                                              chatNameCtrl.text.trim(),
                                            );
                                          }
                                          setState(() {
                                            nameEditingIndex = -1;
                                          });
                                        },
                                        behavior: HitTestBehavior.translucent,
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: AppColors.gray.shade200,
                                        ),
                                      )
                                    : PopupMenuButton(
                                        padding: EdgeInsets.zero,
                                        iconColor:
                                            i == chat.currentGlobalSession.value
                                            ? AppColors.gray.shade900
                                            : AppColors.gray.shade200,
                                        color: AppColors.gray.shade700,
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        icon: CustomSvg(asset: AppIcons.more),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: options(
                                                AppIcons.rename,
                                                "rename".tr,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  nameEditingIndex = chat
                                                      .globalSessions
                                                      .indexOf(i);
                                                  chatNameCtrl.text = i.name
                                                      .trim();
                                                });
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: options(
                                                AppIcons.delete,
                                                "delete".tr,
                                              ),
                                              onTap: () {
                                                chat
                                                    .deleteGlobalSession(
                                                      i.objectId,
                                                    )
                                                    .then((message) {
                                                      Get.snackbar(
                                                        "error_occurred".tr,
                                                        message,
                                                      );
                                                    });
                                                if (chat
                                                        .currentGlobalSession
                                                        .value
                                                        ?.objectId ==
                                                    i.objectId) {
                                                  chat.createGlobalChat();
                                                }
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row options(String asset, String text) {
    return Row(
      children: [
        CustomSvg(asset: asset, color: AppColors.gray.shade200),
        const SizedBox(width: 16),
        Text(
          text,
          style: AppTexts.tsmr.copyWith(color: AppColors.gray.shade100),
        ),
      ],
    );
  }
}
