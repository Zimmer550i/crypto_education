import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/custom_bottom_navbar.dart';
import 'package:crypto_education/views/screens/auth/forget_password.dart';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:crypto_education/views/screens/auth/signup.dart';
import 'package:crypto_education/views/screens/profile/profile.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final controller = PageController();
  int index = 0;
  final List<Widget> pages = [
    Signin(key: PageStorageKey("1")),
    Signup(),
    ForgetPassword(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 0
                ? FlutterLogo()
                : Image.asset("assets/images/appbar_logo.png", height: 40),
            index == 2
                ? CustomSvg(asset: AppIcons.menu)
                : CustomSvg(asset: AppIcons.notification),
          ],
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
}
