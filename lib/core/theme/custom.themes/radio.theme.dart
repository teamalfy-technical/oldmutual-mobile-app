import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Radio Themes
class PRadioTheme {
  PRadioTheme._();

  /// -- Light Theme
  static RadioThemeData lightRadioThemeData = RadioThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    splashRadius: PAppSize.s24,
    visualDensity: VisualDensity.compact,
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.primary;
      }
      return PAppColor.text500; //
    }),
  );

  /// -- Dark Theme
  static RadioThemeData darkRadioThemeData = RadioThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    splashRadius: PAppSize.s24,
    visualDensity: VisualDensity.compact,
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return PAppColor.primary;
      }
      return PAppColor.text500; //
    }),
  );
}
