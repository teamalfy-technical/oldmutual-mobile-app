import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PPortingPage extends StatefulWidget {
  const PPortingPage({super.key});

  @override
  State<PPortingPage> createState() => _PPortingPageState();
}

class _PPortingPageState extends State<PPortingPage> {
  final ctrl = Get.put(PRedemptionVm());

  @override
  void initState() {
    super.initState();
    ctrl.currentSchemeNameTEC.text =
        PSecureStorage().getAuthResponse()?.masterScheme ??
        ''; // Assign the value here
    ctrl.currentSchemeTypeTEC.text =
        PSecureStorage().getAuthResponse()?.schemeType ??
        ''; // Assign the value here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('porting'.tr)),
      body: Obx(
        () => Column(
          children: [
            PPageTagWidget(
              tag: 'porting_hint_tag'.tr,
              textAlign: TextAlign.center,
            ),

            PAppSize.s25.verticalSpace,
            // Filter
            Expanded(
              child: Obx(
                () =>
                    Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'name_of_current_employer'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.currentEmployerNameTEC,
                        //       ),
                        //     ),
                        //     PAppSize.s25.horizontalSpace,
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'current_scheme_name'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.currentSchemeNameTEC,
                        //         enabled: false,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        PCustomFilledTextfield(
                          label: 'name_of_current_employer'.tr,
                          hint: 'Old Mutual Limited',
                          textInputType: TextInputType.name,
                          controller: ctrl.currentEmployerNameTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'current_scheme_name'.tr,
                          hint: '',
                          textInputType: TextInputType.name,
                          controller: ctrl.currentSchemeNameTEC,
                          enabled: false,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'current_scheme_type'.tr,
                          hint: '',
                          textInputType: TextInputType.text,
                          controller: ctrl.currentSchemeTypeTEC,
                          enabled: false,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'name_of_prev_employer'.tr,
                          hint: 'Old Mutual Limited',
                          textInputType: TextInputType.name,
                          controller: ctrl.prevEmployerNameTEC,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'current_scheme_type'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.text,
                        //         controller: ctrl.currentSchemeTypeTEC,
                        //         enabled: false,
                        //       ),
                        //     ),
                        //     PAppSize.s25.horizontalSpace,
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'name_of_prev_employer'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.prevEmployerNameTEC,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'prev_scheme_name'.tr,
                          hint: 'OLD MUTUAL ASPIRE PENSION SCHEME',
                          textInputType: TextInputType.name,
                          controller: ctrl.prevSchemeNameTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'prev_scheme_Type'.tr,
                          hint: 'INDIVIDUAL PENSION',
                          textInputType: TextInputType.text,
                          controller: ctrl.prevSchemeTypeTEC,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'prev_scheme_name'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.prevSchemeNameTEC,
                        //       ),
                        //     ),
                        //     PAppSize.s25.horizontalSpace,
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'prev_scheme_Type'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.text,
                        //         controller: ctrl.prevSchemeTypeTEC,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'name_of_prev_trustee'.tr,
                          hint: 'Lord Osei',
                          textInputType: TextInputType.name,
                          controller: ctrl.prevTrusteeNameTEC,
                        ),
                        PAppSize.s20.verticalSpace,
                        PCustomFilledTextfield(
                          label: 'prev_trustee_contact_name'.tr,
                          hint: 'Lord Osei',
                          textInputType: TextInputType.name,
                          controller: ctrl.prevTrusteeContactNameTEC,
                        ),

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'name_of_prev_trustee'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.prevTrusteeNameTEC,
                        //       ),
                        //     ),
                        //     PAppSize.s25.horizontalSpace,
                        //     Expanded(
                        //       child: PCustomFilledTextfield(
                        //         label: 'prev_trustee_contact_name'.tr,
                        //         hint: '',
                        //         textInputType: TextInputType.name,
                        //         controller: ctrl.prevTrusteeContactNameTEC,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        PAppSize.s20.verticalSpace,

                        PCustomFilledTextfield(
                          label: 'prev_trustee_contact_number'.tr,
                          hint: 'E.g. 0566557878',
                          maxLength: PAppSize.s10.toInt(),
                          textInputType: TextInputType.number,
                          controller: ctrl.prevTrusteeContactNumberTEC,
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
              value: ctrl.agreePorting.value,
              onChanged: ctrl.onAgreeToPortingChanged,
              checkboxDirection: Direction.left,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return PAppColor.primary;
                } else {
                  return Color(0xFFD9D9D9).withOpacityExt(PAppSize.s0_6);
                }
              }),
              child: Text(
                'porting_confirm_msg'.tr,
                // style: Theme.of(context).textTheme.bodySmall
                //     ?.copyWith(fontSize: PAppSize.s14),
              ),
            ).symmetric(horizontal: PAppSize.s22),
            PAppSize.s16.verticalSpace,
            PGradientButton(
              label: 'submit_request'.tr,
              width: PDeviceUtil.getDeviceWidth(context) * 0.50,
              onTap: () => ctrl.submitPortingRequest(),
            ),
            PAppSize.s20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
