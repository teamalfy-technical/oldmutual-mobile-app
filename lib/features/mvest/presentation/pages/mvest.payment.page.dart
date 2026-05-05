import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestPaymentPage extends StatelessWidget {
  PMVestPaymentPage({super.key});

  final PMVestVm ctrl = Get.isRegistered<PMVestVm>()
      ? Get.find<PMVestVm>()
      : Get.put(PMVestVm());

  final PClaimsVm claimsCtrl = Get.isRegistered<PClaimsVm>()
      ? Get.find<PClaimsVm>()
      : Get.put(PClaimsVm());

  /// Replaces the webview with the MVest success page once the payment
  /// gateway reports success. Captures the contribution amount up front
  /// because the success-page close handler resets the flow state.
  void _onMVestPaymentSuccess(PClaimsVm claimsCtrl) {
    final amount = double.tryParse(ctrl.contributionAmountTEC.text.trim()) ?? 0;
    final formattedAmount = PFormatter.formatCurrency(amount: amount);
    PHelperFunction.switchScreen(
      destination: Routes.mvestSuccessPage,
      popAndPush: true,
      args: [
        'payment_success_title'.tr,
        'payment_success_msg'.trParams({'amount': '**$formattedAmount**'}),
        () {
          ctrl.resetInvestmentFlow();
          claimsCtrl.onPaymentMethodChanged(null);
          Get.until((route) => route.settings.name == Routes.mvestPage);
        },
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PMVestVm>();
    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.whiteColor,
      appBar: AppBar(title: Text('payment'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          child: PAnimatedColumnWidget(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s8.verticalSpace,
              Text(
                'step_n_of_n'.trParams({'current': '4', 'total': '4'}),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s13,
                  fontWeight: FontWeight.w600,
                  color: PAppColor.primaryDark,
                ),
              ),
              PAppSize.s8.verticalSpace,
              Text(
                'complete_subscription_hint'.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s14,
                  color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                ),
              ),
              PAppSize.s16.verticalSpace,
              _SummaryCard(ctrl: ctrl),
              PAppSize.s20.verticalSpace,
              Text(
                'payment_method'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: PAppSize.s15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                ),
              ),
              PAppSize.s12.verticalSpace,
              Obx(
                () => _PaymentMethodTile(
                  title: 'mobile_money'.tr,
                  subtitle: 'mobile_money_desc'.tr,
                  value: MVestPaymentMethod.mobileMoney,
                  groupValue: ctrl.selectedPaymentMethod.value,
                  onChanged: (v) => ctrl.selectedPaymentMethod.value = v,
                ),
              ),
              PAppSize.s100.verticalSpace,
              Obx(
                () => PGradientButton(
                  label: 'confirm_and_pay'.tr,
                  showIcon: true,
                  iconDirection: IconDirection.right,
                  textColor: PAppColor.whiteColor,
                  loading: ctrl.submitting.value,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: ctrl.selectedPaymentMethod.value != null
                      ? () async {
                          final ok = await ctrl.submitAndInitiatePayment();
                          if (!ok) return;
                          final checkoutUrl =
                              ctrl.paymentResponse.value?.checkoutUrl;
                          if (checkoutUrl == null || checkoutUrl.isEmpty) {
                            return;
                          }
                          PHelperFunction.switchScreen(
                            destination: Routes.webviewPage,
                            args: [
                              'make_payment'.tr,
                              checkoutUrl,
                              () => _onMVestPaymentSuccess(claimsCtrl),
                            ],
                          );
                        }
                      // () => PHelperFunction.switchScreen(
                      //     destination: Routes.mvestMobileMoneyPage,
                      //   )
                      : null,
                ),
              ),
              PAppSize.s12.verticalSpace,
            ],
          ).scrollable(),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final PMVestVm ctrl;
  const _SummaryCard({required this.ctrl});

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
        vertical: PAppSize.s18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SummaryRow(label: 'amount'.tr, value: _formattedAmount()),
          PAppSize.s12.verticalSpace,
          Container(
            height: PAppSize.s1,
            color: isDark ? PAppColor.darkBorderColor : PAppColor.fillColor4,
          ),
          PAppSize.s12.verticalSpace,
          _SummaryRow(
            label: 'frequency'.tr,
            value: _frequencyLabel(ctrl.selectedFrequency.value),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

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

class _PaymentMethodTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final MVestPaymentMethod value;
  final MVestPaymentMethod? groupValue;
  final ValueChanged<MVestPaymentMethod?> onChanged;

  const _PaymentMethodTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final isSelected = groupValue == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: PAppSize.s16,
          vertical: PAppSize.s14,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? PAppColor.primaryBorderColor.withOpacityExt(PAppSize.s0_1)
                    : PAppColor.primaryBorderLight)
              : (isDark ? PAppColor.cardDarkColor : PAppColor.fillColor5),
          border: Border.all(
            color: isSelected
                ? PAppColor.primaryBorderColor
                : PAppColor.fillColor4,
            width: PAppSize.s1,
          ),
          borderRadius: BorderRadius.circular(PAppSize.s12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                    ),
                  ),
                  PAppSize.s2.verticalSpace,
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: PAppSize.s13,
                      color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                    ),
                  ),
                ],
              ),
            ),
            PAppSize.s12.horizontalSpace,
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? PAppColor.primaryBorderColor
                  : (isDark ? PAppColor.fillColor2 : PAppColor.text500),
              size: PAppSize.s22,
            ),
          ],
        ),
      ),
    );
  }
}
