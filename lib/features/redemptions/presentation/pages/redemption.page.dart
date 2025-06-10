import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PRedemptionPage extends StatelessWidget {
  PRedemptionPage({super.key});

  final ctrl = Get.put(PRedemptionVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('redemption'.tr)),
      body: Obx(
        () => Column(
          children: [
            PPageTagWidget(
              tag: 'redemption_hint_tag'.tr,
              textAlign: TextAlign.center,
            ),

            PAppSize.s25.verticalSpace,
            // Filter
            Expanded(
              child: Form(
                key: ctrl.redemptionFormKey,
                child:
                    Column(
                      children: [
                        PCustomFilledTextfield(
                          label: 'national_id'.tr,
                          hint: 'GHA-XXXXXXXXX-X',
                          textInputType: TextInputType.text,
                          controller: ctrl.nationIdTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        GetBuilder<PRedemptionVm>(
                          builder: (ctrl) {
                            return PCustomDropdown<String>(
                              label: 'redemption_type'.tr,
                              value: ctrl.selectedRedemptionType,
                              onChanged: ctrl.onRedemptionChanged,
                              items: ctrl.redemptionTypes,
                              radius: PAppSize.s5,
                              height: PAppSize.s36,
                            );
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'national_id'.tr,
                        //         hint: 'GHA-XXXXXXXXX-X',
                        //         textInputType: TextInputType.text,
                        //         controller: ctrl.nationIdTEC,
                        //       ),
                        //     ),
                        //     PAppSize.s16.horizontalSpace,
                        //     GetBuilder<PRedemptionVm>(
                        //       builder: (ctrl) {
                        //         return Expanded(
                        //           child: PCustomDropdown<String>(
                        //             label: 'redemption_type'.tr,
                        //             value: ctrl.selectedRedemptionType,
                        //             onChanged: ctrl.onRedemptionChanged,
                        //             items: ctrl.redemptionTypes,
                        //             radius: PAppSize.s5,
                        //             height: PAppSize.s36,
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        PAppSize.s20.verticalSpace,
                        GetBuilder<PRedemptionVm>(
                          builder: (ctrl) {
                            return PCustomDropdown<String>(
                              label: 'redemption_reason'.tr,
                              value: ctrl.selectedRedemptionReason,
                              onChanged: ctrl.onRedemptionReasonChanged,
                              items: ctrl.redemptionReasons,
                              radius: PAppSize.s5,
                              height: PAppSize.s36,
                            );
                          },
                        ),

                        GetBuilder<PRedemptionVm>(
                          builder: (ctrl) {
                            return ctrl.selectedRedemptionReason ==
                                    'Other (Specify)'
                                ? Column(
                                  children: [
                                    PAppSize.s20.verticalSpace,
                                    PCustomFilledTextfield(
                                      label: 'state_reason'.tr,
                                      hint: '',

                                      textInputType: TextInputType.multiline,
                                      controller: ctrl.otherReasonTEC,
                                    ),
                                  ],
                                )
                                : SizedBox.shrink();
                          },
                        ),

                        PAppSize.s14.verticalSpace,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PRadioListTileWidget(
                              label: 'by_percentage'.tr,
                              value: 'percentage',
                              fontSize: PAppSize.s12,
                              groupValue: ctrl.priceValue.value,
                              onChanged: ctrl.onPriceAmountChanged,
                            ),
                            PAppSize.s4.verticalSpace,
                            PRadioListTileWidget(
                              label: 'by_amount'.tr,
                              value: 'amount',
                              fontSize: PAppSize.s12,
                              groupValue: ctrl.priceValue.value,
                              onChanged: ctrl.onPriceAmountChanged,
                            ),
                          ],
                        ),

                        PAppSize.s14.verticalSpace,
                        ctrl.priceValue.value == 'amount'
                            ? PCustomFilledTextfield(
                              label: 'amount_to_redeem'.tr,
                              hint: 'E.g. 35000',
                              // validator: PValidator.validateSchemeAmount,
                              textInputType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              // enabled:
                              //     ctrl.selectedRedemptionType == 'Total'
                              //         ? false
                              //         : true,
                              controller: ctrl.amountTEC,
                            )
                            : PCustomFilledTextfield(
                              label: 'percentage'.tr,
                              hint: 'E.g. 50',
                              validator: PValidator.validatePercentage,
                              maxLength: PAppSize.s3.toInt(),
                              onChanged: (val) {
                                PValidator.validatePercentage(val);
                                ctrl.redemptionFormKey.currentState?.validate();
                              },
                              textInputType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: ctrl.percentageTEC,
                            ),

                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'bank_name'.tr,
                          hint: 'Ecobank',
                          textInputType: TextInputType.name,
                          controller: ctrl.bankNameTEC,
                        ),

                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'bank_branch'.tr,
                          hint: 'Labadi',
                          textInputType: TextInputType.name,
                          controller: ctrl.bankBranchTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'account_holder_name'.tr,
                          hint: 'Samuel Ntim',
                          textInputType: TextInputType.name,
                          controller: ctrl.accountHolderNameTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'account_number'.tr,
                          hint: 'E.g. 14XXXXXXXX097',
                          textInputType: TextInputType.number,
                          controller: ctrl.accountNumberTEC,
                        ),

                        PAppSize.s20.verticalSpace,

                        // front ID upload
                        PIdCardWidget(
                          label: 'upload_front_of_id_card'.tr,
                          file: ctrl.idFront.value,
                          onCameraTap: () => ctrl.chooseFromCamera(true),
                          onGalleryTap: () => ctrl.chooseFromGallery(true),
                        ),

                        PAppSize.s28.verticalSpace,

                        // Back ID upload
                        PIdCardWidget(
                          label: 'upload_back_of_id_card'.tr,
                          file: ctrl.idBack.value,
                          onCameraTap: () => ctrl.chooseFromCamera(false),
                          onGalleryTap: () => ctrl.chooseFromGallery(false),
                        ),
                      ],
                    ).symmetric(horizontal: PAppSize.s22).scrollable(),
              ),
            ),

            PAppSize.s16.verticalSpace,

            PCustomCheckbox(
              value: ctrl.agreeRedemption.value,
              onChanged: ctrl.onAgreeToRedemptionChanged,
              checkboxDirection: Direction.left,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return PAppColor.primary;
                } else {
                  return Color(0xFFD9D9D9).withOpacityExt(PAppSize.s0_6);
                }
              }),
              child: Text(
                'redemption_confirm_msg'.tr,
                // style: Theme.of(context).textTheme.bodySmall
                //     ?.copyWith(fontSize: PAppSize.s14),
              ),
            ).symmetric(horizontal: PAppSize.s22),

            // (PDeviceUtil.getDeviceHeight(context) * 0.1).verticalSpace,
            PAppSize.s16.verticalSpace,
            PGradientButton(
              label: 'submit_request'.tr,
              width: PDeviceUtil.getDeviceWidth(context) * 0.50,
              onTap: () {
                if (ctrl.redemptionFormKey.currentState!.validate()) {
                  ctrl.submitRedemptionRequest();
                }
              },
            ),
            PAppSize.s20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
