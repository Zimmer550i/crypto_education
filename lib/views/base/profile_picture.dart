import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_education/utils/custom_image_picker.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? image;
  final File? imageFile;
  final bool showLoading;
  final bool isEditable;
  final Function(File)? imagePickerCallback;

  const ProfilePicture({
    super.key,
    this.image,
    this.size = 132,
    this.showLoading = true,
    this.isEditable = false,
    this.imagePickerCallback,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (!isEditable) {
          return;
        }

        File? image = await customImagePicker();

        if (image != null && imagePickerCallback != null) {
          imagePickerCallback!(image);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                : image != null
                ? CachedNetworkImage(
                    imageUrl: image!,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.cyan,
                        highlightColor: AppColors.cyan.shade200,
                        period: Duration(milliseconds: 800),
                        child: Container(
                          height: size,
                          width: size,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.cyan[400]!),
                        ),
                        child: Icon(Icons.error, color: AppColors.cyan[400]!),
                      );
                    },
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: size,
                    height: size,
                    padding: EdgeInsets.all(size * 0.17),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cyan[300]!),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.user,
                        colorFilter: ColorFilter.mode(
                          AppColors.cyan[400]!,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
          ),
          if (isEditable)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((30 * 2.55).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomSvg(asset: AppIcons.camera, size: 32),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
