import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Outlined Button Themes
class PTextFormFieldTheme {
  PTextFormFieldTheme._();

  /// -- Light Theme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: PAppColor.greyColor,
    suffixIconColor: PAppColor.greyColor,
    focusColor: PAppColor.primary,
    contentPadding: const EdgeInsets.symmetric(vertical: PAppSize.s10),
    labelStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      color: PAppColor.text300,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s14,
      fontWeight: FontWeight.w300,
      color: PAppColor.hintTextColor,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      color: PAppColor.errorColor,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: PAppColor.blackColor.withOpacityExt(PAppSize.s0_8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.primary,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.errorColor,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.warning500,
      ),
    ),
  );

  /// -- Dark Theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: PAppColor.greyColor,
    suffixIconColor: PAppColor.greyColor,
    focusColor: PAppColor.primary,
    contentPadding: const EdgeInsets.symmetric(vertical: PAppSize.s10),
    labelStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      color: PAppColor.text300,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s14,
      fontWeight: FontWeight.w300,
      color: PAppColor.hintTextColor,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      color: PAppColor.errorColor,
    ),
    floatingLabelStyle: const TextStyle().copyWith(color: PAppColor.text300),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.primary,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.errorColor,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s5),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.warning500,
      ),
    ),
  );
}
