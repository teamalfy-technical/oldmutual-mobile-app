import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class PRelationshipOfficerCard extends StatelessWidget {
  final Member? user;
  final String? label;
  const PRelationshipOfficerCard({super.key, this.user, this.label});

  Future<void> _dialPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendSms(String phone) async {
    final uri = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Hello from Old Mutual Pensions'},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final affluentVm = PAffluentVm.instance;

    return user?.affluent == true
        ? Obx(() {
            final officer = affluentVm.relationshipOfficer.value;
            final officerName = officer.name ?? 'not_applicable'.tr;

            return Container(
              padding: EdgeInsets.all(PAppSize.s16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PAppSize.s20),
                color: PHelperFunction.isDarkMode(context)
                    ? PAppColor.darkAppBarColor
                    : PAppColor.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Office Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: label == null,
                          child: Text(
                            'your_relationship_officer'.tr,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s14,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        Text(
                          label ?? officerName,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: PAppSize.s16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),

                  ctaButton(
                    context: context,
                    onTap: () {
                      if (officer.phone != null) {
                        _dialPhone(officer.phone!);
                      } else {
                        PPopupDialog(context).warningMessage(
                          title: 'unavailable'.tr,
                          message:
                              'Your relationship officer\'s phone number is currently unavailable. Please try again later.',
                        );
                      }
                    },
                    icon: Assets.icons.call.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.primary,
                    ),
                  ),
                  PAppSize.s8.horizontalSpace,
                  ctaButton(
                    context: context,
                    onTap: () {
                      if (officer.phone != null) {
                        _sendSms(officer.phone!);
                      } else {
                        PPopupDialog(context).warningMessage(
                          title: 'unavailable'.tr,
                          message:
                              'Your relationship officer\'s phone number is currently unavailable. Please try again later.',
                        );
                      }
                    },
                    icon: Assets.icons.chat.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.primary,
                    ),
                  ),

                  PAppSize.s8.horizontalSpace,
                  ctaButton(
                    context: context,
                    onTap: () {
                      if (officer.email != null) {
                        _sendEmail(officer.email!);
                      } else {
                        PPopupDialog(context).warningMessage(
                          title: 'unavailable'.tr,
                          message:
                              'Your relationship officer\'s email address is currently unavailable. Please try again later.',
                        );
                      }
                    },
                    icon: Assets.icons.mail.svg(
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.whiteColor
                          : PAppColor.primary,
                    ),
                  ),
                ],
              ),
            );
          })
        : SizedBox.shrink();
  }

  Widget ctaButton({
    required BuildContext context,
    required Function()? onTap,
    required Widget icon,
  }) {
    return Container(
      padding: EdgeInsets.all(PAppSize.s10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: PAppSize.s1,
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.whiteColor
              : PAppColor.primary,
        ),
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkAppBarColor
            : PAppColor.whiteColor,
      ),
      child: icon.onPressed(onTap: onTap),
    );
  }
}
