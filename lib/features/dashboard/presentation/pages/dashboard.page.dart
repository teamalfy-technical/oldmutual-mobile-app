import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/dashboard/presentation/vm/dashboard.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PDashboardPage extends StatelessWidget {
  PDashboardPage({super.key});

  final ctrl = Get.put(PDashboardVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PAnnotatedRegion(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  // height: PDeviceUtil.getDeviceHeight(context) / 3.5,
                  height: PDeviceUtil.getDeviceHeight(context) * 0.3,
                  decoration: BoxDecoration(color: PAppColor.blackColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${'welcome'.tr}, ${PSecureStorage().getAuthResponse()?.name ?? ''}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: PAppColor.whiteColor,
                        ),
                      ),
                      PAppSize.s8.verticalSpace,
                      Text(
                        'Your Schemes',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: PAppColor.whiteColor,
                        ),
                      ),
                      PAppSize.s6.verticalSpace,
                    ],
                  ).only(bottom: PDeviceUtil.getDeviceWidth(context) * 0.15),
                ),
                Opacity(
                  opacity: PAppSize.s0_3,
                  child: Image.asset(
                    Assets.images.dashboardBg.path,
                    fit: BoxFit.cover,
                    width: PDeviceUtil.getDeviceWidth(context),
                    height: PDeviceUtil.getDeviceHeight(context) * 0.70,
                    colorBlendMode: BlendMode.dstATop,
                    color: PAppColor.whiteColor.withOpacityExt(
                      PAppSize.s0_6,
                    ), // Adjust opacity
                  ),
                ),
              ],
            ),

            Obx(
              () => Positioned(
                top:
                    (ctrl.schemes.isEmpty &&
                            ctrl.loading.value == LoadingState.completed)
                        ? PDeviceUtil.getDeviceHeight(context) * 0.45
                        : PDeviceUtil.getDeviceHeight(context) * 0.22,
                // bottom: PDeviceUtil.getDeviceHeight(context) * 0.02,
                left: PAppSize.s16,
                right: PAppSize.s16,
                bottom: PAppSize.s0,
                child: RefreshIndicator(
                  onRefresh: ctrl.getMemberSchemes,
                  color: PAppColor.primary,
                  child:
                      ctrl.loading.value == LoadingState.loading
                          ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return PensionTierRedactWidget(
                                loading: ctrl.loading.value,
                              );
                            },
                          )
                          : ctrl.schemes.isEmpty
                          ? PEmptyStateWidget(message: 'no_results_found'.tr)
                          : ListView.builder(
                            itemCount: ctrl.schemes.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final scheme = ctrl.schemes[index];
                              return PensionTierWidget(
                                scheme: scheme,
                                onTap: () {
                                  ctrl.getMemberSelectedScheme(
                                    employerNumber: scheme.employerNumber ?? '',
                                    memberNumber: scheme.memberNumber ?? '',
                                    ssnitNumber: scheme.ssnitNumber ?? '',
                                    masterScheme:
                                        scheme.masterSchemeDescription ?? '',
                                  );
                                  PHelperFunction.switchScreen(
                                    destination: Routes.homePage,
                                    replace: true,
                                  );
                                },
                              );
                            },
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
