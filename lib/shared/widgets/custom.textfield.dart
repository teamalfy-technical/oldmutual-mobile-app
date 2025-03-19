import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String prefixIcon;
  final String? suffixIcon;
  final Color? focusColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const PCustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.focusColor,
    required this.controller,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
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
          validator: validator,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          decoration: InputDecoration(
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
                      onPressed: () {},
                      icon: suffixIcon!.svg(color: focusColor),
                    ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
