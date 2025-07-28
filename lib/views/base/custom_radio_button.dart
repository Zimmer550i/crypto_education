import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool value;
  final String title;
  final void Function() onClick;
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.gray.shade800,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value ? AppColors.cyan.shade300 : Colors.transparent,
          ),
        ),
        child: Row(
          spacing: 8,
          children: [
            CustomSvg(
              asset: "assets/icons/radio_${value ? "" : "un"}selected.svg",
            ),
            Text(title, style: AppTexts.tlgm),
          ],
        ),
      ),
    );
  }
}
