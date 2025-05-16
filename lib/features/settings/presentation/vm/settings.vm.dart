import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/presentation/vm/notification.vm.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSettingsVm extends GetxController {
  static PSettingsVm get instance => Get.find();

  var notification =
      PSecureStorage().getAuthResponse()?.notificationsEnabled == "True"
          ? true.obs
          : false.obs;

  var submitting = LoadingState.completed.obs;

  updateSubmittingState(LoadingState loadingState) =>
      submitting.value = loadingState;

  final context = Get.context!;

  onNotificationChanged(bool? value) async {
    if (notification.value) {
      await Get.put(PNotificationVM()).disableNotifications();
      notification.value = value ?? false;
    } else {
      await Get.put(PNotificationVM()).enableNotifications();
      notification.value = value ?? false;
    }
  }

  // Clear user data, token, etc.
  // Then navigate to login screen
  Future<void> signout() async {
    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'signing_out'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await profileService.logout();
    result.fold(
      (err) {
        PHelperFunction.pop();
        if (err.message == 'You are not authenticated.') {
          clearCache();
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
        }
        // else {
        //   PPopupDialog(
        //     context,
        //   ).errorMessage(title: 'error'.tr, message: err.message);
        // }
      },
      (res) {
        PHelperFunction.pop();
        clearCache();
        showSucccessdialog(context: context, title: res.message ?? '');
        Future.delayed(Duration(seconds: 2), () {
          PHelperFunction.pop();
          // navigate to next screen
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
        });
      },
    );
  }

  // Erase data from login cache
  void clearCache() {
    PSecureStorage().removeData(PSecureStorage().bioDataKey);
    PSecureStorage().removeData(PSecureStorage().deviceTokenKey);
    PSecureStorage().removeData(PSecureStorage().authResKey);
  }

  Future<void> deleteAccount() async {
    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'deleting_account'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await profileService.deleteAccount();
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PHelperFunction.pop();
        showSucccessdialog(context: context, title: res.message ?? '');
        Future.delayed(Duration(seconds: 2), () {
          PHelperFunction.pop();
          // navigate to next screen
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
        });
      },
    );
  }
}
