import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:crypto_education/views/screens/auth/forget_password.dart';
import 'package:crypto_education/views/screens/home/home.dart';
import 'package:crypto_education/views/screens/notifications.dart';
import 'package:crypto_education/views/screens/profile/profile.dart';
import 'package:crypto_education/views/screens/videos/videos.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final controller = PageController();
  int index = 0;
  final List<Widget> pages = [Home(), Videos(), ForgetPassword(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                    child: Row(
                      children: [
                        ProfilePicture(
                          image: "https://thispersondoesnotexist.com",
                          size: 44,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Hi, Jenny",
                          style: AppTexts.tlgm.copyWith(
                            color: AppColors.gray.shade100,
                          ),
                        ),
                      ],
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
              Get.to(() => Notifications());
            },
            child: SizedBox(
              height: 32,
              width: 32,
              child: Center(
                child: index == 2
                    ? CustomSvg(asset: AppIcons.menu)
                    : CustomSvg(asset: AppIcons.notification),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
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
}
