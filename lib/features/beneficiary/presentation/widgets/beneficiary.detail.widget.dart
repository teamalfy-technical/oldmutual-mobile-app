import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryDetailWidget extends StatelessWidget {
  final Beneficiary beneficiary;
  const PBeneficiaryDetailWidget({super.key, required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s20),
      height: PDeviceUtil.getDeviceHeight(context) * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s20),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkBgColor
            : PAppColor.fillColor,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PAppSize.s8.verticalSpace,
            PDialogTitleWidget(
              title: 'beneficiary'.tr,
              onClose: () => PHelperFunction.pop(),
            ),

            PAppSize.s14.verticalSpace,
            Divider(),

            // PAppSize.s6.verticalSpace,
            Expanded(
              child: Column(
                children: [
                  CustomListTile(
                    title: beneficiary.fullName ?? 'not_applicable'.tr,
                    subtitle: 'full_name'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: beneficiary.relationship ?? 'not_applicable'.tr,
                    subtitle: 'relationship'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: 'not_applicable'.tr,
                    subtitle: 'id_number'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: 'not_applicable'.tr,
                    subtitle: 'phone_number'.tr,
                  ),
                  Divider(),
                  CustomListTile(
                    title: 'not_applicable'.tr,
                    subtitle: 'email_address'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: beneficiary.address ?? 'not_applicable'.tr,
                    subtitle: 'address'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: beneficiary.birthDate == null
                        ? 'not_applicable'.tr
                        : beneficiary.birthDate == null
                        ? 'not_applicable'.tr
                        : PFormatter.formatDate(
                            dateFormat: DateFormat('d MMMM y'),
                            date: DateTime.parse(
                              beneficiary.birthDate ??
                                  DateTime.now().toIso8601String(),
                            ),
                          ),
                    subtitle: 'date_of_birth'.tr,
                  ),
                  Divider(),

                  CustomListTile(title: 'percentage_split'.tr),
                  Divider(),

                  CustomListTile(
                    title: beneficiary.fullName ?? 'not_applicable'.tr,
                    subtitle: 'beneficiary_name'.tr,
                  ),
                  Divider(),

                  CustomListTile(
                    title: '${beneficiary.percAlloc}%',
                    subtitle: 'percentage_split'.tr,
                  ),
                ],
              ).scrollable(),
            ),
          ],
        ),
      ),
    );
  }
}
