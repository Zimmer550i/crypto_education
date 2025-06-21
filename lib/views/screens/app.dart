import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:crypto_education/views/screens/chat.dart';
import 'package:crypto_education/views/screens/home.dart';
import 'package:crypto_education/views/screens/notifications.dart';
import 'package:crypto_education/views/screens/profile/profile.dart';
import 'package:crypto_education/views/screens/videos.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController();
  final List<Widget> pages = [Home(), Videos(), Chat(), Profile()];

  int index = 0;
  bool showingHistory = false;

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
              if (index == 2) {
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
                    : CustomSvg(asset: AppIcons.notification),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.gray.shade800,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: showingHistory
                ? Column(
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showingHistory = false;
                          });
                        },
                        child: options(AppIcons.arrowLeft, "History"),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.gray.shade100,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < 20; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                    right: 24,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.gray.shade700,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Chat Name",
                                          style: AppTexts.tmdr.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: PopupMenuButton(
                                            padding: EdgeInsets.zero,
                                            iconColor: AppColors.gray.shade200,
                                            color: AppColors.gray.shade700,
                                            elevation: 10,
                                            shadowColor: Colors.black,
                                            icon: CustomSvg(
                                              asset: AppIcons.more,
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  child: options(
                                                    AppIcons.rename,
                                                    "Rename",
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  child: options(
                                                    AppIcons.delete,
                                                    "Delete",
                                                  ),
                                                ),
                                              ];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    spacing: 24,
                    children: [
                      options(AppIcons.edit, "New Chat"),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showingHistory = true;
                          });
                        },
                        child: options(AppIcons.history, "History"),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.gray.shade100,
                      ),
                      options(AppIcons.terms, "Terms"),
                      options(AppIcons.privacy2, "Privacy"),
                      options(AppIcons.settings, "Settings"),
                    ],
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
          style: AppTexts.tmdr.copyWith(color: AppColors.gray.shade100),
        ),
      ],
    );
  }
}
