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
                ).onPressed(onTap: () => ctrl.chooseFromGallery()),
                // PCachedImageWidget(url: url, height: height),
                Positioned(
                  right: PAppSize.s10,
                  bottom: 0,
                  child: Assets.icons.addIcon.svg().onPressed(
                    onTap: () => ctrl.chooseFromGallery(),
                  ),
                ),
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
                            ctrl.profile.value.name ?? '*********************',
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
                            ctrl.profile.value.email ?? '*********************',
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
                            PSecureStorage().getBioData()?.mobileNo ??
                            '*********************',
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
                            ctrl.profile.value.memberNumber ??
                            '*********************',
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
                            '*********************',
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
                            ctrl.profile.value.ssnitNumber ??
                            '*********************',
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
                        title: 'scheme_name'.tr,
                        subtitle:
                            PSecureStorage().getBioData()?.schemeName ??
                            '*********************',
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
                            PSecureStorage().getBioData()?.pensionTypeName ??
                            '*********************',
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
