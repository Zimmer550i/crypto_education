import 'package:crypto_education/controllers/chat_controller.dart';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/chat_drawer.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:crypto_education/views/screens/home.dart';
import 'package:crypto_education/views/screens/notifications.dart';
import 'package:crypto_education/views/screens/profile/personal_information.dart';
import 'package:crypto_education/views/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'course/video_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final user = Get.find<UserController>();
  final chat = Get.find<ChatController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [
    Home(key: PageStorageKey("home")),
    VideoList(key: PageStorageKey("videos")),
    Chat(key: PageStorageKey("chat")),
    Profile(key: PageStorageKey("profile")),
  ];

  final chatNameCtrl = TextEditingController();
  final controller = PageController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    chat.getGlobalSession().then((message) {
      if (message != "success") {
        customSnackbar("error_occurred".tr, message);
      }
    });
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
                      customSnackbar("error_occurred".tr, message);
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
      drawer: ChatDrawer(),
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
}
