import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/profile/application/service/profile.service.impl.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PProfileVm extends GetxController {
  var profileFile = File('').obs;

  var profile = Member().obs;
  var bioData = BioData().obs;
  var authResponse = Member().obs;

  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    super.onInit();
    loadStoredData();
    getProfile();
  }

  /// Load cached data from secure storage
  Future<void> loadStoredData() async {
    final auth = await PSecureStorage().getAuthResponse();
    final bio = await PSecureStorage().getBioData();
    if (auth != null) authResponse.value = auth;
    if (bio != null) bioData.value = bio;
  }

  /// Function to get all beneficiaries
  Future<void> getProfile() async {
    updateLoadingState(LoadingState.loading);
    final result = await profileService.getProfile();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        await getBioData();
        updateLoadingState(LoadingState.completed);
        profile.value = res.data ?? Member();
      },
    );
  }

  Future<void> getBioData() async {
    final result = await authService.getBioData();
    result.fold((err) {}, (res) async {
      if (res.data != null && res.data!.isNotEmpty) {
        await PSecureStorage().saveBioData(res.data!.first.toJson());
        bioData.value = res.data!.first;
      }
    });
  }

  // Pick an image.
  Future<void> chooseFromGallery() async {
    final XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      _cropImage(imagePath: image.path);
    } on PlatformException catch (err) {
      debugPrint('Failed to pick image: $err');
    }
  }

  Future<void> _cropImage({required String imagePath}) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'crop_photo'.tr,
            // toolbarColor: TAppColor.transparentColor,
            // toolbarWidgetColor: TAppColor.whiteColor,
            // cropFrameColor: TAppColor.primary,
            activeControlsWidgetColor: PAppColor.primary,
            showCropGrid: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'crop_photo'.tr),
        ],
      );
      if (croppedFile == null) return;
      profileFile.value = File(croppedFile.path);
    } on PlatformException catch (err) {
      debugPrint('Failed to crop photo: $err');
    }
  }
}
