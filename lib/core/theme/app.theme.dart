import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/theme/theme.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

import 'custom.themes/dropdown.button.theme.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: PAppColor.primary,
    scaffoldBackgroundColor: PAppColor.whiteColor,
    appBarTheme: PAppBarTheme.lightAppBarTheme,
    textTheme: PTextTheme.lightTextTheme,
    elevatedButtonTheme: PElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: POutlinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: PCheckboxTheme.lightCheckboxThemeData,
    chipTheme: PChipTheme.lightChipThemeData,
    sliderTheme: PSliderTheme.lightSliderTheme,
    bottomSheetTheme: PBottomSheetTheme.lightBottomSheetThemeData,
    inputDecorationTheme: PTextFormFieldTheme.lightInputDecorationTheme,
    iconTheme: PIconTheme.lightIconThemeData,
    dropdownMenuTheme: PDropdownButtonTheme.lightDropdownMenuTheme,
    radioTheme: PRadioTheme.lightRadioThemeData,
    textSelectionTheme: TextSelectionThemeData(cursorColor: PAppColor.primary),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.dark,
    primaryColor: PAppColor.primary,
    scaffoldBackgroundColor: PAppColor.blackColor,
    appBarTheme: PAppBarTheme.darkAppBarTheme,
    textTheme: PTextTheme.darkTextTheme,
    elevatedButtonTheme: PElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: POutlinedButtonTheme.darkOutlinedButtonTheme,
    checkboxTheme: PCheckboxTheme.darkCheckboxThemeData,
    chipTheme: PChipTheme.darkChipThemeData,
    sliderTheme: PSliderTheme.darkSliderTheme,
    bottomSheetTheme: PBottomSheetTheme.darkBottomSheetThemeData,
    inputDecorationTheme: PTextFormFieldTheme.darkInputDecorationTheme,
    iconTheme: PIconTheme.darkIconThemeData,
    dropdownMenuTheme: PDropdownButtonTheme.darkDropdownMenuTheme,
    radioTheme: PRadioTheme.darkRadioThemeData,
    textSelectionTheme: TextSelectionThemeData(cursorColor: PAppColor.primary),
  );
}
