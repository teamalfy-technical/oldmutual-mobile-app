import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAppBarTheme {
  PAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: PAppSize.s0,
    centerTitle: true,
    scrolledUnderElevation: PAppSize.s0,
    backgroundColor: PAppColor.transparentColor,
    surfaceTintColor: PAppColor.transparentColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarColor: PAppColor.transparentColor,
    //   systemNavigationBarColor: PAppColor.whiteColor,
    //   systemNavigationBarIconBrightness: Brightness.light,
    //   systemNavigationBarDividerColor: PAppColor.transparentColor,
    // ),
    iconTheme: IconThemeData(color: PAppColor.blackColor, size: PAppSize.s24),
    actionsIconTheme: IconThemeData(
      color: PAppColor.textColorLight,
      size: PAppSize.s24,
    ),
    titleTextStyle: TextStyle(
      fontSize: PAppSize.s17,
      fontWeight: FontWeight.w600,
      color: PAppColor.textColorLight,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: PAppSize.s0,
    centerTitle: true,
    scrolledUnderElevation: PAppSize.s0,
    backgroundColor: PAppColor.transparentColor,
    surfaceTintColor: PAppColor.transparentColor,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: PAppColor.blackColor, size: PAppSize.s24),
    actionsIconTheme: IconThemeData(
      color: PAppColor.whiteColor,
      size: PAppSize.s24,
    ),
    titleTextStyle: TextStyle(
      fontSize: PAppSize.s17,
      fontWeight: FontWeight.w600,
      color: PAppColor.whiteColor,
    ),
  );
}
