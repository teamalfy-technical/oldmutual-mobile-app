import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PDropdownButtonTheme {
  PDropdownButtonTheme._();

  /// -- Light Theme
  static DropdownMenuThemeData lightDropdownMenuTheme = DropdownMenuThemeData(
    textStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w400,
      color: PAppColor.text700,
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(PAppColor.transparentColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,
      fillColor: PAppColor.fillColor2,
      filled: true,
      prefixIconColor: PAppColor.greyColor,
      suffixIconColor: PAppColor.greyColor,
      // focusColor: PAppColor.primary,
      contentPadding: const EdgeInsets.symmetric(
        vertical: PAppSize.s0,
        horizontal: PAppSize.s10,
      ),
      labelStyle: const TextStyle().copyWith(
        fontSize: PAppSize.s16,
        color: PAppColor.text300,
      ),
      hintStyle: const TextStyle().copyWith(
        fontSize: PAppSize.s16,
        fontWeight: FontWeight.w400,
        color: PAppColor.text300,
      ),
      errorStyle: const TextStyle().copyWith(
        fontStyle: FontStyle.normal,
        color: PAppColor.alert500,
      ),
      floatingLabelStyle: const TextStyle().copyWith(
        color: PAppColor.blackColor.withOpacityExt(PAppSize.s0_8),
      ),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
    ),
  );

  /// -- Dark Theme
  static DropdownMenuThemeData darkDropdownMenuTheme = DropdownMenuThemeData(
    textStyle: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w400,
      color: PAppColor.fillColor,
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(PAppColor.lightBlackColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      prefixIconColor: PAppColor.greyColor,
      suffixIconColor: PAppColor.greyColor,
      fillColor: PAppColor.lightBlackColor,
      filled: true,
      // focusColor: PAppColor.primary,
      contentPadding: const EdgeInsets.symmetric(
        vertical: PAppSize.s17,
        horizontal: PAppSize.s10,
      ),
      labelStyle: const TextStyle().copyWith(
        fontSize: PAppSize.s16,
        color: PAppColor.text300,
      ),
      hintStyle: const TextStyle().copyWith(
        fontSize: PAppSize.s16,
        fontWeight: FontWeight.w400,
        color: PAppColor.text300,
      ),
      errorStyle: const TextStyle().copyWith(
        fontStyle: FontStyle.normal,
        color: PAppColor.alert500,
      ),
      floatingLabelStyle: const TextStyle().copyWith(color: PAppColor.text300),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(PAppSize.s5),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
