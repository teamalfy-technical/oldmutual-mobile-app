import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PLivenessInfoPage extends StatefulWidget {
  const PLivenessInfoPage({super.key});

  @override
  State<PLivenessInfoPage> createState() => _PLivenessInfoPageState();
}

class _PLivenessInfoPageState extends State<PLivenessInfoPage> {
  final ctrl = Get.put(PAuthVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('identify_verification'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s8.verticalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PAppSize.s16.verticalSpace,
                  Text(
                    'liveness_check_hint'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: PAppColor.whiteColor,
                      fontSize: PAppSize.s20,
                    ),
                  ),
                  PAppSize.s10.verticalSpace,

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '${'liveness_info_title'.tr}\n',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: PAppColor.fillColor2,
                        fontSize: PAppSize.s14,
                      ),
                      children: [
                        TextSpan(
                          text: 'liveness_info_desc'.tr,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: PAppSize.s14,
                                color: Color(0xFFD5D5D5),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),

                  PAppSize.s40.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LivenessInstructionWidget(
                        icon: Assets.icons.selfie.svg(),
                        title: 'camera_hint_title'.tr,
                        desc: 'camera_hint_desc'.tr,
                      ),
                      LivenessInstructionWidget(
                        icon: Assets.icons.brightness.svg(),
                        title: 'lightning_hint_title'.tr,
                        desc: 'lightning_hint_desc'.tr,
                      ),
                      LivenessInstructionWidget(
                        icon: Assets.icons.face.svg(),
                        title: 'face_hint_title'.tr,
                        desc: 'face_hint_desc'.tr,
                      ),
                    ],
                  ),

                  PAppSize.s40.verticalSpace,

                  NoteWidget(
                    title: 'note_title'.tr,
                    description: 'note_msg'.tr,
                  ),

                  PAppSize.s24.verticalSpace, // alr

                  TextButton.icon(
                    iconAlignment: IconAlignment.start,
                    icon: Assets.icons.shield.svg(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: PAppSize.s7),
                    ),
                    onPressed: null,
                    label: RichText(
                      text: TextSpan(
                        text: '${'id_secure_msg'.tr} ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: PAppSize.s13,
                          color: PAppColor.fillColor2,
                        ),
                        children: [
                          TextSpan(
                            text: '${'confidential'.tr} ',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  fontWeight: FontWeight.w600,
                                  color: PAppColor.fillColor2,
                                ),
                          ),
                          TextSpan(
                            text: '${'and'.tr} ',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  color: PAppColor.fillColor2,
                                ),
                          ),
                          TextSpan(
                            text: '${'secure'.tr} ',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  fontWeight: FontWeight.w600,
                                  color: PAppColor.fillColor2,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).scrollable(),
            ),
            PGradientButton(
              label: 'verify_my_account'.tr,
              showIcon: false,
              loading: ctrl.loading.value,
              width: PDeviceUtil.getDeviceWidth(context),
              onTap: () {
                ctrl.verifyFaceIdentification();
              },
            ),

            PAppSize.s16.verticalSpace,
          ],
        ).symmetric(horizontal: PAppSize.s24, vertical: PAppSize.s10),
      ),
    );
  }
}
