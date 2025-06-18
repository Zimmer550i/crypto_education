import 'dart:ui';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/views/screens/auth/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final waitTime = Duration(seconds: 2);
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: waitTime);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {});
        if (_animation.isCompleted) {
          Get.off(() => Onboard(), transition: Transition.fadeIn);
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -59 + (MediaQuery.of(context).size.width * _animation.value),
            top: -130 + (100 * _animation.value),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX:
                    311 +
                    (_animation.value % 2 == 0 ? 0 : 300 * _animation.value),
                sigmaY:
                    311 +
                    (_animation.value % 2 == 0 ? 0 : 300 * _animation.value),
              ),
              child: Container(
                height: 321,
                width: 321,
                decoration: BoxDecoration(
                  color: AppColors.cyan[300],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width:
                    MediaQuery.of(context).size.width /
                    (2 - (0.5 * _animation.value)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
