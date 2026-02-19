import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PAppColor {
  PAppColor._();

  // App Basic Colors
  static const Color primary = Color(0xFF50B848);
  static const Color primaryLight = Color(0xFFDCF1DA);
  static const Color primaryDark = Color(0xFF009979);
  static const Color primaryRest = Color(0xFFB9E2B6);
  static const Color primaryBorderColor = Color(0xFF96D491);
  static const Color primary950 = Color(0xFFD9E7E3);
  static const Color primaryBorderLight = Color(0xFFF6FFED);

  static const Color greyColorShade300 = Color(0xFFE0E0E0);
  static const Color greyColorShade100 = Color(0xFFf5f5f5);

  static const Color fillColor2 = Color(0xFFCCCCCC);
  static const Color fillColor = Color(0xFFF2F2F2);
  static const Color fillColor3 = Color(0xFFF9F9F9);
  static const Color fillColor4 = Color(0xFFE5E5E5);

  static const Color orangeColor = Color(0xFFF5823D);
  static const Color yellowColor = Color(0xFFFFDD1A);
  static const Color lightBlueColor = Color(0xFFD1D9FA);

  // Dark theme colors

  static const Color darkAppBarColor2 = Color(0xFF58507C);
  static const Color darkAppBarColor = Color(0xFF2D293D);
  static const Color darkBgColor = Color(0xFF16141F);
  static const Color darkBorderColor = Color(0xFFB4B4B4);
  static const Color secondary500 = Color(0xFFC5C1D7);
  static const Color cardDarkColor = Color(0xFF252133);

  static const Color secondary700 = Color(0xFFA8A2C3);
  static const Color secondary900 = Color(0xFFE2E0EB);
  static const Color textDisabledColor = Color(0xFFA7A7AC);
  static const Color textGrayColor = Color(0xFFCCCCCC);

  // for dark theme colors
  static const Color blackColor = Color(0xFF1A1A1A);
  static const Color lightBlackColor = Color(0xFF1f1f1f);

  static const Color shadowColor = Color(0xFF151313);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color offWhiteColor = Color(0xFFF1F1F1);

  static const Color greyColor = Colors.grey;

  static const Color blackColor12 = Colors.black12;
  static const Color transparentColor = Colors.transparent;
  static const Color errorColor = Color(0xFFfa4b69);
  static const Color focusedErrorColor = Color(0xFFE4A11B);

  // Gold
  static const Color darkGold = Color(0xFFD4AF37);
  static const Color lightGold = Color(0xFFF4E5B0);

  // bars color
  static const Color voiletLight = Color(0xF08061DB);
  static const Color voiletDark = Color(0x618061DB);

  // Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = PAppColor.whiteColor.withOpacityExt(
    PAppSize.s0_1,
  );

  // Button Colors
  static const Color buttonPrimary = PAppColor.primary;
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);
  static const Color darkGrey = Color(0xFF1F1F1F);

  // Text Colors
  static const Color primaryTextColor = Color(0xFF245920);
  static const Color text50 = Color(0xFFF5F5F5);
  static const Color text100 = Color(0xFFC0BEBE);
  static const Color text200 = Color(0xFFA8A8A8);
  static const Color text300 = Color(0xFF767272);
  static const Color text500 = Color(0xFF585757);
  static const Color text700 = Color(0xFF151313);
  static const Color hintTextColor = Color(0xFF747474);

  static const Color textColorLight = Color(0xFF1E1E1E);
  static const Color textColorDark = Color(0xFF000000);

  // Alert Colors
  static const Color alert50 = Color(0xFFFCEDF0);
  static const Color alert100 = Color(0xFFE88797);
  static const Color alert300 = Color(0xFFdc4c64);
  static const Color alert500 = Color(0xFFc8455b);
  static const Color alert700 = Color(0xFF9c3647);

  static const Color redColor = Color(0xFFFF0000);
  static const Color badgeColor = Color(0xFFE70C36);

  // Warning Colors
  static const Color warning50 = Color(0xFFfcf6e8);
  static const Color warning100 = Color(0xFFf3d496);
  static const Color warning300 = Color(0xFFedc066);
  static const Color warning500 = Color(0xFFe4a11b);
  static const Color warning700 = Color(0xFFa27213);

  // Success Colors
  static const Color success50 = Color(0xFFe8f6ed);
  static const Color success100 = Color(0xFF93d5ad);
  static const Color success300 = Color(0xFF62c288);
  static const Color success500 = Color(0xFF14a44d);
  static const Color success700 = Color(0xFF0e7437);

  static const Color successDark = Color(0xFF306E2B);
  static const Color successMedium = Color(0xFF3F9339);
  static const Color successLight = Color(0xFF96D491);

  // Info Colors
  static const Color info50 = Color(0xFFefeafc);
  static const Color info100 = Color(0xFFb49df2);
  static const Color info300 = Color(0xFF9271ec);
  static const Color info500 = Color(0xFF5c2be2);
  static const Color info700 = Color(0xFF411fa0);

  static final primaryGradient = LinearGradient(
  colors: [PAppColor.primaryDark, PAppColor.primary],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
}



final borderRadius = BorderRadius.only(
  topLeft: Radius.circular(PAppSize.s6),
  topRight: Radius.circular(PAppSize.s6),
);
