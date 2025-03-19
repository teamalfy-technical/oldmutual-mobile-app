import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

import '../../gen/assets.gen.dart';

class PPopupDialog {
  PPopupDialog(this.context);
  final BuildContext context;

  void successMessage(String message, [int? duration]) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.lightBlackColor
              : PAppColor.success50,
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: PAppSize.s16),
        child: Icon(
          Icons.check_circle,
          color: PAppColor.success700,
          size: PAppSize.s22,
        ),
      ),
      messageColor: PAppColor.success700,
      message: message,
      duration: Duration(milliseconds: duration ?? PAppSize.s2500),
    ).show(context);
  }

  void errorMessage(String title, String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.lightBlackColor
              : PAppColor.whiteColor,
      icon: Assets.icons.warningIcon.svg(
        color:
            PHelperFunction.isDarkMode(context)
                ? PAppColor.whiteColor
                : PAppColor.blackColor,
      ),
      // leftBarIndicatorColor: PAppColor.errorColor,
      title: title,
      padding: EdgeInsets.all(PAppSize.s20),
      titleSize: PAppSize.s16,
      titleColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.blackColor,
      messageColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.blackColor,
      message: message,
      duration: const Duration(milliseconds: PAppSize.s4000),
    ).show(context);
  }

  void warningMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.lightBlackColor
              : PAppColor.warning50,
      icon: const Icon(
        Icons.error,
        color: PAppColor.warning700,
        size: PAppSize.s24,
      ),
      shouldIconPulse: false,
      messageColor: PAppColor.warning700,
      message: message,
      duration: const Duration(milliseconds: PAppSize.s3000),
    ).show(context);
  }

  void informationMessage(String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor:
          PHelperFunction.isDarkMode(context)
              ? PAppColor.lightBlackColor
              : PAppColor.info50,
      icon: const Icon(
        Icons.error,
        color: PAppColor.info700,
        size: PAppSize.s24,
      ),
      shouldIconPulse: false,
      messageColor: PAppColor.info700,
      message: message,
      duration: const Duration(milliseconds: PAppSize.s5000),
    ).show(context);
  }

  void unVerifiedSnack() {
    // return PopupDialogs(context).snackPopup(
    //   status: RequestStatus.info,
    //   message: 'Verify your account to be able to perform this action.',
    // );
  }

  void comingSoonSnack([String? message]) {
    informationMessage('We are still baking this feature');
  }
}
