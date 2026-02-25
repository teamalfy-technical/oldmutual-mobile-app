import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class AffluentBadgeWidget extends StatelessWidget {
  final Member? user;
  const AffluentBadgeWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return (user?.affluent == false)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Assets.icons.affluentAvatar.svg(
                    height: PAppSize.s60,
                    // width: PAppSize.s70,
                  ),
                  PAppSize.s8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user?.name}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: PAppSize.s16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: PAppSize.s4),
                        padding: EdgeInsets.symmetric(
                          horizontal: PAppSize.s10,
                          vertical: PAppSize.s4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PAppSize.s22),
                          gradient: LinearGradient(
                            colors: [PAppColor.primaryDark, PAppColor.primary],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.icons.affluentBadge.svg(
                              height: PAppSize.s20,
                            ),
                            PAppSize.s4.horizontalSpace,
                            Text(
                              'affluent'.tr,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s16,
                                    color: PAppColor.blackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PAppSize.s8.verticalSpace,

              Text(
                'affluent_desc'.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: PAppSize.s14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ).only(left: PAppSize.s20, bottom: PAppSize.s16)
        : SizedBox.shrink();
  }
}
