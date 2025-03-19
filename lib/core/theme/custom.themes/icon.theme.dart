import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// -- Light & Dark Chip Themes
class PIconTheme {
  PIconTheme._();

  /// -- Light Theme
  static IconThemeData lightIconThemeData = IconThemeData(
    color: PAppColor.blackColor,
  );

  /// -- Dark Theme
  static IconThemeData darkIconThemeData = const IconThemeData(
    color: PAppColor.whiteColor,
  );
}
