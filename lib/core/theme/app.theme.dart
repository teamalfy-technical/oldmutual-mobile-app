import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/theme/theme.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

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
    textSelectionTheme: TextSelectionThemeData(cursorColor: PAppColor.primary),
  );
}
