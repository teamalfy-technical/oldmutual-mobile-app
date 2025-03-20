import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PProfileVm extends GetxController {
  var profileFile = File('').obs;

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
