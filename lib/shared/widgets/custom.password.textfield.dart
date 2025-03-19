import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomPasswordTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String prefixIcon;
  final String? suffixIcon;
  final Color? focusColor;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? textInputType;
  final Function()? onObscureChanged;
  final bool isPasswordStrong;
  final void Function(String)? onChanged;
  const PCustomPasswordTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.focusColor,
    required this.controller,
    this.obscure = true,
    this.textInputType = TextInputType.text,
    this.onObscureChanged,
    this.onChanged,
    this.isPasswordStrong = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s14,
            fontWeight: FontWeight.w600,
          ),
        ),
        PAppSize.s6.verticalSpace,
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: PValidator.validatePassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            errorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(PAppSize.s8),
              borderSide: BorderSide(
                width: PAppSize.s1,
                color:
                    isPasswordStrong
                        ? PAppColor.primary
                        : controller.text.isNotEmpty
                        ? PAppColor.warning500
                        : PAppColor.alert500,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(PAppSize.s8),
              borderSide: BorderSide(
                width: PAppSize.s1,
                color:
                    isPasswordStrong
                        ? PAppColor.primary
                        : controller.text.isNotEmpty
                        ? PAppColor.warning500
                        : PAppColor.alert500,
              ),
            ),
            errorStyle: TextStyle(
              color:
                  isPasswordStrong
                      ? PAppColor.primary
                      : controller.text.isNotEmpty
                      ? PAppColor.warning500
                      : PAppColor.alert500,
            ),
            focusColor: focusColor,
            prefixIcon: prefixIcon
                .svg(
                  color:
                      PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.blackColor,
                )
                .symmetric(horizontal: PAppSize.s16),
            suffixIcon:
                suffixIcon == null
                    ? null
                    : IconButton(
                      onPressed: onObscureChanged,
                      icon: suffixIcon!.svg(
                        color:
                            obscure ? PAppColor.blackColor : PAppColor.primary,
                      ),
                    ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
