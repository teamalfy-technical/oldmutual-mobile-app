import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/onboarding/domain/models/onboarding.model.dart';
import 'package:oldmutual_pensions_app/features/onboarding/presentation/vm/onboarding.vm.dart';
import 'package:oldmutual_pensions_app/features/onboarding/presentation/widgets/onboarding.widget.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/gradient.button.dart';
import 'package:oldmutual_pensions_app/shared/widgets/text.button.dart';

class POnboardingPage extends StatelessWidget {
  POnboardingPage({super.key});

  final ctrl = Get.put(POnboardingVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: ctrl.pageController,
                itemCount: slides.length,
                onPageChanged: ctrl.onPageChanged,
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return POnboardingWidget(imagePath: slide.image);
                  // return POnboardingWidget(slide: slide, ctrl: ctrl);
                },
              ),
              Positioned(
                left: PAppSize.s20,
                right: PAppSize.s20,
                bottom: PAppSize.s20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // text title && description
                    Text(
                      slides[ctrl.pageIndex.value].title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: PAppSize.s24,
                        color:
                            PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.primaryTextColor,
                      ),
                    ),
                    PAppSize.s12.verticalSpace,
                    Text(
                      slides[ctrl.pageIndex.value].description,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: PAppSize.s16,
                        color:
                            PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.text700,
                      ),
                    ),
                    PAppSize.s80.verticalSpace,

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children:
                    //       slides
                    //           .asMap()
                    //           .map(
                    //             (i, e) => MapEntry(
                    //               i,
                    //               Container(
                    //                 margin: const EdgeInsets.symmetric(
                    //                   horizontal: 4,
                    //                 ),
                    //                 width: ctrl.pageIndex.value == i ? 14 : 10,
                    //                 height: ctrl.pageIndex.value == i ? 14 : 10,
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color:
                    //                       ctrl.pageIndex.value == i
                    //                           ? PAppColor.primary
                    //                           : PAppColor.greyColor,
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //           .values
                    //           .toList(),
                    // ),
                    // PAppSize.s16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PGradientButton(
                          label:
                              ctrl.pageIndex.value == 3
                                  ? 'get_started'.tr.toUpperCase()
                                  : 'next'.tr.toUpperCase(),
                          width:
                              ctrl.pageIndex.value == 3
                                  ? PDeviceUtil.getDeviceWidth(context) * 0.42
                                  : PDeviceUtil.getDeviceWidth(context) * 0.28,
                          onTap: () => ctrl.navigateToNextScreen(),
                        ),

                        // SizedBox(
                        //   width: PAppSize.s200,
                        //   child: ElevatedButton.icon(
                        //     style: ElevatedButton.styleFrom(
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(30),
                        //       ),
                        //     ),
                        //     iconAlignment: IconAlignment.end,
                        //     icon: Assets.icons.arrowIcon.svg(),
                        //     onPressed: () => ctrl.navigateToNextScreen(),
                        //     label: Text('next'.tr),
                        //   ),
                        // ),
                        PTextButton(
                          label: 'skip'.tr.toUpperCase(),
                          foregroundColor:
                              PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.text700,
                          onPressed:
                              () => PHelperFunction.switchScreen(
                                destination: Routes.signupPage,
                                replace: true,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
