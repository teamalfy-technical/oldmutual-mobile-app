import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDeleteAccountPageTwo extends StatelessWidget {
  PDeleteAccountPageTwo({super.key});

  final vm = Get.put(PSettingsVm());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('delete_account'.tr)),
      body: Obx(
        () => Column(
          children: [
            Container(
              padding: EdgeInsets.all(PAppSize.s24),
              height: PDeviceUtil.getDeviceHeight(context) * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PAppSize.s20),
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
                border: Border.all(
                  width: PAppSize.s1,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.transparentColor
                      : PAppColor.fillColor2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We’re sorry to see you go 🥹 ',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontSize: PAppSize.s14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        PAppSize.s10.verticalSpace,

                        Text(
                          'Why are you leaving us',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),

                        PAppSize.s8.verticalSpace,

                        // Build checkboxes dynamically
                        ...vm.options.map((option) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  side: BorderSide(
                                    width: PAppSize.s2,
                                    color: PHelperFunction.isDarkMode(context)
                                        ? PAppColor.fillColor2
                                        : PAppColor.blackColor,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,

                                  fillColor: WidgetStateProperty.resolveWith((
                                    states,
                                  ) {
                                    if (states.contains(WidgetState.selected)) {
                                      return PAppColor.successDark;
                                    } else {
                                      return PAppColor.transparentColor;
                                    }
                                  }),
                                  value: vm.selectedDeleteOptions.contains(
                                    option,
                                  ),
                                  onChanged: (val) => vm.onDeleteOptionChanged(
                                    val ?? false,
                                    option,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

                        PAppSize.s8.verticalSpace,

                        PCustomTextField(
                          labelText: 'enter_reason'.tr.toLowerCase(),
                          alignLabelWithHint: true,
                          maxLines: 8,
                          controller: vm.reasonTEC,
                        ),
                        // PAppSize.s12.verticalSpace,
                      ],
                    ).scrollable(),
                  ),

                  // PAppSize.s8.verticalSpace,
                  PGradientButton(
                    label: 'proceed'.tr,
                    showIcon: false,
                    textColor: PAppColor.whiteColor,
                    width: PDeviceUtil.getDeviceWidth(context),
                    onTap: vm.selectedDeleteOptions.isEmpty
                        ? null
                        : () => showDeleteAccountModal(context),
                  ),

                  PAppSize.s32.verticalSpace,
                ],
              ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }

  /// Shows modal to logout user from app
  /// params ;- context
  Future<dynamic> showDeleteAccountModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkAppBarColor
          : PAppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PAppSize.s24),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: PAppSize.s16,
              vertical: PAppSize.s4,
            ),
            height: PDeviceUtil.getDeviceHeight(context) * 0.28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${'confirm_delete'.tr}?',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Assets.icons.closeIcon
                                .svg(
                                  color: PHelperFunction.isDarkMode(context)
                                      ? PAppColor.whiteColor
                                      : PAppColor.darkAppBarColor,
                                )
                                .onPressed(
                                  onTap: PHelperFunction.pop,
                                  radius: BorderRadius.circular(PAppSize.s20),
                                ),
                          ],
                        ),
                        PAppSize.s12.verticalSpace,
                        Text(
                          'confirm_delete_msg'.tr,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontSize: PAppSize.s13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                        ),

                        PAppSize.s12.verticalSpace,

                        // delete textfield
                        PCustomTextField(
                          labelText: 'delete'.tr.toUpperCase(),
                          alignLabelWithHint: true,
                          controller: vm.deleteAccountTEC,
                          validator: PValidator.validateDelete,
                        ),
                      ],
                    ).scrollable(),
                  ),
                ),

                PAppSize.s20.verticalSpace,
                // Action buttons
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: PGradientButton(
                          label: 'confirm_delete'.tr,
                          showIcon: false,
                          loading: vm.loading.value,
                          textColor: PAppColor.whiteColor,
                          width: PDeviceUtil.getDeviceWidth(context),

                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              vm.deleteAccount();
                            }
                          },
                        ),
                      ),
                      PAppSize.s8.horizontalSpace,
                      Expanded(
                        child: OutlinedButton(
                          onPressed: PHelperFunction.pop,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: PAppColor.successDark,
                            side: BorderSide(color: PAppColor.successDark),
                            minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PAppSize.s24),
                            ),
                          ),
                          child: Text('no_cancel'.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
