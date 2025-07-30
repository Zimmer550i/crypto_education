import 'package:crypto_education/controllers/chat_controller.dart';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:crypto_education/views/screens/home.dart';
import 'package:crypto_education/views/screens/notifications.dart';
import 'package:crypto_education/views/screens/profile/personal_information.dart';
import 'package:crypto_education/views/screens/profile/profile.dart';
import 'package:crypto_education/views/screens/videos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final user = Get.find<UserController>();
  final chat = Get.find<ChatController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController();
  final List<Widget> pages = [
    Home(key: PageStorageKey("home")),
    Videos(key: PageStorageKey("videos")),
    Chat(key: PageStorageKey("chat")),
    Profile(key: PageStorageKey("profile")),
  ];

  int index = 0;
  bool showingHistory = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: index == 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey("profileView"),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => PersonalInformation());
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          ProfilePicture(
                            image: ApiService.getImgUrl(
                              user.userInfo.value?.image,
                            ),
                            size: 44,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${"hi_user".tr} ${user.userInfo.value?.fullName}",
                            style: AppTexts.tmdr.copyWith(
                              color: AppColors.gray.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey("logoView"),
                    child: Image.asset(
                      "assets/images/appbar_logo.png",
                      height: 40,
                    ),
                  ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (index == 2) {
                if (chat.globalSessions.isEmpty) {
                  chat.getGlobalSession().then((message) {
                    if (message != "success") {
                      Get.snackbar("error_occurred".tr, message);
                    }
                  });
                }
                _scaffoldKey.currentState?.openDrawer();
              } else {
                Get.to(() => Notifications());
              }
            },
            child: SizedBox(
              height: 32,
              width: 32,
              child: Center(
                child: index == 2
                    ? CustomSvg(asset: AppIcons.menu)
                    : Obx(
                        () => CustomSvg(
                          asset: user.unreadNotifications.value == 0
                              ? AppIcons.notification
                              : "assets/icons/notification_alert.svg",
                          color: AppColors.gray.shade100,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
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
                                Text(
                                  i.name,
                                  style: AppTexts.tsmr.copyWith(
                                    color: i == chat.currentGlobalSession.value
                                        ? AppColors.gray.shade900
                                        : Colors.white,
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: PopupMenuButton(
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
                                        ),
                                        PopupMenuItem(
                                          child: options(
                                            AppIcons.delete,
                                            "delete".tr,
                                          ),
                                          onTap: () {
                                            chat
                                                .deleteGlobalSession(i.objectId)
                                                .then((message) {
                                                  Get.snackbar(
                                                    "error_occurred".tr,
                                                    message,
                                                  );
                                                });
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
      ),
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavbar(
        index: index,
        onChanged: (val) {
          final temp = index;
          setState(() {
            index = val;
          });
          controller.animateToPage(
            index,
            duration: Duration(milliseconds: (temp - index).abs() * 100),
            curve: Curves.easeOut,
          );
        },
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
