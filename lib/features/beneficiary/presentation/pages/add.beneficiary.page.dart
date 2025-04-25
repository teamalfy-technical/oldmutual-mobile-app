import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PManageBeneficiaryPage extends StatefulWidget {
  final Beneficiary? beneficiary;
  final bool isEdit;
  const PManageBeneficiaryPage({
    super.key,
    this.beneficiary,
    this.isEdit = false,
  });

  @override
  State<PManageBeneficiaryPage> createState() => _PManageBeneficiaryPageState();
}

class _PManageBeneficiaryPageState extends State<PManageBeneficiaryPage> {
  final ctrl = Get.put(PBeneficiaryVm());

  @override
  void initState() {
    super.initState();
    ctrl.updateEditFields(widget.beneficiary);
  }

  @override
  void dispose() {
    ctrl.clearFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'edit_details'.tr : 'add_new_beneficiary'.tr,
        ),
      ),
      body: Obx(
        () => Form(
          key: ctrl.formKey,
          child: Column(
            children: [
              PPageTagWidget(
                tag: widget.beneficiary?.fullName ?? '',
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
                          validator: PValidator.validateText,
                          textInputType: TextInputType.text,
                          controller: ctrl.nameTEC,
                        ),
                      ),
                      PAppSize.s25.horizontalSpace,
                      Expanded(
                        child: PCustomFilledTextfield(
                          label: 'dob_label'.tr,
                          hint: '10-05-2003',
                          validator: PValidator.validateText,
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
                          validator: PValidator.validateText,
                          textInputType: TextInputType.text,
                          controller: ctrl.relationTEC,
                        ),
                      ),
                      PAppSize.s25.horizontalSpace,
                      Expanded(
                        child: PCustomFilledTextfield(
                          label: 'benefit_percentage'.tr,
                          hint: '20%',
                          validator: PValidator.validateText,
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
                        // validator: PValidator.validateText,
                        textInputType: TextInputType.number,
                        controller: ctrl.contactTEC,
                      ),
                    ),
                  ),

                  (PDeviceUtil.getDeviceHeight(context) * 0.02).verticalSpace,

                  PCustomCheckbox(
                    value: ctrl.split.value,
                    onChanged: (val) => ctrl.onSplitChanged(val, widget.isEdit),
                    checkboxDirection: Direction.left,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return PAppColor.primary;
                      } else {
                        return Color(0xFFD9D9D9).withOpacityExt(PAppSize.s0_6);
                      }
                    }),
                    child: Text(
                      'split_percentage_label'.tr,
                      // style: Theme.of(context).textTheme.bodySmall
                      //     ?.copyWith(fontSize: PAppSize.s14),
                    ),
                  ),

                  (PDeviceUtil.getDeviceHeight(context) * 0.05).verticalSpace,

                  PGradientButton(
                    label: widget.isEdit ? 'save_changes'.tr : 'add'.tr,
                    width: PDeviceUtil.getDeviceWidth(context) * 0.50,
                    loading: ctrl.submitting.value,
                    onTap: () {
                      if (ctrl.formKey.currentState!.validate()) {
                        widget.isEdit
                            ? ctrl.editBeneficiary(widget.beneficiary!)
                            : ctrl.addBeneficiary();
                      }
                    },
                  ),
                ],
              ).symmetric(horizontal: PAppSize.s22),
            ],
          ),
        ),
      ),
    );
  }
}
