import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PManageBeneficiaryPage extends StatelessWidget {
  final Beneficiary? beneficiary;
  final bool isEdit;
  PManageBeneficiaryPage({super.key, this.beneficiary, this.isEdit = false});

  final ctrl = Get.put(PBeneficiaryVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'edit_details'.tr : 'add_new_beneficiary'.tr),
      ),
      body: Column(
        children: [
          PPageTagWidget(
            tag: beneficiary?.fullName ?? '',
            textAlign: TextAlign.center,
          ),

          PAppSize.s25.verticalSpace,
          // Filter
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PCustomFilledTextfield(
                      label: 'name'.tr,
                      hint: 'John White',
                      textInputType: TextInputType.text,
                      controller: ctrl.nameTEC,
                    ),
                  ),
                  PAppSize.s25.horizontalSpace,
                  Expanded(
                    child: PCustomFilledTextfield(
                      label: 'dob_label'.tr,
                      hint: '10-05-2003',
                      textInputType: TextInputType.datetime,
                      controller: ctrl.dobTEC,
                    ),
                  ),
                ],
              ),
              PAppSize.s25.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: PCustomFilledTextfield(
                      label: 'relation'.tr,
                      hint: 'Son',
                      textInputType: TextInputType.text,
                      controller: ctrl.relationTEC,
                    ),
                  ),
                  PAppSize.s25.horizontalSpace,
                  Expanded(
                    child: PCustomFilledTextfield(
                      label: 'benefit_percentage'.tr,
                      hint: '20%',
                      textInputType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      controller: ctrl.benefitPercentageTEC,
                    ),
                  ),
                ],
              ),
              PAppSize.s25.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: PDeviceUtil.getDeviceWidth(context) * 0.41,
                  child: PCustomFilledTextfield(
                    label: 'contact_detail'.tr,
                    hint: '0591056230',
                    textInputType: TextInputType.number,
                    controller: ctrl.benefitPercentageTEC,
                  ),
                ),
              ),

              (PDeviceUtil.getDeviceHeight(context) * 0.05).verticalSpace,

              PGradientButton(
                label: isEdit ? 'save_changes'.tr : 'add'.tr,
                width: PDeviceUtil.getDeviceWidth(context) * 0.50,
                onTap:
                    () =>
                        isEdit ? ctrl.editBeneficiary() : ctrl.addBeneficiary(),
              ),
            ],
          ).symmetric(horizontal: PAppSize.s22),
        ],
      ),
    );
  }
}
