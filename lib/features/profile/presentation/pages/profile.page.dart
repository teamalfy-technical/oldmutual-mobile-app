import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/profile/presentation/vm/profile.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.listtile.dart';
import 'package:redacted/redacted.dart';

class PProfilePage extends StatelessWidget {
  PProfilePage({super.key});

  final ctrl = Get.put(PProfileVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox.shrink(), title: Text('profile'.tr)),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PAppSize.s16.verticalSpace,
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(PAppSize.s24),
                  decoration:
                      ctrl.profileFile.value.path.isEmpty
                          ? BoxDecoration(
                            shape: BoxShape.circle,
                            color: PAppColor.blackColor,
                          )
                          : BoxDecoration(
                            shape: BoxShape.circle,
                            color: PAppColor.blackColor,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(ctrl.profileFile.value),
                            ),
                          ),
                  child: Assets.icons.userProfileIcon.svg(
                    color:
                        ctrl.profileFile.value.path.isEmpty
                            ? null
                            : PAppColor.transparentColor,
                  ),
                ),
                //.onPressed(onTap: () => ctrl.chooseFromGallery()),
                // PCachedImageWidget(url: url, height: height),
                // Positioned(
                //   right: PAppSize.s10,
                //   bottom: 0,
                //   child: Assets.icons.addIcon.svg().onPressed(
                //     onTap: () => ctrl.chooseFromGallery(),
                //   ),
                // ),
              ],
            ).centered(),
            PAppSize.s28.verticalSpace,
            Expanded(
              child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'full_name'.tr,
                        subtitle:
                            ctrl.profile.value.name ??
                            PSecureStorage().getAuthResponse()?.name ??
                            PSecureStorage().getBioData()?.fullName ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'email_address'.tr,
                        subtitle:
                            ctrl.profile.value.email ??
                            PSecureStorage().getAuthResponse()?.email ??
                            PSecureStorage().getBioData()?.email ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'mobile_number'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.phone ??
                            PSecureStorage().getBioData()?.mobileNo ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'membership_id'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.memberNumber ??
                            ctrl.profile.value.memberNumber ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'tin_number'.tr,
                        subtitle:
                            PSecureStorage().getBioData()?.tin ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      // PCustomListTile(
                      //   title: 'ghana_card_id'.tr,
                      //   subtitle:
                      //       PSecureStorage().getBioData()?.tin ?? '*********************',
                      // ).redacted(
                      //   context: context,
                      //   redact: ctrl.loading.value == LoadingState.loading ? true : false,
                      // ),
                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'ssnit_number'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.ssnitNumber ??
                            ctrl.profile.value.ssnitNumber ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'dob'.tr,
                        subtitle: PFormatter.formatDate(
                          dateFormat: DateFormat('dd-MM-yyyy'),
                          date: DateTime.parse(
                            PSecureStorage().getAuthResponse()?.dob ??
                                ctrl.profile.value.dob ??
                                DateTime.now().toIso8601String(),
                          ),
                        ),
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      Divider(color: PAppColor.fillColor),

                      PCustomListTile(
                        title: 'employer_name'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.employerName ??
                            PSecureStorage().getBioData()?.employerName ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'scheme_name'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.masterScheme ??
                            PSecureStorage().getBioData()?.schemeName ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      Divider(color: PAppColor.fillColor),
                      PCustomListTile(
                        title: 'pension_type'.tr,
                        subtitle:
                            PSecureStorage().getAuthResponse()?.schemeType ??
                            PSecureStorage().getBioData()?.pensionTypeName ??
                            'not_applicable'.tr,
                      ).redacted(
                        context: context,
                        redact:
                            ctrl.loading.value == LoadingState.loading
                                ? true
                                : false,
                      ),

                      Divider(color: PAppColor.fillColor),
                    ],
                  ).scrollable(),
            ),

            // Divider(color: PAppColor.fillColor),
            // PCustomListTile(
            //   title: 'date_of_number'.tr,
            //   subtitle:  PSecureStorage().getBioData(). ?? '*********************'
            // ).redacted(context: context, redact: ctrl.loading.value == LoadingState.loading ? true :false),
          ],
        ),
      ),
    );
  }
}
