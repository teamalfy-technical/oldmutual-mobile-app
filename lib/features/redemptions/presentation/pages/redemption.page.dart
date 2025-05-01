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
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'redemption_hint_tag'.tr,
            textAlign: TextAlign.center,
          ),

          PAppSize.s25.verticalSpace,
          // Filter
          Expanded(
            child: Obx(
              () =>
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'national_id'.tr,
                              hint: '',
                              textInputType: TextInputType.text,
                              controller: ctrl.nationIdTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          GetBuilder<PRedemptionVm>(
                            builder: (ctrl) {
                              return Expanded(
                                child: PCustomDropdown<String>(
                                  label: 'redemption_type'.tr,
                                  value: ctrl.selectedRedemptionType,
                                  onChanged: ctrl.onRedemptionChanged,
                                  items: ctrl.redemptionTypes,
                                  radius: PAppSize.s5,
                                  height: PAppSize.s36,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      PAppSize.s25.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'percentage'.tr,
                              hint: '',
                              textInputType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: ctrl.percentageTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'redemption_reason'.tr,
                              hint: '',
                              textInputType: TextInputType.multiline,
                              controller: ctrl.reasonTEC,
                            ),
                          ),
                        ],
                      ),
                      PAppSize.s25.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'amount_to_withdraw'.tr,
                              hint: '',
                              textInputType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              // enabled:
                              //     ctrl.selectedRedemptionType == 'Total'
                              //         ? false
                              //         : true,
                              controller: ctrl.amountTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'bank_name'.tr,
                              hint: '',
                              textInputType: TextInputType.name,
                              controller: ctrl.bankNameTEC,
                            ),
                          ),
                        ],
                      ),
                      PAppSize.s25.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'bank_branch'.tr,
                              hint: '',
                              textInputType: TextInputType.name,
                              controller: ctrl.bankBranchTEC,
                            ),
                          ),
                          PAppSize.s25.horizontalSpace,
                          Expanded(
                            child: PCustomFilledTextfield(
                              label: 'account_holder_name'.tr,
                              hint: '',
                              textInputType: TextInputType.name,
                              controller: ctrl.accountHolderNameTEC,
                            ),
                          ),
                        ],
                      ),
                      PAppSize.s25.verticalSpace,
                      PCustomFilledTextfield(
                        label: 'account_number'.tr,
                        hint: '',
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

                      PAppSize.s20.verticalSpace,

                      PCustomCheckbox(
                        value: ctrl.agreeRedemption.value,
                        onChanged: ctrl.onAgreeToRedemptionChanged,
                        checkboxDirection: Direction.left,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return PAppColor.primary;
                          } else {
                            return Color(
                              0xFFD9D9D9,
                            ).withOpacityExt(PAppSize.s0_6);
                          }
                        }),
                        child: Text(
                          'redemption_confirm_msg'.tr,
                          // style: Theme.of(context).textTheme.bodySmall
                          //     ?.copyWith(fontSize: PAppSize.s14),
                        ),
                      ),
                    ],
                  ).symmetric(horizontal: PAppSize.s22).scrollable(),
            ),
          ),

          // (PDeviceUtil.getDeviceHeight(context) * 0.1).verticalSpace,
          PAppSize.s20.verticalSpace,
          PGradientButton(
            label: 'submit_request'.tr,
            width: PDeviceUtil.getDeviceWidth(context) * 0.50,
            onTap: () => ctrl.submitRedemptionRequest(),
          ),
          PAppSize.s20.verticalSpace,
        ],
      ),
    );
  }
}
