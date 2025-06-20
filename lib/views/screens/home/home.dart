import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/views/base/live_card.dart';
import 'package:crypto_education/views/base/video_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hasLive = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              if (hasLive)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Live Class",
                    style: AppTexts.tmdm.copyWith(
                      color: AppColors.gray.shade50,
                    ),
                  ),
                ),
              if (hasLive)
                for (int i = 0; i < 1; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: LiveCard(),
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "Featured Topics",
                  style: AppTexts.tmdm.copyWith(color: AppColors.gray.shade50),
                ),
              ),
              for (int i = 0; i < 20; i++)
                Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 12),
                  child: VideoCard(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}