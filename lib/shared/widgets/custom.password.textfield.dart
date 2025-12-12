import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PCustomPasswordTextField extends StatefulWidget {
  final String labelText;
  // final String? titleText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? focusColor;
  final TextEditingController controller;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final Function()? onObscureChanged;
  // final bool isPasswordStrong;
  // final EdgeInsetsGeometry? contentPadding;
  // final String? hintText;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  const PCustomPasswordTextField({
    super.key,
    // required this.labelText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusColor,
    required this.controller,
    this.obscure = true,
    this.textInputType = TextInputType.text,
    this.onObscureChanged,
    this.onChanged,
    // this.isPasswordStrong = false,
    this.validator,
    this.autovalidateMode,
    this.errorText,
    // this.titleText,
    // this.border,
    // this.enabledBorder,
    // this.focusedBorder,
    // this.contentPadding,
    // this.hintText,
    // this.errorBorder,
    // this.focusedErrorBorder,
  });

  @override
  State<PCustomPasswordTextField> createState() =>
      _PCustomPasswordTextFieldState();
}

class _PCustomPasswordTextFieldState extends State<PCustomPasswordTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (widget.titleText != null) ...[
        //   Text(
        //     widget.titleText ?? '',
        //     textAlign: TextAlign.start,
        //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        //       fontSize: PAppSize.s13,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        //   // PAppSize.s4.verticalSpace,
        // ],
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.obscure,
          validator: widget.validator,

          //?? PValidator.validatePassword,
          onChanged: widget.onChanged,
          autovalidateMode: widget.autovalidateMode,
          style: TextStyle(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.whiteColor
                : PAppColor.text500,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            // contentPadding: widget.contentPadding,
            errorText: widget.errorText,
            label:
                // widget.labelText == null
                //     ? null
                //     :
                Text(
                  widget.labelText,
                  style: TextStyle(
                    color: _focusNode.hasFocus
                        ? PAppColor.primaryBorderColor
                        : PAppColor.hintTextColor,
                  ),
                ),
            // border: widget.border,
            // enabledBorder: widget.enabledBorder,
            // focusedBorder: widget.focusedBorder,
            // errorBorder: widget.errorBorder,
            // focusedErrorBorder: widget.focusedErrorBorder,

            // errorBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(PAppSize.s8),
            //   borderSide: BorderSide(width: PAppSize.s1),
            // ),
            // focusedErrorBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(PAppSize.s8),
            //   borderSide: BorderSide(width: PAppSize.s1),
            // ),
            focusColor: widget.focusColor,
            // prefixIcon: prefixIcon
            //     .svg(
            //       color: PHelperFunction.isDarkMode(context)
            //           ? PAppColor.whiteColor
            //           : PAppColor.blackColor,
            //     )
            //     .symmetric(horizontal: PAppSize.s16),
            suffixIcon:
                widget.suffixIcon ??
                IconButton(
                  onPressed: widget.onObscureChanged,
                  icon: widget.obscure
                      ? Assets.icons.visibilityOff.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.text300,
                        )
                      : Assets.icons.visibilityOn.svg(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.text300,
                        ),
                ),
            // hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
