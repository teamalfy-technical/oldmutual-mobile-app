import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PTextTheme {
  PTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    // HeadLine Textstyles
    headlineLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s32,
      fontWeight: FontWeight.bold,
      color: PAppColor.textColorDark,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s24,
      fontWeight: FontWeight.bold,
      color: PAppColor.textColorDark,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: PAppSize.s18,
      fontWeight: FontWeight.w600,
      color: PAppColor.textColorDark,
    ),

    // Title Textstyles
    titleLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w700,
      color: PAppColor.textColorDark,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w600,
      color: PAppColor.textColorDark,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w400,
      color: PAppColor.textColorLight,
    ),

    // Body Textstyles
    bodyLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w400,
      color: PAppColor.textColorDark,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s15,
      fontWeight: FontWeight.normal,
      color: PAppColor.textColorLight,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: PAppSize.s14,
      fontWeight: FontWeight.w400,
      color: PAppColor.textColorLight,
    ),

    // Label Textstyles
    labelLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s12,
      fontWeight: FontWeight.normal,
      color: PAppColor.textColorLight,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s12,
      fontWeight: FontWeight.normal,
      color: PAppColor.textColorLight,
    ),
    //labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacityExt(0.5)),
  );
  static TextTheme darkTextTheme = TextTheme(
    // HeadLine Textstyles
    headlineLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s32,
      fontWeight: FontWeight.bold,
      color: PAppColor.text50,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s24,
      fontWeight: FontWeight.bold,
      color: PAppColor.text50,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: PAppSize.s18,
      fontWeight: FontWeight.w600,
      color: PAppColor.text50,
    ),

    // Title Textstyles
    titleLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w700,
      color: PAppColor.text50,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w600,
      color: PAppColor.text50,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w400,
      color: PAppColor.text50,
    ),

    // Body Textstyles
    bodyLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s16,
      fontWeight: FontWeight.w500,
      color: PAppColor.text50,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s15,
      fontWeight: FontWeight.normal,
      color: PAppColor.text50,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: PAppSize.s14,
      fontWeight: FontWeight.w500,
      color: PAppColor.text50,
    ),

    // Label Textstyles
    labelLarge: const TextStyle().copyWith(
      fontSize: PAppSize.s12,
      fontWeight: FontWeight.normal,
      color: PAppColor.text100,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: PAppSize.s12,
      fontWeight: FontWeight.normal,
      color: PAppColor.text50,
    ),
    //labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white.withOpacityExt(0.5)),
  );
}
