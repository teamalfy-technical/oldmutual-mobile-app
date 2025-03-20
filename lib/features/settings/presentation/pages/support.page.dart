import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/settings/presentation/vm/settings.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PSupportPage extends StatelessWidget {
  PSupportPage({super.key});

  final ctrl = Get.put(PSettingsVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('support'.tr)),
      body: Column(
        children: [
          PAppSize.s32.verticalSpace,
          Container(
            padding: EdgeInsets.all(PAppSize.s24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PAppColor.blackColor,
            ),
            child: Assets.icons.supportIcon.svg(),
          ),
          PAppSize.s36.verticalSpace,
          Text(
            'support_title'.tr,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),

          PAppSize.s32.verticalSpace,

          Text(
            'support_desc'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          PAppSize.s32.verticalSpace,

          Text(
            'send_us_email'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            '@customerchatbot.io'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ).symmetric(horizontal: PAppSize.s20),
    );
  }
}
