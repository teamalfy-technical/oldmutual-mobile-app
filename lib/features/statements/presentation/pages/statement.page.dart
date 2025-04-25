import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/presentation/vm/statement.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.dropdown.dart';

class PStatementPage extends StatelessWidget {
  PStatementPage({super.key});

  final ctrl = Get.put(PStatementVm());

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'period': '2024',
        'generated_on': '10-05-2024',
        'actions': 'Download PDF',
      },
      {
        'period': '2023',
        'generated_on': '10-05-2023',
        'actions': 'Download PDF',
      },
      {
        'period': 'All',
        'generated_on': '10-05-2023',
        'actions': 'Download PDF',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('statements'.tr)),
      body: Column(
        children: [
          PPageTagWidget(
            tag: 'statements_hint_tag'.tr,
            textAlign: TextAlign.center,
          ),

          // Filter
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  GetBuilder<PStatementVm>(
                    initState: (state) {
                      ctrl.getContributedYears();
                    },
                    builder: (ctrl) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: PCustomDropdown<ContributedYear>(
                              label: '',
                              value: ctrl.selectedYear,
                              onChanged: ctrl.onYearChanged,
                              items: ctrl.contributionYears,
                              radius: PAppSize.s12,
                              height: PAppSize.s33,
                            ),
                          ),

                          PAppSize.s18.horizontalSpace,

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: PAppSize.s10,
                                vertical: PAppSize.s1,
                              ),
                              decoration: BoxDecoration(
                                color: PAppColor.fillColor2,
                                borderRadius: BorderRadius.circular(
                                  PAppSize.s12,
                                ),
                              ),
                              child: Obx(
                                () => PCustomCheckbox(
                                  value: ctrl.all.value,
                                  onChanged: ctrl.onAllChanged,
                                  checkboxDirection: Direction.right,
                                  fillColor: WidgetStateProperty.resolveWith((
                                    states,
                                  ) {
                                    if (states.contains(WidgetState.selected)) {
                                      return PAppColor.primary;
                                    } else {
                                      return Color(
                                        0xFFD9D9D9,
                                      ).withOpacityExt(PAppSize.s0_6);
                                    }
                                  }),
                                  child: Text(
                                    'all'.tr,
                                    // style: Theme.of(context).textTheme.bodySmall
                                    //     ?.copyWith(fontSize: PAppSize.s14),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          PAppSize.s18.horizontalSpace,

                          PGradientButton(
                            label: 'generate'.tr,
                            showIcon: false,
                            radius: PAppSize.s12,
                            loading: ctrl.loading.value,
                            width: PDeviceUtil.getDeviceWidth(context) * 0.30,
                            height: PAppSize.s32,
                            onTap: () {
                              if (ctrl
                                      .generatedReport
                                      .value
                                      .message
                                      ?.reportId !=
                                  null) {
                                ctrl.checkReportStatus();
                              } else {
                                ctrl.generateReport();
                              }
                            },
                          ),

                          // PCustomCheckbox(
                          //   value: ctrl.all.value,
                          //   scale: PAppSize.s1_3,
                          //   onChanged: ctrl.onAllChanged,
                          //   checkboxDirection: Direction.right,
                          //   child: Text(
                          //     'all'.tr,
                          //     style: Theme.of(context).textTheme.headlineSmall
                          //         ?.copyWith(fontWeight: FontWeight.w400),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),

                  PAppSize.s25.verticalSpace,

                  ctrl.reportStatus.value.isEmpty()
                      ? SizedBox.shrink()
                      : Expanded(
                        child:
                            Table(
                              // border: TableBorder.all(),
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      'period'.tr,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontSize: PAppSize.s16),
                                    ),
                                    Text(
                                      'generated_on'.tr,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontSize: PAppSize.s16),
                                    ),
                                    Text(
                                      'actions'.tr,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontSize: PAppSize.s16),
                                    ),
                                  ],
                                ),
                                ...ctrl.reports.map(
                                  (item) => TableRow(
                                    children: [
                                      Text(
                                        '${DateTime.parse(item.createdAt ?? DateTime.now().toIso8601String()).year}',
                                        textAlign: TextAlign.start,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.copyWith(),
                                      ).symmetric(vertical: PAppSize.s8),
                                      Text(
                                        PFormatter.formatDate(
                                          dateFormat: DateFormat('dd-MM-yyyy'),
                                          date: DateTime.parse(
                                            item.createdAt ??
                                                DateTime.now()
                                                    .toIso8601String(),
                                          ),
                                        ),
                                        textAlign: TextAlign.start,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.copyWith(),
                                      ).symmetric(vertical: PAppSize.s8),
                                      Text(
                                            'download_pdf'.tr,
                                            textAlign: TextAlign.end,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.copyWith(
                                              color: PAppColor.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  PAppColor.primary,
                                            ),
                                          )
                                          .onPressed(
                                            onTap:
                                                () => ctrl.downloadFile(
                                                  item.downloadUrl ?? '',
                                                ),
                                          )
                                          .symmetric(vertical: PAppSize.s8),
                                    ],
                                  ),
                                ),
                              ],
                            ).scrollable(),
                      ),
                ],
              ).all(PAppSize.s20),
            ),
          ),
        ],
      ),
    );
  }
}
