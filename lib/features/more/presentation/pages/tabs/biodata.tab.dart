import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/presentation/widgets/more.listtile.widget.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBiodataTab extends StatelessWidget {
  final Map<String, String?> userData;
  final bool isLoading;

  const PBiodataTab({
    super.key,
    required this.userData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s16),
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
          PShimmerWrapper(
            loading: isLoading,
            child: Text(
              userData['fullName'] ?? 'not_applicable'.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          PAppSize.s8.verticalSpace,
          PMoreListTitle(
            title: 'member_no'.tr,
            subTitle: userData['memberNo'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'employer_name'.tr,
            subTitle: userData['employerName'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'employer_number'.tr,
            subTitle: userData['employerNumber'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'pension_type'.tr,
            subTitle: userData['pensionTypeName'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'scheme_name'.tr,
            subTitle: userData['schemeName'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'monthly_contribution'.tr,
            subTitle: userData['monthlyContribution'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'tin'.tr.toUpperCase(),
            subTitle: userData['tin'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
          PMoreListTitle(
            title: 'ssnit_number'.tr,
            subTitle: userData['ssnitNumber'] ?? 'not_applicable'.tr,
            isLoading: isLoading,
          ),
          Divider(height: PAppSize.s1),
        ],
      ).scrollable(),
    );
  }
}
