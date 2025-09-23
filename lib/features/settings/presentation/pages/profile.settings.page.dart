import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PProfileSettingsPage extends StatelessWidget {
  PProfileSettingsPage({super.key});

  final ctrl = Get.put(PSettingsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('settings'.tr)),
      body: Column(
        children: [
          PAppSize.s2.verticalSpace,

          // PAppSize.s36.verticalSpace,
          Container(
            // padding: EdgeInsets.all(PAppSize.s8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PAppSize.s20),
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkAppBarColor
                  : PAppColor.whiteColor,
            ),
            child: Column(
              children: [
                // ListTile(
                //   contentPadding: EdgeInsets.only(
                //     left: PAppSize.s16,
                //     right: PAppSize.s20,
                //   ),
                //   onTap: () => PHelperFunction.switchScreen(
                //     destination: Routes.changePasswordPage,
                //   ),
                //   leading: Assets.icons.lockIcon.svg(
                //     color: PHelperFunction.isDarkMode(context)
                //         ? PAppColor.whiteColor
                //         : PAppColor.darkAppBarColor,
                //   ),
                //   title: Text(
                //     'change_password'.tr,
                //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   trailing: Assets.icons.arrowForwardIos.svg(
                //     color: PHelperFunction.isDarkMode(context)
                //         ? PAppColor.whiteColor
                //         : PAppColor.darkAppBarColor,
                //   ),
                // ),
                // Divider(color: PAppColor.fillColor),
                SettingsListTile(
                  leading: Assets.icons.lockOutline.svg(
                    height: PAppSize.s24,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.darkAppBarColor,
                  ),
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.changePasswordPage,
                  ),

                  padding: EdgeInsets.only(
                    left: PAppSize.s14,
                    right: PAppSize.s24,
                    top: PAppSize.s18,
                    bottom: PAppSize.s18,
                  ),
                  title: Text(
                    'change_password'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Assets.icons.arrowForwardIos.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.darkAppBarColor,
                  ),
                ),
                Divider(
                  color: PHelperFunction.isDarkMode(context)
                      ? PAppColor.fillColor2
                      : PAppColor.fillColor,
                  height: PAppSize.s0,
                ),
                SettingsListTile(
                  leading: Assets.icons.faceId24.svg(
                    height: PAppSize.s24,
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.darkAppBarColor,
                  ),
                  onTap: null,

                  padding: EdgeInsets.symmetric(
                    horizontal: PAppSize.s14,
                    vertical: PAppSize.s12,
                  ),

                  title: Text(
                    'enable_face_id'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Obx(
                    () => CupertinoSwitch(
                      activeTrackColor: PAppColor.primary,
                      thumbColor: ctrl.notification.value
                          ? PAppColor.whiteColor
                          : PAppColor.text100,
                      value: ctrl.notification.value,
                      onChanged: ctrl.onNotificationChanged,
                    ),
                  ),
                ),

                // ListTile(
                //   contentPadding: EdgeInsets.only(
                //     left: PAppSize.s12,
                //     right: PAppSize.s16,
                //   ),
                //   title: Text(
                //     'enable_face_id'.tr,
                //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   leading: Assets.icons.faceId24.svg(
                //     color: PHelperFunction.isDarkMode(context)
                //         ? PAppColor.whiteColor
                //         : PAppColor.darkAppBarColor,
                //   ),
                //   trailing: Obx(
                //     () => CupertinoSwitch(
                //       activeTrackColor: PAppColor.primary,
                //       thumbColor: ctrl.notification.value
                //           ? PAppColor.whiteColor
                //           : PAppColor.text100,
                //       value: ctrl.notification.value,
                //       onChanged: ctrl.onNotificationChanged,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     showConfirmDialog(
          //       context: context,
          //       content: Text(
          //         'signout_dialog_desc'.tr,
          //         style: Theme.of(context).textTheme.bodyLarge,
          //       ),
          //       onPositiveTap: () {
          //         PHelperFunction.pop();
          //         ctrl.signout(soft: false);
          //       },
          //     );
          //   },
          //   title: Text(
          //     'signout'.tr,
          //     style: Theme.of(context).textTheme.bodyMedium,
          //   ),
          //   trailing: Assets.icons.arrowForwardIos.svg(),
          // ),
          // Divider(color: PAppColor.fillColor),
          // PAppSize.s16.verticalSpace,
          // Align(
          //       alignment: Alignment.bottomLeft,
          //       child: Text(
          //         'delete_account'.tr,
          //         textAlign: TextAlign.start,
          //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //           color: PAppColor.redColor,
          //         ),
          //       ),
          //     )
          //     .symmetric(horizontal: PAppSize.s16, vertical: PAppSize.s20)
          //     .onPressed(
          //       onTap: () {
          //         showConfirmDialog(
          //           context: context,
          //           content: RichText(
          //             textAlign: TextAlign.center,
          //             text: TextSpan(
          //               text: 'Are you sure you want to permanently',
          //               style: Theme.of(context).textTheme.bodyLarge
          //                   ?.copyWith(color: PAppColor.blackColor),
          //               children: [
          //                 TextSpan(
          //                   text: ' delete your account?',
          //                   style: Theme.of(context).textTheme.bodyLarge
          //                       ?.copyWith(color: PAppColor.redColor),
          //                 ),
          //               ],
          //             ),
          //           ),

          //           onPositiveTap: () {
          //             PHelperFunction.pop();
          //             ctrl.deleteAccount();
          //           },
          //         );
          //       },
          //     ),
        ],
      ).scrollable().symmetric(horizontal: PAppSize.s20, vertical: PAppSize.s20),
    );
  }
}

class SetttingListTile extends StatelessWidget {
  const SetttingListTile({super.key, required this.ctrl});

  final PSettingsVm ctrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Assets.icons.faceId24.svg(
              height: PAppSize.s24,
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.darkAppBarColor,
            ),
            PAppSize.s10.horizontalSpace,
            Text(
              'enable_face_id'.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Obx(
          () => CupertinoSwitch(
            activeTrackColor: PAppColor.primary,
            thumbColor: ctrl.notification.value
                ? PAppColor.whiteColor
                : PAppColor.text100,
            value: ctrl.notification.value,
            onChanged: ctrl.onNotificationChanged,
          ),
        ),
      ],
    );
  }
}
