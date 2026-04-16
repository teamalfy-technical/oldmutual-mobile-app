import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PClaimSuccessPage extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onTap;
  PClaimSuccessPage({
    super.key,
    required this.title,
    required this.message,
    this.onTap,
  });

  final PClaimsVm ctrl = Get.put(PClaimsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text(''), leading: SizedBox.shrink()),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: PAppSize.s2),
            padding: EdgeInsets.symmetric(
              horizontal: PAppSize.s20,
              vertical: PAppSize.s20,
            ),
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkBgColor
                : PAppColor.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PAppSize.s30.verticalSpace,
                const PAnimatedCheckmark(),
                PAppSize.s20.verticalSpace,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.primary950
                        : PAppColor.textColorDark,
                    fontSize: PAppSize.s24,
                  ),
                ),
                PAppSize.s12.verticalSpace,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: PAppSize.s16,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor.withOpacityExt(PAppSize.s0_7)
                        : PAppColor.textColorLight,
                  ),
                ),
                PAppSize.s20.verticalSpace,
                PCustomCardWidget(
                  borderRadius: BorderRadius.circular(PAppSize.s8),
                  useBorder: false,
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.cardDarkColor.withOpacityExt(PAppSize.s0_5)
                      : PAppColor.fillColor5,
                  padding: EdgeInsets.symmetric(
                    horizontal: PAppSize.s20,
                    vertical: PAppSize.s25,
                  ),
                  child: PAnimatedColumnWidget(
                    animateType: AnimateType.slideRight,
                    children: [
                      PSummaryRowWidget(
                        label: 'Reference'.tr,
                        value: ctrl.reference.value.isEmpty
                            ? 'not_applicable'.tr
                            : ctrl.reference.value,
                      ),
                      PAppSize.s14.verticalSpace,
                      PSummaryRowWidget(
                        label: 'Policy'.tr,
                        value:
                            ctrl.selectedPolicy?.planDescription ??
                            ctrl.selectedPolicy?.policyNo ??
                            '',
                      ),
                      PAppSize.s14.verticalSpace,
                      PSummaryRowWidget(
                        label: 'claim_type'.tr,
                        value:
                            '${ctrl.selectedClaimType?.label} — ${ctrl.selectedWithdrawalClaimType?.name.capitalizeFirst ?? ''}',
                      ),
                      PAppSize.s14.verticalSpace,
                      PSummaryRowWidget(
                        label: 'Claim Amount'.tr,
                        value: PFormatter.formatCurrency(
                          amount: ctrl.amountTEC.text.trim().isEmpty
                              ? 0.0
                              : double.parse(ctrl.amountTEC.text),
                        ),
                      ),

                      PAppSize.s14.verticalSpace,
                      PSummaryRowWidget(
                        label: 'Charge (2%)'.tr,
                        value:
                            '- ${PFormatter.formatCurrency(amount: ctrl.charge)}',
                      ),
                      PAppSize.s14.verticalSpace,
                      PSummaryRowWidget(
                        label: 'Net Amount'.tr,
                        value: PFormatter.formatCurrency(
                          amount: ctrl.amountReceivable,
                        ),
                        valueColor: PAppColor.primary,
                      ),
                    ],
                  ),
                ),

                PAppSize.s32.verticalSpace,
                PGradientButton(
                  label: 'close'.tr,
                  showIcon: true,
                  textColor: PAppColor.whiteColor,
                  iconDirection: IconDirection.right,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: onTap,
                ),
              ],
            ).scrollable(),
          ),
        ),
      ),
    );
  }
}
