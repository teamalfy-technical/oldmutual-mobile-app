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

  final reasonTEC = TextEditingController();
  final deleteAccountTEC = TextEditingController();
  final oldPasswordTEC = TextEditingController();
  final newPasswordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  var notification =
      PSecureStorage().getAuthResponse()?.notificationsEnabled == "True"
      ? true.obs
      : false.obs;

  var faceId = PSecureStorage().isFaceIdEnabled.obs;

  var submitting = LoadingState.completed.obs;

  var obscureOldPassword = true.obs;
  var obscureNewPassword = true.obs;

  // List of available options
  final List<String> options = [
    "Found a better alternative",
    "Poor customer service",
    "Didn’t have the features I wanted",
    "I’m leaving the country",
    "Other",
  ];

  // Selected options
  var selectedDeleteOptions = <String>{}.obs;

  onDeleteOptionChanged(bool isSelected, String option) {
    if (isSelected) {
      selectedDeleteOptions.add(option);
    } else {
      selectedDeleteOptions.remove(option);
    }

    pensionAppLogger.e(selectedDeleteOptions);
  }

  onObscureOldPasswordChanged() =>
      obscureOldPassword.value = !obscureOldPassword.value;
  onObscureNewPasswordChanged() =>
      obscureNewPassword.value = !obscureNewPassword.value;

  updateSubmittingState(LoadingState loadingState) =>
      submitting.value = loadingState;

  final context = Get.context!;

  onFaceIdToggled(bool? value) async {
    if (faceId.value) {
      await PSecureStorage().saveFaceID(false);
      faceId.value = value ?? false;
    } else {
      await PSecureStorage().saveFaceID(true);
      faceId.value = value ?? false;
    }
    pensionAppLogger.e(PSecureStorage().isFaceIdEnabled);
  }

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
        clearFields();
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

  clearFields() {
    oldPasswordTEC.clear();
    newPasswordTEC.clear();
    confirmPasswordTEC.clear();
  }

  // Clear user data, token, etc.
  // Then navigate to login screen
  Future<void> signout({bool soft = false}) async {
    loading(LoadingState.loading);
    final result = await profileService.logout();
    result.fold(
      (err) {
        loading(LoadingState.error);
        // PHelperFunction.pop();
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
        loading(LoadingState.completed);
        clearCache(soft);
        if (soft) {
          // navigate to next screen
          PHelperFunction.switchScreen(
            destination: Routes.welcomeBackPage,
            replace: true,
          );
        } else {
          PHelperFunction.switchScreen(
            destination: Routes.loginPage,
            replace: true,
          );
          PPopupDialog(
            context,
          ).successMessage(title: 'success'.tr, message: res.message ?? '');
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
    loading(LoadingState.loading);
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
        loading(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        loading(LoadingState.completed);
        clearCache(false);
        PHelperFunction.pop();
        PHelperFunction.switchScreen(
          destination: Routes.settingsSuccessPage,
          args: [
            'account_deleted_msg'.tr,
            'success'.tr,
            'finish'.tr,
            () {
              PHelperFunction.switchScreen(
                destination: Routes.loginPage,
                replace: true,
              );
            },
          ],
        );
      },
    );
  }
}
