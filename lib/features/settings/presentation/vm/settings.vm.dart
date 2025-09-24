import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/notification/presentation/vm/notification.vm.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSettingsVm extends GetxController {
  static PSettingsVm get instance => Get.find();

  final changePasswordFormKey = GlobalKey<FormState>();

  var loading = LoadingState.completed.obs;

  final oldPasswordTEC = TextEditingController();
  final newPasswordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  var notification =
      PSecureStorage().getAuthResponse()?.notificationsEnabled == "True"
      ? true.obs
      : false.obs;

  var submitting = LoadingState.completed.obs;

  var obscureOldPassword = true.obs;
  var obscureNewPassword = true.obs;

  onObscureOldPasswordChanged() =>
      obscureOldPassword.value = !obscureOldPassword.value;
  onObscureNewPasswordChanged() =>
      obscureNewPassword.value = !obscureNewPassword.value;

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

  /// Function to change user password
  Future<void> changePassword() async {
    // PHelperFunction.switchScreen(
    //   destination: Routes.settingsSuccessPage,
    //   args: [
    //     'password_changed_msg'.tr,
    //     'success'.tr,
    //     'done'.tr,
    //     () {
    //       PHelperFunction.pop();
    //       PHelperFunction.pop();
    //     },
    //   ],
    // );

    loading(LoadingState.loading);
    final result = await authService.changePassword(
      oldPassword: oldPasswordTEC.text.trim(),
      newPassword: newPasswordTEC.text.trim(),
      confirmPassword: confirmPasswordTEC.text.trim(),
    );
    result.fold(
      (err) {
        loading(LoadingState.error);
        // PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        PHelperFunction.switchScreen(
          destination: Routes.settingsSuccessPage,
          args: [
            'password_changed_msg'.tr,
            'success'.tr,
            'done'.tr,
            () {
              PHelperFunction.pop();
              PHelperFunction.pop();
            },
          ],
        );
      },
    );
  }

  // Clear user data, token, etc.
  // Then navigate to login screen
  Future<void> signout({bool soft = false}) async {
    if (!soft) {
      showLoadingDialog(
        context: context,
        barrierDismissible: true,
        content: Text(
          'signing_out'.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final result = await profileService.logout();
    result.fold(
      (err) {
        PHelperFunction.pop();
        if (err.message == 'You are not authenticated.') {
          clearCache(soft);
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
        clearCache(soft);
        if (soft) {
          Future.delayed(Duration(seconds: 2), () {
            // navigate to next screen
            PHelperFunction.switchScreen(
              destination: Routes.welcomeBackPage,
              replace: true,
            );
          });
        } else {
          showSuccessDialog(context: context, title: res.message ?? '');
          Future.delayed(Duration(seconds: 2), () {
            PHelperFunction.pop();
            // navigate to next screen
            PHelperFunction.switchScreen(
              destination: Routes.loginPage,
              replace: true,
            );
          });
        }
      },
    );
  }

  // Erase data from login cache
  /// soft - defines the level of logout
  /// false if you logged out manually
  /// true if user was logged out due to inactivity
  void clearCache(bool soft) {
    if (soft == false) {
      PSecureStorage().removeData(PSecureStorage().emailKey);
      PSecureStorage().removeData(PSecureStorage().authResKey);
      PSecureStorage().removeData(PSecureStorage().deviceTokenKey);
    }
    PSecureStorage().removeData(PSecureStorage().bioDataKey);
    // PSecureStorage().removeData(PSecureStorage().tokenResKey);
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
        showSuccessDialog(context: context, title: res.message ?? '');
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
