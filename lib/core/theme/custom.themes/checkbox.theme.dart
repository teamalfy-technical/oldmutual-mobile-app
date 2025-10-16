import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Checkbox Themes
class PCheckboxTheme {
  PCheckboxTheme._();

  /// -- Light Theme
  static CheckboxThemeData lightCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PAppSize.s4),
    ),

    side: BorderSide(width: PAppSize.s2, color: PAppColor.blackColor),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.whiteColor;
      } else {
        return PAppColor.blackColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.primary;
      } else {
        return PAppColor.transparentColor;
      }
    }),
  );

  /// -- Dark Theme
  static CheckboxThemeData darkCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PAppSize.s4),
    ),
    side: BorderSide(width: PAppSize.s2, color: PAppColor.whiteColor),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.whiteColor;
      } else {
        return PAppColor.blackColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.primary;
      } else {
        return PAppColor.transparentColor;
      }
    }),
  );
}
