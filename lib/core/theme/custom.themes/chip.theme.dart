import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Chip Themes
class PChipTheme {
  PChipTheme._();

  /// -- Light Theme
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: PAppColor.greyColor.withOpacityExt(PAppSize.s0_4),
    labelStyle: const TextStyle(color: PAppColor.blackColor),
    selectedColor: PAppColor.primary,
    padding: const EdgeInsets.symmetric(
      horizontal: PAppSize.s12,
      vertical: PAppSize.s12,
    ),
    checkmarkColor: PAppColor.whiteColor,
  );

  /// -- Dark Theme
  static ChipThemeData darkChipThemeData = const ChipThemeData(
    disabledColor: PAppColor.greyColor,
    labelStyle: TextStyle(color: PAppColor.whiteColor),
    selectedColor: PAppColor.primary,
    padding: EdgeInsets.symmetric(
      horizontal: PAppSize.s12,
      vertical: PAppSize.s12,
    ),
    checkmarkColor: PAppColor.whiteColor,
  );
}
