import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Elevated Button Themes
class PElevatedButtonTheme {
  PElevatedButtonTheme._();

  /// -- Light Theme
  static final ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: PAppSize.s0,
          foregroundColor: PAppColor.whiteColor,
          backgroundColor: PAppColor.primary,
          disabledForegroundColor: PAppColor.greyColor,
          disabledBackgroundColor: PAppColor.greyColor,
          side: const BorderSide(color: PAppColor.primary),
          minimumSize: const Size.fromHeight(PAppSize.buttonHeight),
          // padding: const EdgeInsets.symmetric(
          //     vertical: TAppSize.s18, horizontal: TAppSize.s20),
          textStyle: const TextStyle(
            fontSize: PAppSize.s16,
            color: PAppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PAppSize.s8),
          ),
        ),
      );

  /// -- Dark Theme
  static final ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: PAppSize.s0,
          foregroundColor: PAppColor.blackColor,
          backgroundColor: PAppColor.primary,
          disabledForegroundColor: PAppColor.greyColor,
          disabledBackgroundColor: PAppColor.greyColor,
          side: const BorderSide(color: PAppColor.primary),
          minimumSize: const Size.fromHeight(PAppSize.buttonHeight),
          padding: const EdgeInsets.symmetric(
            vertical: PAppSize.s18,
            horizontal: PAppSize.s20,
          ),
          textStyle: const TextStyle(
            fontSize: PAppSize.s16,
            color: PAppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PAppSize.s8),
          ),
        ),
      );
}
