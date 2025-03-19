import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PSliderTheme {
  PSliderTheme._();

  static SliderThemeData lightSliderTheme = SliderThemeData(
    trackHeight: PAppSize.s8,
    trackShape: const RoundedRectSliderTrackShape(),
    activeTrackColor: PAppColor.primary,
    inactiveTrackColor: PAppColor.text50,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: PAppSize.s14,
      pressedElevation: PAppSize.s8,
    ),
    thumbColor: PAppColor.text500,
    overlayColor: PAppColor.text500.withOpacityExt(PAppSize.s0_2),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: PAppSize.s32),
    tickMarkShape: const RoundSliderTickMarkShape(),
    activeTickMarkColor: PAppColor.whiteColor,
    inactiveTickMarkColor: PAppColor.text100,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: PAppColor.blackColor,
    valueIndicatorTextStyle: const TextStyle(
      color: PAppColor.whiteColor,
      fontSize: PAppSize.s20,
    ),
  );

  static SliderThemeData darkSliderTheme = SliderThemeData(
    trackHeight: PAppSize.s8,
    trackShape: const RoundedRectSliderTrackShape(),
    activeTrackColor: PAppColor.primary,
    inactiveTrackColor: PAppColor.text50,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: PAppSize.s14,
      pressedElevation: PAppSize.s8,
    ),
    thumbColor: PAppColor.text500,
    overlayColor: PAppColor.text500.withOpacityExt(PAppSize.s0_2),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: PAppSize.s32),
    tickMarkShape: const RoundSliderTickMarkShape(),
    activeTickMarkColor: PAppColor.whiteColor,
    inactiveTickMarkColor: PAppColor.text100,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: PAppColor.blackColor,
    valueIndicatorTextStyle: const TextStyle(
      color: PAppColor.whiteColor,
      fontSize: PAppSize.s20,
    ),
  );
}
