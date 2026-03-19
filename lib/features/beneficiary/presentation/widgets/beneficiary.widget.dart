import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryWidget extends StatelessWidget {
  final Beneficiary beneficiary;
  final bool loading;
  final Function()? onTap;
  const PBeneficiaryWidget({
    super.key,
    required this.beneficiary,
    this.loading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: PAppSize.s24,
        backgroundColor: loading
            ? PAppColor.coolGrey.withOpacityExt(PAppSize.s0_2)
            : PAppColor.darkAppBarColor2,
        child: Text(
          beneficiary.fullName?.split(' ').first.substring(0, 1) ??
              'not_applicable'.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s15,
            color: PAppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(
        beneficiary.fullName ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            beneficiary.percAlloc == 100
                ? '${beneficiary.percAlloc}%'
                : '${beneficiary.percAlloc}% Split',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w500,
            ),
          ),

          Text(
            // '${beneficiary.relationship}',
            '${beneficiary.relationship} - ${beneficiary.birthDate == null ? 'not_applicable'.tr : PFormatter.formatDate(dateFormat: DateFormat('d MMMM y'), date: DateTime.parse(beneficiary.birthDate ?? DateTime.now().toIso8601String()))}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      trailing: loading
          ? PShimmerBox(
              width: PAppSize.s20,
              height: PAppSize.s20,
              shape: BoxShape.circle,
            )
          : Assets.icons.arrowRightBlack.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            ),
    );
  }
}
