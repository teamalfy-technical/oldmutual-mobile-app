import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PSupportPage extends StatelessWidget {
  final Member? user;
  const PSupportPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final affluentVm = PAffluentVm.instance;

    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('my_relationship_manager'.tr)),
      body: Obx(() {
        final officer = affluentVm.relationshipOfficer.value;
        final officerName = officer.name ?? 'not_applicable'.tr;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(PAppSize.s32),
              decoration: BoxDecoration(
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.cardDarkColor
                    : PAppColor.whiteColor,
                borderRadius: BorderRadius.circular(PAppSize.s20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.icons.affluentAvatar.svg(height: PAppSize.s70),
                  PAppSize.s20.verticalSpace,
                  Text(
                    officerName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: PAppSize.s20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  PAppSize.s8.verticalSpace,
                  Text(
                    'Senior Relationship Manager',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: PAppSize.s16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            PAppSize.s20.verticalSpace,

            // Contact Card
            PRelationshipOfficerCard(
              user: user,
              label: '${'contact'.tr} ${officerName.split(' ').last}',
            ),
            PAppSize.s20.verticalSpace,

            // Service Hours
            Text(
              'service_hours'.tr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: PAppSize.s16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Monday - Friday: 8:00 AM - 5:00 PM',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: PAppSize.s16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Saturday: 9:000 AM - 2:000 PM',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: PAppSize.s16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ).all(PAppSize.s20);
      }),
    );
  }
}
