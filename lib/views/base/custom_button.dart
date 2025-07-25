import 'package:crypto_education/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_education/utils/app_texts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool isSecondary;
  final bool isDisabled;
  final double? height;
  final double? width;
  final bool isLoading;
  final String? leading;
  final String? trailing;
  final double padding;
  final double radius;
  final double? fontSize;
  final double iconSize;
  final bool coloredIcon;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    this.padding = 40,
    this.radius = 99,
    this.isSecondary = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.fontSize,
    this.coloredIcon = false,
    this.iconSize = 24,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        decoration: BoxDecoration(
          color: widget.isSecondary
              ? null
              : widget.isDisabled
              ? AppColors.cyan.shade700
              : AppColors.cyan.shade300,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.isSecondary ? Border.all(color: AppColors.cyan) : null,
        ),
        child: widget.isLoading
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: widget.isSecondary
                        ? AppColors.cyan
                        : AppColors.cyan[50],
                    strokeWidth: 4,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  if (widget.leading != null)
                    SvgPicture.asset(
                      widget.leading!,
                      height: widget.iconSize,
                      width: widget.iconSize,
                      colorFilter: widget.coloredIcon
                          ? null
                          : ColorFilter.mode(
                              widget.isSecondary
                                  ? AppColors.cyan
                                  : AppColors.cyan.shade900,
                              BlendMode.srcIn,
                            ),
                    ),
                  Text(
                    widget.text,
                    style: AppTexts.tlgm.copyWith(
                      fontSize: widget.fontSize,
                      color: widget.isSecondary
                          ? AppColors.cyan.shade300
                          : AppColors.cyan.shade900,
                    ),
                  ),
                  if (widget.trailing != null)
                    SvgPicture.asset(
                      widget.trailing!,
                      height: widget.iconSize,
                      width: widget.iconSize,
                      colorFilter: ColorFilter.mode(
                        widget.isSecondary
                            ? AppColors.cyan
                            : AppColors.cyan.shade900,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
