import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_education/utils/app_texts.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? errorText;
  final String? leading;
  final String? trailing;
  final TextInputType? textInputType;
  final bool isDisabled;
  final double radius;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final bool isPassword;
  final int lines;
  final void Function()? onTap;
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    this.leading,
    this.trailing,
    this.isPassword = false,
    this.isDisabled = false,
    this.radius = 12,
    this.lines = 1,
    this.textInputType,
    this.controller,
    this.onTap,
    this.errorText,
    this.height = 50,
    this.width,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = false;
  bool isFocused = false;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(widget.title!, style: AppTexts.tlgs),
          ),
        GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            } else {
              if (!widget.isDisabled) {
                focusNode.requestFocus();
              }
            }
          },
          child: Container(
            height: widget.lines == 1 ? widget.height : null,
            width: widget.width,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: widget.lines == 1 ? 0 : 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.gray[700],
              borderRadius: BorderRadius.circular(widget.radius),
              border: isFocused
                  ? Border.all(color: AppColors.cyan)
                  : Border.all(width: 0),
            ),
            child: Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leading != null)
                  SvgPicture.asset(
                    widget.leading!,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.cyan,
                      BlendMode.srcIn,
                    ),
                  ),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: widget.controller,
                    maxLines: widget.lines,
                    cursorColor: AppColors.cyan,
                    keyboardType: widget.textInputType,
                    obscureText: isObscured,
                    enabled: !widget.isDisabled && widget.onTap == null,
                    onTapOutside: (event) {
                      setState(() {
                        isFocused = false;
                        focusNode.unfocus();
                      });
                    },
                    style: AppTexts.tmdr.copyWith(
                      color: AppColors.gray.shade100,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: AppTexts.tsmr.copyWith(
                        color: AppColors.gray[400],
                      ),
                    ),
                  ),
                ),
                if (widget.trailing != null)
                  SvgPicture.asset(
                    widget.trailing!,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      isFocused ? AppColors.cyan : AppColors.gray.shade100,
                      BlendMode.srcIn,
                    ),
                  ),
                if (widget.isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: SvgPicture.asset(
                      isObscured ? AppIcons.eyeOff : AppIcons.eye,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        isFocused ? AppColors.cyan : AppColors.gray.shade100,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.red,
              ),
            ),
          ),
      ],
    );
  }
}
