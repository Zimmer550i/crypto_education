import 'package:crypto_education/views/base/video_card.dart';
import 'package:flutter/material.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
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
