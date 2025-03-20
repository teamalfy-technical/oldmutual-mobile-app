import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PSettingsPage extends StatelessWidget {
  PSettingsPage({super.key});

  final ctrl = Get.put(PSettingsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body:
          Column(
            children: [
              PAppSize.s32.verticalSpace,
              Container(
                padding: EdgeInsets.all(PAppSize.s24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PAppColor.blackColor,
                ),
                child: Assets.icons.settingsIcon.svg(),
              ),
              PAppSize.s36.verticalSpace,
              Divider(color: PAppColor.fillColor),
              ListTile(
                title: Text(
                  'enable_notifications'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Obx(
                  () => CupertinoSwitch(
                    activeTrackColor: PAppColor.primary,
                    thumbColor:
                        ctrl.notification.value
                            ? PAppColor.whiteColor
                            : PAppColor.text100,
                    value: ctrl.notification.value,
                    onChanged: ctrl.onNotificationChanged,
                  ),
                ),
              ),
              Divider(color: PAppColor.fillColor),
              ListTile(
                onTap:
                    () => PHelperFunction.switchScreen(
                      destination: Routes.supportPage,
                    ),
                title: Text(
                  'support'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Assets.icons.arrowForwardIos.svg(),
              ),
              Divider(color: PAppColor.fillColor),
            ],
          ).scrollable(),
    );
  }
}
