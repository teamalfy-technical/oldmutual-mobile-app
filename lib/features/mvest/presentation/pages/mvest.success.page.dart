import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestSuccessPage extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onTap;

  PMVestSuccessPage({
    super.key,
    required this.title,
    required this.message,
    this.onTap,
  });

  final PMVestVm ctrl = Get.find<PMVestVm>();

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: const Text(''), leading: const SizedBox.shrink()),
      body: PAnnotatedRegion(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: PAppSize.s2),
            padding: EdgeInsets.symmetric(
              horizontal: PAppSize.s20,
              vertical: PAppSize.s20,
            ),
            color: isDark ? PAppColor.darkBgColor : PAppColor.whiteColor,
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
                    color: isDark
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
                    color: isDark
                        ? PAppColor.whiteColor.withOpacityExt(PAppSize.s0_7)
                        : PAppColor.textColorLight,
                  ),
                ),
                PAppSize.s20.verticalSpace,
                PCustomCardWidget(
                  borderRadius: BorderRadius.circular(PAppSize.s8),
                  useBorder: false,
                  color: isDark
                      ? PAppColor.cardDarkColor.withOpacityExt(PAppSize.s0_5)
                      : PAppColor.fillColor5,
                  padding: EdgeInsets.symmetric(
                    horizontal: PAppSize.s20,
                    vertical: PAppSize.s25,
                  ),
                  child: PAnimatedColumnWidget(
                    animateType: AnimateType.slideRight,
                    children: [
                      _Row(
                        label: 'reference'.tr,
                        value: _generatedReference(),
                      ),
                      PAppSize.s14.verticalSpace,
                      _Row(
                        label: 'plan'.tr,
                        value: _frequencyLabel(ctrl.selectedFrequency.value),
                      ),
                      PAppSize.s14.verticalSpace,
                      _Row(
                        label: 'amount'.tr,
                        value: _formattedAmount(),
                      ),
                      PAppSize.s14.verticalSpace,
                      _Row(
                        label: 'beneficiaries'.tr,
                        value: '${ctrl.beneficiaries.length}',
                      ),
                      PAppSize.s14.verticalSpace,
                      _Row(
                        label: 'status'.tr,
                        value: 'active'.tr,
                        valueColor: PAppColor.primaryDark,
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

  String _frequencyLabel(MVestFrequency? freq) {
    switch (freq) {
      case MVestFrequency.monthly:
        return 'monthly'.tr;
      case MVestFrequency.yearly:
        return 'yearly'.tr;
      case MVestFrequency.lumpSum:
        return 'lump_sum'.tr;
      case null:
        return '';
    }
  }

  String _formattedAmount() {
    final amount =
        double.tryParse(ctrl.contributionAmountTEC.text.trim()) ?? 0;
    return PFormatter.formatCurrency(amount: amount, useSpaceSeparator: false);
  }

  String _generatedReference() {
    final ts = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    return 'SLAMS-${ts.toUpperCase()}';
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _Row({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w400,
              color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
            ),
          ),
        ),
        PAppSize.s8.horizontalSpace,
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w700,
              color: valueColor ??
                  (isDark ? PAppColor.whiteColor : PAppColor.text700),
            ),
          ),
        ),
      ],
    );
  }
}
