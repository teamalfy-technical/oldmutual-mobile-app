import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PBeneficiaryWidget extends StatelessWidget {
  final Beneficiary beneficiary;
  final int index;
  final LoadingState loading;
  final Function(bool)? onExpansionChanged;
  const PBeneficiaryWidget({
    super.key,
    required this.beneficiary,
    required this.index,
    required this.loading,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint(beneficiary['show'].toString());
    return Column(
      children: [
        ExpansionTile(
          title: Text(
            beneficiary.fullName ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          tilePadding: EdgeInsets.symmetric(horizontal: PAppSize.s22),
          initiallyExpanded: beneficiary.show ?? false,
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.symmetric(
            horizontal: PAppSize.s22,
            vertical: PAppSize.s10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
          onExpansionChanged: onExpansionChanged,
          expansionAnimationStyle: AnimationStyle(
            curve: Curves.linearToEaseOut,
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            // side: BorderSide(width: 1, color: PAppColor.fillColor),
            side: BorderSide.none,
          ),

          trailing:
              beneficiary.show == false
                  ? SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'view_details'.tr,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: PAppColor.primary),
                        ),
                        PAppSize.s8.horizontalSpace,
                        Assets.icons.arrowForwardIos.svg(),
                      ],
                    ),
                  )
                  : Assets.icons.arrowDownIos.svg(),
          children: [
            detailWidget(
              context,
              'dob'.tr,
              PFormatter.formatDate(
                dateFormat: DateFormat('dd-MM-yyyy'),
                date: DateTime.parse(
                  beneficiary.birthDate ?? DateTime.now().toIso8601String(),
                ),
              ),
            ),
            detailWidget(
              context,
              'benefit_percentage'.tr,
              '${beneficiary.percAlloc}%',
            ),
            detailWidget(
              context,
              'relation'.tr,
              beneficiary.relationship ?? '',
            ),
          ],
        ),
        Divider(color: PAppColor.fillColor),
      ],
    );
  }

  Widget detailWidget(BuildContext context, String label, String value) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: ' : $value',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
