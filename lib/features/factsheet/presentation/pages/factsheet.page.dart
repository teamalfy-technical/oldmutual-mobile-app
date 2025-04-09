import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/factsheet/presentation/vm/factsheet.vm.dart';
import 'package:oldmutual_pensions_app/features/factsheet/presentation/widgets/chart.redact.widget.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:redacted/redacted.dart';

class PFactSheetPage extends StatelessWidget {
  PFactSheetPage({super.key});

  final ctrl = Get.put(PFactsheetVm());

  @override
  Widget build(BuildContext context) {
    int lowestYear =
        ctrl.performances.isEmpty
            ? DateTime.now().year - 5
            : ctrl.performances
                .map((e) => e.year ?? 0)
                .reduce((a, b) => a < b ? a : b);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('factsheet_title'.tr),
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PPageTagWidget(tag: 'factsheet_hint'.tr),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ctrl.getPerformances,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PAppSize.s22.verticalSpace,
                      Text(
                            '${'performance_since'.tr} $lowestYear',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )
                          .symmetric(horizontal: PAppSize.s10)
                          .redacted(
                            context: context,
                            redact:
                                ctrl.loading.value == LoadingState.loading
                                    ? true
                                    : false,
                          ),
                      PAppSize.s16.verticalSpace,

                      // bar chart
                      Expanded(
                        child:
                            ctrl.loading.value == LoadingState.loading
                                ? PChartRedactWidget(
                                  loadingState: ctrl.loading.value,
                                )
                                : Stack(
                                  children: [
                                    PCustomLineChartNew(
                                      data: ctrl.performances,
                                    ),
                                    Positioned(
                                      left: PAppSize.s0,
                                      right: PAppSize.s0,
                                      bottom:
                                          PDeviceUtil.getDeviceHeight(context) *
                                          0.042,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Assets.icons.anchorIcon.svg(),
                                              PAppSize.s3.horizontalSpace,
                                              Text(
                                                'anchor'.tr.toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: PAppSize.s10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          PAppSize.s20.horizontalSpace,
                                          Row(
                                            children: [
                                              Assets.icons.benchmarkIcon.svg(),
                                              PAppSize.s3.horizontalSpace,
                                              Text(
                                                'benchmark'.tr.toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.copyWith(
                                                  fontWeight: FontWeight.w500,

                                                  fontSize: PAppSize.s10,
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
                      PAppSize.s16.verticalSpace,
                      Text(
                        'fund_composition'.tr,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ).symmetric(horizontal: PAppSize.s10),
                      PAppSize.s8.verticalSpace,
                      Text(
                        'asset_allocation'.tr,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: PAppColor.primaryTextColor,
                        ),
                      ).symmetric(horizontal: PAppSize.s10),
                      PAppSize.s16.verticalSpace,
                      // bar chart
                      Expanded(
                        child:
                            ctrl.loading.value == LoadingState.loading
                                ? PChartRedactWidget(
                                  loadingState: ctrl.loading.value,
                                )
                                : PCustomBarChartNew(data: ctrl.compositions),
                      ),
                    ],
                  ).symmetric(horizontal: PAppSize.s20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
