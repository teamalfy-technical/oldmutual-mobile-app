import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Checkbox Themes
class PCheckboxTheme {
  PCheckboxTheme._();

  /// -- Light Theme
  static CheckboxThemeData lightCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PAppSize.s2),
    ),
    side: BorderSide.none,
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
        return PAppColor.fillColor2;
      }
    }),
  );

  /// -- Dark Theme
  static CheckboxThemeData darkCheckboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PAppSize.s2),
    ),
    side: BorderSide.none,
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
        return PAppColor.fillColor2;
      }
    }),
  );
}
