import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestReviewPage extends StatelessWidget {
  const PMVestReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.isRegistered<PMVestVm>()
        ? Get.find<PMVestVm>()
        : Get.put(PMVestVm());

    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.whiteColor,
      appBar: AppBar(title: Text('review'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          child: PAnimatedColumnWidget(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s8.verticalSpace,
              Text(
                'step_n_of_n'.trParams({'current': '3', 'total': '4'}),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s13,
                  fontWeight: FontWeight.w600,
                  color: PAppColor.primaryDark,
                ),
              ),
              PAppSize.s8.verticalSpace,
              Text(
                'review_investment_hint'.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s14,
                  color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                ),
              ),
              PAppSize.s20.verticalSpace,
              _PaymentSummaryCard(ctrl: ctrl),
              PAppSize.s20.verticalSpace,
              Obx(
                () => PCustomCheckbox(
                  value: ctrl.declarationAccepted.value,
                  onChanged: (v) => ctrl.declarationAccepted.value = v ?? false,
                  side: BorderSide(
                    color: isDark
                        ? PAppColor.darkBorderColor
                        : PAppColor.fillColor4,
                    width: PAppSize.s1_5,
                  ),
                  fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) => states.contains(WidgetState.selected)
                        ? PAppColor.primary
                        : null,
                  ),
                  child: Text(
                    'mvest_declaration'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                    ),
                  ),
                ),
              ),
              PAppSize.s24.verticalSpace,
              Obx(
                () => PGradientButton(
                  label: 'proceed_to_payment'.tr,
                  showIcon: true,
                  iconDirection: IconDirection.right,
                  textColor: PAppColor.whiteColor,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: ctrl.declarationAccepted.value
                      ? () => PHelperFunction.switchScreen(
                          destination: Routes.mvestPaymentPage,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentSummaryCard extends StatelessWidget {
  final PMVestVm ctrl;
  const _PaymentSummaryCard({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return PCustomCardWidget(
      borderRadius: BorderRadius.circular(PAppSize.s12),
      useBorder: false,
      color: isDark
          ? PAppColor.cardDarkColor.withOpacityExt(PAppSize.s0_5)
          : PAppColor.fillColor5,
      padding: EdgeInsets.symmetric(
        horizontal: PAppSize.s20,
        vertical: PAppSize.s20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle(text: 'payment_summary'.tr),
          PAppSize.s12.verticalSpace,
          _Divider(),
          PAppSize.s12.verticalSpace,
          _Row(
            label: 'contribution_type'.tr,
            value: _frequencyLabel(ctrl.selectedFrequency.value),
          ),
          PAppSize.s12.verticalSpace,
          _Row(label: 'amount'.tr, value: _formattedAmount()),
          PAppSize.s12.verticalSpace,
          _Divider(),
          PAppSize.s12.verticalSpace,
          _SectionTitle(text: 'beneficiaries'.tr),
          PAppSize.s12.verticalSpace,
          _Divider(),

          ...ctrl.beneficiaries.map(
            (b) => Padding(
              padding: EdgeInsets.only(top: PAppSize.s12),
              child: _Row(
                label: b.name,
                value: '${b.percentage.toStringAsFixed(0)}%',
              ),
            ),
          ),
        ],
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
    final amount = double.tryParse(ctrl.contributionAmountTEC.text.trim()) ?? 0;
    return PFormatter.formatCurrency(amount: amount, useSpaceSeparator: false);
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: PAppSize.s15,
        fontWeight: FontWeight.w700,
        color: isDark ? PAppColor.whiteColor : PAppColor.text700,
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

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
              fontWeight: FontWeight.w500,
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
              color: isDark ? PAppColor.whiteColor : PAppColor.text700,
            ),
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Container(
      height: PAppSize.s1,
      color: isDark ? PAppColor.darkBorderColor : PAppColor.fillColor4,
    );
  }
}
