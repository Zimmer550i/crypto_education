import 'package:crypto_education/utils/app_colors.dart';
import 'package:get/get.dart';

void customSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    colorText: AppColors.gray.shade100,
    backgroundColor: AppColors.cyan.withValues(alpha: 0.2),
  );
}
