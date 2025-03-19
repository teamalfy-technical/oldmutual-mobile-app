import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:pinput/pinput.dart';

class PCustomPinput extends StatelessWidget {
  final Function(String) onCompleted;
  final PinputAutovalidateMode pinputAutovalidateMode;
  PCustomPinput({
    super.key,
    required this.onCompleted,
    this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
  });

  final defaultPinTheme = PinTheme(
    width: PAppSize.s60,
    height: PAppSize.s56,
    margin: EdgeInsets.symmetric(horizontal: PAppSize.s6),
    textStyle: TextStyle(
      fontSize: PAppSize.s18,
      // color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: PAppColor.fillColor),
      borderRadius: BorderRadius.circular(PAppSize.s10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: PAppColor.primary),
      borderRadius: BorderRadius.circular(PAppSize.s10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: PAppColor.offWhiteColor,
      ),
    );
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: pinputAutovalidateMode,
      showCursor: true,

      onCompleted: onCompleted,
      // (pin) => oldmutualLogger.d(pin),
    );
  }
}
