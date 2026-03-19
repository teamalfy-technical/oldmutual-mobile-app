import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/presentation/widgets/more.listtile.widget.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PProfileTab extends StatelessWidget {
  final Map<String, String?> userData;
  final bool isLoading;

  const PProfileTab({
    super.key,
    required this.userData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: isLoading,
      child: Container(
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
        child: PAnimatedColumnWidget(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData['fullName'] ?? 'not_applicable'.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            PAppSize.s8.verticalSpace,
            PMoreListTitle(
              title: 'email'.tr,
              subTitle: userData['email'] ?? 'not_applicable'.tr,
              isLoading: isLoading,
            ),
            Divider(height: PAppSize.s1),
            PMoreListTitle(
              title: 'phone_number'.tr,
              subTitle: userData['phone'] ?? 'not_applicable'.tr,
              isLoading: isLoading,
            ),
            Divider(height: PAppSize.s1),
            PMoreListTitle(
              title: 'ghana_card_id'.tr,
              subTitle: userData['ghanaCardNumber'] ?? 'not_applicable'.tr,
              isLoading: isLoading,
            ),
            Divider(height: PAppSize.s1),
            PMoreListTitle(
              title: 'ssnit_number'.tr,
              subTitle: userData['ssnitNumber'] ?? 'not_applicable'.tr,
              isLoading: isLoading,
            ),
            Divider(height: PAppSize.s1),
            PMoreListTitle(
              title: 'date_of_birth'.tr,
              subTitle: isLoading
                  ? 'not_applicable'.tr
                  : userData['dob'] == null
                  ? 'not_applicable'.tr
                  : PFormatter.formatDate(
                      dateFormat: DateFormat('MMMM d, y'),
                      date: DateTime.parse(
                        userData['dob'] ?? DateTime.now().toIso8601String(),
                      ),
                    ),
              isLoading: isLoading,
            ),
            Divider(height: PAppSize.s1),
          ],
        ).scrollable(),
      ),
    );
  }
}
