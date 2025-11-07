import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PRedemptionPage extends StatelessWidget {
  PRedemptionPage({super.key});

  final ctrl = Get.put(PRedemptionVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('withdrawal'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            // Filter
            Expanded(
              child: PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s22,
                ),
                child: GetBuilder<PRedemptionVm>(
                  builder: (ctrl) {
                    return Form(
                      key: ctrl.redemptionFormKey,
                      child: Column(
                        children: [
                          PCustomTextField(
                            labelText: 'national_id'.tr,
                            hintText: 'XXXXXXXXX-X',
                            prefixText: 'GHA-',
                            controller: ctrl.nationIdTEC,
                            textInputType: TextInputType.number,
                            validator: PValidator.validateIdNumber,
                            maxLength: 11,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              IdNumberFormatter(),
                            ],
                          ),
                          PAppSize.s20.verticalSpace,
                          PCustomDropdownField<String>(
                            labelText: 'redemption_type'.tr,
                            initialValue: ctrl.selectedRedemptionType,
                            onChanged: ctrl.onRedemptionChanged,
                            items: ctrl.redemptionTypes
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),

                          PAppSize.s20.verticalSpace,
                          PCustomDropdownField<String>(
                            labelText: 'redemption_reason'.tr,
                            initialValue: ctrl.selectedRedemptionReason,
                            onChanged: ctrl.onRedemptionReasonChanged,
                            items: ctrl.redemptionReasons
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),

                          ctrl.selectedRedemptionReason == 'Other (Specify)'
                              ? Column(
                                  children: [
                                    PAppSize.s20.verticalSpace,
                                    PCustomTextField(
                                      labelText: 'state_reason'.tr,
                                      controller: ctrl.otherReasonTEC,
                                      textInputType: TextInputType.multiline,
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                          PAppSize.s16.verticalSpace,
                          PCustomDropdownField<String>(
                            labelText: 'redemption_by'.tr,
                            initialValue: ctrl.selectedRedemptionValue,
                            onChanged: ctrl.onRedemptionValueChanged,
                            items: ctrl.redemptionValues
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                          PAppSize.s14.verticalSpace,
                          ctrl.selectedRedemptionValue == 'Amount'
                              ? PCustomTextField(
                                  labelText: 'amount_to_redeem'.tr,
                                  hintText: 'E.g. 35000',
                                  controller: ctrl.amountTEC,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                )
                              : PCustomTextField(
                                  labelText: 'percentage'.tr,
                                  hintText: 'E.g. 50',
                                  controller: ctrl.percentageTEC,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  validator: PValidator.validatePercentage,
                                  maxLength: PAppSize.s3.toInt(),
                                  onChanged: (val) {
                                    PValidator.validatePercentage(val);
                                    ctrl.redemptionFormKey.currentState
                                        ?.validate();
                                  },
                                ),

                          PAppSize.s20.verticalSpace,
                          PCustomTextField(
                            labelText: 'bank_name'.tr,
                            hintText: 'Ecobank',
                            controller: ctrl.bankNameTEC,
                            textInputType: TextInputType.name,
                          ),

                          PAppSize.s20.verticalSpace,
                          PCustomTextField(
                            labelText: 'bank_branch'.tr,
                            hintText: 'Labadi',
                            controller: ctrl.bankBranchTEC,
                            textInputType: TextInputType.name,
                          ),

                          PAppSize.s20.verticalSpace,
                          PCustomTextField(
                            labelText: 'account_holder_name'.tr,
                            hintText: 'Samuel Ntim',
                            controller: ctrl.accountHolderNameTEC,
                            textInputType: TextInputType.name,
                          ),

                          PAppSize.s20.verticalSpace,
                          PCustomTextField(
                            labelText: 'account_number'.tr,
                            hintText: 'E.g. 14XXXXXXXX097',
                            controller: ctrl.accountNumberTEC,
                            textInputType: TextInputType.number,
                          ),

                          PAppSize.s20.verticalSpace,

                          // front ID upload
                          Obx(
                            () => PIdCardWidget(
                              label: 'upload_front_of_id_card'.tr,
                              file: ctrl.idFront.value,
                              onCameraTap: () => ctrl.chooseFromCamera(true),
                              onGalleryTap: () => ctrl.chooseFromGallery(true),
                            ),
                          ),

                          PAppSize.s28.verticalSpace,

                          // Back ID upload
                          Obx(
                            () => PIdCardWidget(
                              label: 'upload_back_of_id_card'.tr,
                              file: ctrl.idBack.value,
                              onCameraTap: () => ctrl.chooseFromCamera(false),
                              onGalleryTap: () => ctrl.chooseFromGallery(false),
                            ),
                          ),

                          PAppSize.s16.verticalSpace,

                          Obx(
                            () => PCustomCheckbox(
                              value: ctrl.agreeRedemption.value,
                              onChanged: ctrl.onAgreeToRedemptionChanged,
                              checkboxDirection: Direction.left,

                              child: Text(
                                'redemption_confirm_msg'.tr,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontSize: PAppSize.s12,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),

                          PAppSize.s16.verticalSpace,

                          Obx(
                            () => PGradientButton(
                              label: 'submit_request'.tr,
                              showIcon: false,
                              loading: ctrl.loading.value,
                              textColor: PAppColor.whiteColor,
                              width: PDeviceUtil.getDeviceWidth(context),
                              onTap: () {
                                if (ctrl.redemptionFormKey.currentState!
                                    .validate()) {
                                  ctrl.submitRedemptionRequest();
                                }
                              },
                            ),
                          ),
                        ],
                      ).scrollable(),
                    );
                  },
                ),
              ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }
}
