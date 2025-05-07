import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/presentation/vm/statement.vm.dart';
import 'package:oldmutual_pensions_app/features/statements/presentation/widgets/statement.widget.redact.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PStatementPage extends StatelessWidget {
  PStatementPage({super.key});

  final ctrl = Get.put(PStatementVm());

  @override
  Widget build(BuildContext context) {
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

                          Expanded(
                            child: Obx(
                              () => PGradientButton(
                                label: 'generate'.tr,
                                showIcon: false,

                                radius: PAppSize.s12,
                                loading: ctrl.generating.value,
                                width:
                                    PDeviceUtil.getDeviceWidth(context) * 0.30,
                                height: PAppSize.s32,
                                onTap: () {
                                  ctrl.generateReportV2();
                                },
                              ),
                            ),
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

                  Expanded(
                    child:
                        ctrl.loading.value == LoadingState.loading
                            ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return PStatementWidgetRedact(
                                  loading: ctrl.loading.value,
                                );
                              },
                            )
                            : RefreshIndicator.adaptive(
                              onRefresh: () => ctrl.getAllGeneratedReports(),
                              child: Table(
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
                                  ...ctrl.statements.map(
                                    (item) => TableRow(
                                      children: [
                                        Text(
                                          item.filters?.year ?? '',
                                          textAlign: TextAlign.start,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(),
                                        ).symmetric(vertical: PAppSize.s8),
                                        Text(
                                          PFormatter.formatDate(
                                            dateFormat: DateFormat(
                                              'dd-MM-yyyy',
                                            ),
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
                                              'view_pdf'.tr,
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
                                                  () => ctrl.openFile(
                                                    url: item.downloadUrl ?? '',
                                                    fileName:
                                                        ctrl.all.value
                                                            ? 'All_Contributions_Report.pdf'
                                                            : 'Contributions_${item.filters?.year ?? ''}_Report.pdf',
                                                  ),
                                            )
                                            .symmetric(vertical: PAppSize.s8),
                                      ],
                                    ),
                                  ),
                                ],
                              ).scrollable(
                                physics: AlwaysScrollableScrollPhysics(),
                              ),
                            ),
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
