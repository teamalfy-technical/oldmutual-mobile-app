import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PRedemptionVm extends GetxController {
  static PRedemptionVm get instance => Get.find();

  final redemptionFormKey = GlobalKey<FormState>();

  var idFront = File('').obs;
  var idBack = File('').obs;

  var loading = LoadingState.completed.obs;

  final nationIdTEC = TextEditingController();
  final percentageTEC = TextEditingController();
  final otherReasonTEC = TextEditingController();
  // final reasonTEC = TextEditingController();
  final amountTEC = TextEditingController();

  final bankNameTEC = TextEditingController();
  final accountNumberTEC = TextEditingController();
  final accountHolderNameTEC = TextEditingController();
  final bankBranchTEC = TextEditingController();

  final currentEmployerNameTEC = TextEditingController();
  final currentSchemeTypeTEC = TextEditingController();
  final currentSchemeNameTEC = TextEditingController();
  final prevEmployerNameTEC = TextEditingController();
  final prevSchemeTypeTEC = TextEditingController();
  final prevSchemeNameTEC = TextEditingController();
  final prevTrusteeNameTEC = TextEditingController();
  final prevTrusteeContactNameTEC = TextEditingController();
  final prevTrusteeContactNumberTEC = TextEditingController();

  var selectedRedemptionOption = 'withdraw'.obs;

  var priceValue = 'percentage'.obs;

  String? selectedRedemptionType = 'Total';
  String? selectedRedemptionReason = 'none'.tr;
  List<String> redemptionTypes =
      PSecureStorage().getAuthResponse()!.schemeType!.contains('TIER 2')
          ? ['Total']
          : ['Total', 'Partial'];

  List<String> redemptionReasons =
      PSecureStorage().getAuthResponse()!.schemeType!.contains('TIER 2')
          ? [
            'None',
            'Retirement',
            'Voluntary Retirement',
            'Death',
            'Total Incapacity',
            'Permanent Emigration from Ghana',
            'Other (Specify)',
          ]
          : PSecureStorage().getAuthResponse()!.masterScheme!.contains(
            'PRESTIGE',
          )
          ? [
            'None',
            'Voluntary Retirement',
            'Death',
            'Total Incapacity',
            'Permanent Emigration from Ghana',
            'Other (Specify)',
          ]
          : [
            'None',
            'Retirement',
            'Voluntary Retirement',
            'Resignation',
            'Death',
            'Total Incapacity',
            'Permanent Emigration from Ghana',
            'Other (Specify)',
          ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   final schemeType =
  //       PSecureStorage().getAuthResponse()!.schemeType ??
  //       Get.put(PDashboardVm()).selectedScheme.value.schemeType ??
  //       '';
  //   redemptionTypes =
  //       schemeType.contains('TIER 2') ? ['Total'] : ['Total', 'Partial'];
  // }

  onRedemptionChanged(value) {
    selectedRedemptionType = value;
    update();
  }

  onRedemptionReasonChanged(value) {
    selectedRedemptionReason = value;

    update();
  }

  onPriceAmountChanged(val) {
    priceValue.value = val;
  }

  onRedemptionOptionChanged(val) {
    selectedRedemptionOption.value = val;
  }

  var agreeRedemption = false.obs;
  var agreePorting = false.obs;

  onAgreeToPortingChanged(bool? value) => agreePorting.value = value ?? false;
  onAgreeToRedemptionChanged(bool? value) =>
      agreeRedemption.value = value ?? false;

  final context = Get.context!;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  // Pick an image from camera.
  Future<void> chooseFromCamera([bool front = true]) async {
    final XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      _cropImage(imagePath: image.path, front: front);
    } on PlatformException catch (err) {
      debugPrint('Failed to pick image: $err');
    }
  }

  // Pick an image from gallery.
  Future<void> chooseFromGallery([bool front = true]) async {
    final XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _cropImage(imagePath: image.path, front: front);
    } on PlatformException catch (err) {
      debugPrint('Failed to pick image: $err');
    }
  }

  Future<void> _cropImage({
    required String imagePath,
    bool front = true,
  }) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'crop_photo'.tr,
            activeControlsWidgetColor: PAppColor.primary,
            showCropGrid: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'crop_photo'.tr),
        ],
      );
      if (croppedFile == null) return;

      // pensionAppLogger.w(
      //   'FileSize BF: ${await PHelperFunction.getFileSize(File(croppedFile.path))}',
      // );

      final compressedFile = await PHelperFunction.compressFile(
        File(croppedFile.path),
      );
      // final fileSize = await PHelperFunction.getFileSize(compressedFile);
      // pensionAppLogger.w('FileSize AF: $fileSize');
      // pensionAppLogger.w(fileSize);
      front ? idFront.value = compressedFile : idBack.value = compressedFile;
    } on PlatformException catch (err) {
      debugPrint('Failed to crop photo: $err');
    }
  }

  clearFields() {
    nationIdTEC.clear();
    percentageTEC.clear();
    otherReasonTEC.clear();
    amountTEC.clear();
    bankNameTEC.clear();
    accountNumberTEC.clear();
    accountHolderNameTEC.clear();
    bankBranchTEC.clear();
    currentEmployerNameTEC.clear();
    currentSchemeTypeTEC.clear();
    currentSchemeNameTEC.clear();
    prevEmployerNameTEC.clear();
    prevSchemeTypeTEC.clear();
    prevSchemeNameTEC.clear();
    prevTrusteeNameTEC.clear();
    prevTrusteeContactNameTEC.clear();
    prevTrusteeContactNumberTEC.clear();
    idFront.value = File('');
    idBack.value = File('');
    selectedRedemptionType = null;
    selectedRedemptionReason = null;
    update();
  }

  /// Function to submit redemption request
  Future<void> submitRedemptionRequest() async {
    if (!agreeRedemption.value) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to confirm that you\'re the account holder to continue.',
      );
      return;
    }
    if (!isIdUploaded()) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to upload both the front and back view of your National ID card to continue.',
      );
      return;
    }
    if (selectedRedemptionType == null) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message: 'You need to select redemption type to continue.',
      );
      return;
    }
    if (selectedRedemptionReason == 'none'.tr) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message: 'You need to select redemption reason to continue.',
      );
      return;
    }
    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'submitting_request_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await redemptionService.createRedemptionRequest(
      nationId: nationIdTEC.text.trim(),
      redemptionType: selectedRedemptionType ?? '',
      percentage:
          priceValue.value == 'percentage' ? percentageTEC.text.trim() : '',
      amount: priceValue.value == 'amount' ? amountTEC.text.trim() : '',
      redemptionReason:
          selectedRedemptionReason == 'other'.tr
              ? otherReasonTEC.text.trim()
              : selectedRedemptionReason ?? '',
      bankAccount: accountNumberTEC.text.trim(),
      bankName: bankNameTEC.text.trim(),
      accountHolderName: accountHolderNameTEC.text.trim(),
      bankBranch: bankBranchTEC.text.trim(),
      idBack: idBack.value,
      idFront: idFront.value,
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        PHelperFunction.pop();
        clearFields();
        showMySuccessDialog(message: 'redeem_pension_msg'.tr);
      },
    );
  }

  // check if front and back of National ID is selected
  isIdUploaded() {
    if (idFront.value.path.isEmpty && idBack.value.path.isEmpty) {
      return false;
    }
    return true;
  }

  /// Function to submit porting request
  Future<void> submitPortingRequest() async {
    if (!agreePorting.value) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to confirm that you\'re the account holder to continue.',
      );
      return;
    }
    if (!isIdUploaded()) {
      PPopupDialog(context).errorMessage(
        title: 'action_required'.tr,
        message:
            'You need to upload both the front and back view of your National ID card to continue.',
      );
      return;
    }
    showLoadingDialog(
      context: context,
      barrierDismissible: true,
      content: Text(
        'submitting_request_msg'.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    final result = await redemptionService.createPortingRequest(
      nameOfCurrentEmployer: currentEmployerNameTEC.text.trim(),
      currentSchemeType: currentSchemeTypeTEC.text.trim(),
      currentSchemeName: currentSchemeNameTEC.text.trim(),
      nameOfPrevEmployer: prevEmployerNameTEC.text.trim(),
      prevSchemeType: prevSchemeTypeTEC.text.trim(),
      prevSchemeName: prevSchemeNameTEC.text.trim(),
      nameOfPrevTrustee: prevTrusteeNameTEC.text.trim(),
      prevTrusteeContactName: prevTrusteeContactNameTEC.text.trim(),
      prevTrusteeContactNumber: prevTrusteeContactNumberTEC.text.trim(),
      idFront: idFront.value,
      idBack: idBack.value,
    );
    result.fold(
      (err) {
        PHelperFunction.pop();
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) async {
        PHelperFunction.pop();
        clearFields();
        showMySuccessDialog(message: 'porting_msg'.tr);
      },
    );
  }

  /// show success message after request completes
  Future<void> showMySuccessDialog({required String message}) async {
    showSuccessDialog(
      context: context,
      mainAxisAlignment: MainAxisAlignment.center,
      title: '${'success'.tr}!',
      subtitle: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: PAppColor.text700),
      ),
    );
    Future.delayed(Duration(milliseconds: PAppSize.s5000), () {
      PHelperFunction.pop();
      PHelperFunction.pop();
    });
  }
}
