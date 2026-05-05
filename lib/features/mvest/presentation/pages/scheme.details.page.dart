import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSchemeDetailsPage extends StatefulWidget {
  const PSchemeDetailsPage({super.key});

  @override
  State<PSchemeDetailsPage> createState() => _PSchemeDetailsPageState();
}

class _PSchemeDetailsPageState extends State<PSchemeDetailsPage> {
  // Reuse the existing VM across the onboarding flow rather than wiping
  // collected state when the user navigates back to this page.
  final ctrl = Get.isRegistered<PMVestVm>()
      ? Get.find<PMVestVm>()
      : Get.put(PMVestVm());

  @override
  void initState() {
    super.initState();
    ctrl.contributionAmountTEC.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    ctrl.contributionAmountTEC.removeListener(_onAmountChanged);
    super.dispose();
  }

  void _onAmountChanged() => setState(() {});

  bool get _canContinue {
    final amount = double.tryParse(ctrl.contributionAmountTEC.text.trim());
    return ctrl.selectedFrequency.value != null && amount != null && amount > 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.whiteColor,
      appBar: AppBar(title: Text('scheme_details'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          child: PAnimatedColumnWidget(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s8.verticalSpace,
              Text(
                'step_n_of_n'.trParams({'current': '1', 'total': '4'}),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s13,
                  fontWeight: FontWeight.w600,
                  color: PAppColor.primaryDark,
                ),
              ),
              PAppSize.s8.verticalSpace,
              Text(
                'choose_contribution_hint'.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s14,
                  color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                ),
              ),
              PAppSize.s20.verticalSpace,
              Obx(
                () => Column(
                  children: [
                    _FrequencyOptionTile(
                      label: 'monthly'.tr,
                      value: MVestFrequency.monthly,
                      groupValue: ctrl.selectedFrequency.value,
                      onChanged: (v) {
                        ctrl.onFrequencyChanged(v);
                        setState(() {});
                      },
                    ),
                    // PAppSize.s12.verticalSpace,
                    // _FrequencyOptionTile(
                    //   label: 'yearly'.tr,
                    //   value: MVestFrequency.yearly,
                    //   groupValue: ctrl.selectedFrequency.value,
                    //   onChanged: (v) {
                    //     ctrl.onFrequencyChanged(v);
                    //     setState(() {});
                    //   },
                    // ),
                    PAppSize.s12.verticalSpace,
                    _FrequencyOptionTile(
                      label: 'lump_sum'.tr,
                      value: MVestFrequency.lumpSum,
                      groupValue: ctrl.selectedFrequency.value,
                      onChanged: (v) {
                        ctrl.onFrequencyChanged(v);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              PAppSize.s24.verticalSpace,
              PCustomTextField(
                labelText: 'contribution_amount_ghc'.tr,
                controller: ctrl.contributionAmountTEC,
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: PValidator.validatePaymentAmount,
              ),
              PAppSize.s24.verticalSpace,
              PGradientButton(
                label: 'continue'.tr,
                showIcon: false,
                textColor: PAppColor.whiteColor,
                width: PDeviceUtil.getDeviceWidth(context),
                onTap: _canContinue
                    ? () => PHelperFunction.switchScreen(
                        destination: Routes.mvestBeneficiariesPage,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrequencyOptionTile extends StatelessWidget {
  final String label;
  final MVestFrequency value;
  final MVestFrequency? groupValue;
  final ValueChanged<MVestFrequency?> onChanged;

  const _FrequencyOptionTile({
    required this.label,
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
              : (isDark ? PAppColor.transparentColor : PAppColor.fillColor5),
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
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? PAppColor.primaryBorderColor
                  : (isDark ? PAppColor.fillColor2 : PAppColor.text700),
              size: PAppSize.s22,
            ),
            PAppSize.s12.horizontalSpace,
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
