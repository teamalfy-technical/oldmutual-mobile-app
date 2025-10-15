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
    focusColor: PAppColor.primaryBorderColor,
    contentPadding: const EdgeInsets.symmetric(
      vertical: PAppSize.s16,
      horizontal: PAppSize.s16,
    ),

    labelStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      color: PAppColor.text300,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w500,
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
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor2,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.fillColor2,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.primaryBorderColor,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.errorColor,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.errorColor,
      ),
    ),
  );

  /// -- Dark Theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: PAppColor.greyColor,
    suffixIconColor: PAppColor.greyColor,
    focusColor: PAppColor.primaryBorderColor,
    contentPadding: const EdgeInsets.symmetric(
      vertical: PAppSize.s16,
      horizontal: PAppSize.s16,
    ),
    labelStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      color: PAppColor.text300,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w500,
      color: PAppColor.hintTextColor,
    ),
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal,
      color: PAppColor.errorColor,
    ),
    floatingLabelStyle: const TextStyle().copyWith(color: PAppColor.text300),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.darkBorderColor,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s1,
        color: PAppColor.darkBorderColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.primaryBorderColor,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.errorColor,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(PAppSize.s8),
      borderSide: const BorderSide(
        width: PAppSize.s2,
        color: PAppColor.errorColor,
      ),
    ),
  );
}
