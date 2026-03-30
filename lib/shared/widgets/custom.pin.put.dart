import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:pinput/pinput.dart';

class PCustomPinput extends StatelessWidget {
  final Function(String) onCompleted;
  final int length;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final PinputAutovalidateMode pinputAutovalidateMode;
  PCustomPinput({
    super.key,
    required this.onCompleted,
    this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
    this.length = 6,
    this.textInputAction,
    this.focusNode,
  });

  final defaultPinTheme = PinTheme(
    width: PAppSize.s60,
    height: PAppSize.s72,
    margin: EdgeInsets.symmetric(horizontal: PAppSize.s2),
    padding: EdgeInsets.zero,
    textStyle: TextStyle(
      fontSize: PAppSize.s18,
      // color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: PAppColor.darkAppBarColor2),
      borderRadius: BorderRadius.circular(PAppSize.s12),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(width: PAppSize.s2, color: PAppColor.primary),
      borderRadius: BorderRadius.circular(PAppSize.s12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: PAppColor.transparentColor,
      ),
    );
    return Pinput(
      length: length,
      focusNode: focusNode,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: pinputAutovalidateMode,
      textInputAction: textInputAction,
      showCursor: true,
      onCompleted: onCompleted,
      // (pin) => oldmutualLogger.d(pin),
    );
  }
}
