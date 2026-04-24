import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMVestBeneficiariesPage extends StatelessWidget {
  PMVestBeneficiariesPage({super.key});

  final ctrl = Get.put(PMVestVm());

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? PAppColor.darkBgColor : PAppColor.whiteColor,
      appBar: AppBar(title: Text('beneficiaries'.tr)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAppSize.s20),
          child: PAnimatedColumnWidget(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PAppSize.s8.verticalSpace,
              Text(
                'step_n_of_n'.trParams({'current': '2', 'total': '4'}),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: PAppSize.s13,
                  fontWeight: FontWeight.w600,
                  color: PAppColor.primaryDark,
                ),
              ),
              PAppSize.s8.verticalSpace,
              Text(
                'beneficiaries_allocation_hint'.trParams({
                  'max': '${PMVestVm.maxBeneficiaries}',
                }),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s14,
                  color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
                ),
              ),
              PAppSize.s16.verticalSpace,
              Obx(
                () => PMVestGradientProgressBar(
                  percentage: ctrl.allocatedPercentage,
                ),
              ),
              PAppSize.s12.verticalSpace,
              Obx(
                () => Text(
                  'allocated_of_total'.trParams({
                    'value': ctrl.allocatedPercentage.toStringAsFixed(0),
                  }),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? PAppColor.whiteColor : PAppColor.text700,
                  ),
                ),
              ),
              PAppSize.s20.verticalSpace,
              Obx(() {
                if (ctrl.beneficiaries.isEmpty) return const SizedBox.shrink();
                return Column(
                  children: List.generate(ctrl.beneficiaries.length, (i) {
                    final b = ctrl.beneficiaries[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: PAppSize.s12),
                      child: _BeneficiaryCard(
                        beneficiary: b,
                        onEdit: () {},
                        onDelete: () => ctrl.removeBeneficiaryAt(i),
                      ),
                    );
                  }),
                );
              }),
              PAppSize.s8.verticalSpace,
              Obx(
                () => OutlinedButton(
                  onPressed: ctrl.canAddMoreBeneficiaries
                      ? () => showAddBeneficiarySheet(context)
                      : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark
                        ? PAppColor.whiteColor
                        : PAppColor.text700,
                    side: BorderSide(
                      color: isDark
                          ? PAppColor.darkBorderColor
                          : PAppColor.fillColor4,
                      width: PAppSize.s1,
                    ),
                    minimumSize: Size.fromHeight(PAppSize.buttonHeight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PAppSize.s24),
                    ),
                  ),
                  child: Text(
                    'add_beneficiary'.tr,
                    style: TextStyle(
                      fontSize: PAppSize.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              PAppSize.s12.verticalSpace,
              Obx(
                () => PGradientButton(
                  label: 'continue'.tr,
                  showIcon: false,
                  textColor: PAppColor.whiteColor,
                  width: PDeviceUtil.getDeviceWidth(context),
                  onTap: ctrl.beneficiaries.isNotEmpty
                      ? () => PHelperFunction.switchScreen(
                          destination: Routes.mvestReviewPage,
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

class _BeneficiaryCard extends StatelessWidget {
  final MVestBeneficiary beneficiary;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BeneficiaryCard({
    required this.beneficiary,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final isTeen = beneficiary.ageCategory == MVestAgeCategory.teen;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: PAppSize.s16,
            vertical: PAppSize.s14,
          ),
          decoration: BoxDecoration(
            color: isDark ? PAppColor.cardDarkColor : PAppColor.whiteColor,
            border: Border.all(
              color: isDark ? PAppColor.darkBorderColor : PAppColor.fillColor4,
              width: PAppSize.s1,
            ),
            borderRadius: BorderRadius.circular(PAppSize.s12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beneficiary.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: PAppSize.s15,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? PAppColor.whiteColor
                            : PAppColor.text700,
                      ),
                    ),
                    PAppSize.s4.verticalSpace,
                    _PhoneAndAllocationLine(beneficiary: beneficiary),
                  ],
                ),
              ),
              PAppSize.s12.horizontalSpace,
              _EditDeleteActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ),
        Positioned(
          top: PAppSize.s0,
          right: PAppSize.s0,
          child: _AgeBadge(isTeen: isTeen),
        ),
      ],
    );
  }
}

class _PhoneAndAllocationLine extends StatelessWidget {
  final MVestBeneficiary beneficiary;
  const _PhoneAndAllocationLine({required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: PAppSize.s13,
      color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
    );
    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          if (beneficiary.phone.isNotEmpty) ...[
            TextSpan(text: beneficiary.phone),
            TextSpan(text: '  •  '),
          ],
          TextSpan(
            text: '${beneficiary.percentage.toStringAsFixed(0)}%',
            style: baseStyle?.copyWith(
              color: PAppColor.primaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditDeleteActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EditDeleteActions({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunction.isDarkMode(context);
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: PAppSize.s13,
      fontWeight: FontWeight.w500,
      color: isDark ? PAppColor.fillColor2 : PAppColor.text500,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('edit'.tr, style: style).onPressed(onTap: onEdit),
        Text('  •  ', style: style),
        Text('delete'.tr, style: style).onPressed(onTap: onDelete),
      ],
    );
  }
}

class _AgeBadge extends StatelessWidget {
  final bool isTeen;
  const _AgeBadge({required this.isTeen});

  @override
  Widget build(BuildContext context) {
    // final color = isTeen ? PAppColor.orangeColor : PAppColor.primaryDark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PAppSize.s10,
        vertical: PAppSize.s3,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isTeen
              ? [PAppColor.orangeColor, PAppColor.orangeColor]
              : [PAppColor.primaryDark, PAppColor.primary],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(PAppSize.s12),
          topRight: Radius.circular(PAppSize.s12),
          bottomLeft: Radius.circular(PAppSize.s12),
          bottomRight: Radius.circular(PAppSize.s0),
        ),
      ),
      child: Text(
        isTeen ? 'teen'.tr : 'adult'.tr,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: PAppSize.s11,
          fontWeight: FontWeight.w600,
          color: PAppColor.whiteColor,
        ),
      ),
    );
  }
}
