import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Outlined Button Themes
class POutlinedButtonTheme {
  POutlinedButtonTheme._();

  /// -- Light Theme
  static final OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: PAppSize.s0,
          foregroundColor: PAppColor.blackColor,
          side: const BorderSide(color: PAppColor.primary),
          minimumSize: const Size.fromHeight(PAppSize.buttonHeightMid),
          // padding: const EdgeInsets.symmetric(
          //   vertical: PAppSize.s16,
          //   horizontal: PAppSize.s20,
          // ),
          textStyle: const TextStyle(
            fontSize: PAppSize.s16,
            color: PAppColor.blackColor,
            letterSpacing: PAppSize.s0,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PAppSize.s8),
          ),
        ),
      );

  /// -- Dark Theme
  static final OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: PAppSize.s0,
          foregroundColor: PAppColor.whiteColor,
          side: const BorderSide(color: PAppColor.primary),
          minimumSize: const Size.fromHeight(PAppSize.buttonHeightMid),
          // padding: const EdgeInsets.symmetric(
          //   vertical: PAppSize.s16,
          //   horizontal: PAppSize.s20,
          // ),
          textStyle: const TextStyle(
            fontSize: PAppSize.s16,
            color: PAppColor.whiteColor,
            letterSpacing: PAppSize.s0,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PAppSize.s8),
          ),
        ),
      );
}
