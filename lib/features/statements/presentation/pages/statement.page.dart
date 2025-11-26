import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PStatementPage extends StatelessWidget {
  PStatementPage({super.key});

  final ctrl = Get.put(PStatementVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('statements'.tr)),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PPageTagWidget(
              //   tag: 'statements_hint_tag'.tr,
              //   textAlign: TextAlign.center,
              // ),
              Text(
                'generate_statements_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  // fontSize: PAppSize.s10,
                ),
              ),

              PAppSize.s10.verticalSpace,

              // Statements Filter Options
              PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  horizontal: PAppSize.s20,
                  vertical: PAppSize.s28,
                ),
                child: Column(
                  children: [
                    PCustomDropdownField<ContributedYear>(
                      labelText: 'select_year'.tr,
                      initialValue: ctrl.selectedYear,
                      items: ctrl.contributionYears
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.fundYear ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: ctrl.onYearChanged,
                    ),

                    // PAppSize.s16.verticalSpace,
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(labelText: 'select_scheme'.tr),
                    //   initialValue: 'All',
                    //   items: ['All', '2024']
                    //       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    //       .toList(),
                    //   onChanged: (val) {},
                    // ),
                    PAppSize.s16.verticalSpace,
                    PGradientButton(
                      label: 'generate_statement'.tr,
                      showIcon: false,
                      textColor: PAppColor.whiteColor,
                      radius: PAppSize.s20,
                      loading: ctrl.generating.value,
                      width: double.infinity,
                      height: PAppSize.s44,
                      onTap: () {
                        ctrl.generateReportV2();
                      },
                    ),
                  ],
                ),
              ),

              PAppSize.s10.verticalSpace,

              Text(
                'statements_generated_hint'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  // fontSize: PAppSize.s10,
                ),
              ),
              PAppSize.s10.verticalSpace,

              Expanded(
                child: PCustomCardWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: PAppSize.s16,
                    horizontal: PAppSize.s4,
                  ),

                  child: RefreshIndicator.adaptive(
                    onRefresh: () => ctrl.getAllGeneratedReports(),
                    child: ctrl.loading.value == LoadingState.loading
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return PStatementWidgetRedact(
                                loading: ctrl.loading.value,
                              );
                            },
                          ).symmetric(horizontal: PAppSize.s8)
                        : ctrl.statements.isEmpty
                        ? PEmptyStateWidget(message: 'no_results_found'.tr)
                        : ListView.separated(
                            shrinkWrap: true,

                            itemCount:
                                ctrl.statements.length, // limits to 4 safely
                            itemBuilder: (context, index) {
                              final statement = ctrl.statements[index];
                              return ListTile(
                                title: Text(
                                  statement.filters?.year == 'All'
                                      ? 'All Statements'
                                      : 'Statement ${statement.filters?.year}',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontSize: PAppSize.s14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                subtitle: Text(
                                  PFormatter.formatDate(
                                    dateFormat: DateFormat('yMMMMd'),
                                    date: DateTime.parse(
                                      statement.createdAt ??
                                          DateTime.now().toIso8601String(),
                                    ),
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: PAppSize.s13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                trailing: TextButton(
                                  onPressed: () => PHelperFunction.openFileWithURl(
                                    url: statement.downloadUrl ?? '',
                                    fileName: statement.filters?.year == 'All'
                                        ? 'All_Contributions_Report.pdf'
                                        : 'Contributions_${statement.filters?.year ?? ''}_Report.pdf',
                                  ),
                                  child: Text(
                                    'view_pdf'.tr,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontSize: PAppSize.s14,
                                          color: PAppColor.successMedium,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 0,
                            ).symmetric(horizontal: PAppSize.s20),
                          ),
                  ),
                ),
              ),

              // Filter
              // Expanded(
              //   child: Obx(
              //     () => Column(
              //       children: [
              //         GetBuilder<PStatementVm>(
              //           initState: (state) {
              //             ctrl.getContributedYears();
              //           },
              //           builder: (ctrl) {
              //             return Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 Expanded(
              //                   child: PCustomDropdown<ContributedYear>(
              //                     label: '',
              //                     value: ctrl.selectedYear,
              //                     onChanged: ctrl.onYearChanged,
              //                     items: ctrl.contributionYears,
              //                     radius: PAppSize.s12,
              //                     height: PAppSize.s33,
              //                   ),
              //                 ),

              //                 PAppSize.s18.horizontalSpace,

              //                 Expanded(
              //                   child: Container(
              //                     padding: EdgeInsets.symmetric(
              //                       horizontal: PAppSize.s10,
              //                       vertical: PAppSize.s1,
              //                     ),
              //                     decoration: BoxDecoration(
              //                       color: PAppColor.fillColor2,
              //                       borderRadius: BorderRadius.circular(
              //                         PAppSize.s12,
              //                       ),
              //                     ),
              //                     child: Obx(
              //                       () => PCustomCheckbox(
              //                         value: ctrl.all.value,
              //                         onChanged: ctrl.onAllChanged,
              //                         checkboxDirection: Direction.right,
              //                         fillColor: WidgetStateProperty.resolveWith((
              //                           states,
              //                         ) {
              //                           if (states.contains(WidgetState.selected)) {
              //                             return PAppColor.primary;
              //                           } else {
              //                             return Color(
              //                               0xFFD9D9D9,
              //                             ).withOpacityExt(PAppSize.s0_6);
              //                           }
              //                         }),
              //                         child: Text(
              //                           'all'.tr,
              //                           // style: Theme.of(context).textTheme.bodySmall
              //                           //     ?.copyWith(fontSize: PAppSize.s14),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 PAppSize.s18.horizontalSpace,

              //                 Expanded(
              //                   child: Obx(
              //                     () => PGradientButton(
              //                       label: 'generate'.tr,
              //                       showIcon: false,
              //                       radius: PAppSize.s12,
              //                       loading: ctrl.generating.value,
              //                       width:
              //                           PDeviceUtil.getDeviceWidth(context) * 0.30,
              //                       height: PAppSize.s32,
              //                       onTap: () {
              //                         ctrl.generateReportV2();
              //                       },
              //                     ),
              //                   ),
              //                 ),

              //                 // PCustomCheckbox(
              //                 //   value: ctrl.all.value,
              //                 //   scale: PAppSize.s1_3,
              //                 //   onChanged: ctrl.onAllChanged,
              //                 //   checkboxDirection: Direction.right,
              //                 //   child: Text(
              //                 //     'all'.tr,
              //                 //     style: Theme.of(context).textTheme.headlineSmall
              //                 //         ?.copyWith(fontWeight: FontWeight.w400),
              //                 //   ),
              //                 // ),
              //               ],
              //             );
              //           },
              //         ),

              //         PAppSize.s25.verticalSpace,

              //         Expanded(
              //           child:
              //               ctrl.loading.value == LoadingState.loading
              //                   ? ListView.builder(
              //                     shrinkWrap: true,
              //                     itemCount: 10,
              //                     padding: EdgeInsets.zero,
              //                     itemBuilder: (context, index) {
              //                       return PStatementWidgetRedact(
              //                         loading: ctrl.loading.value,
              //                       );
              //                     },
              //                   )
              //                   : RefreshIndicator.adaptive(
              //                     onRefresh: () => ctrl.getAllGeneratedReports(),
              //                     child: Table(
              //                       // border: TableBorder.all(),
              //                       children: [
              //                         TableRow(
              //                           children: [
              //                             Text(
              //                               'period'.tr,
              //                               textAlign: TextAlign.start,
              //                               style: Theme.of(context)
              //                                   .textTheme
              //                                   .headlineSmall
              //                                   ?.copyWith(fontSize: PAppSize.s16),
              //                             ),
              //                             Text(
              //                               'generated_on'.tr,
              //                               textAlign: TextAlign.start,
              //                               style: Theme.of(context)
              //                                   .textTheme
              //                                   .headlineSmall
              //                                   ?.copyWith(fontSize: PAppSize.s16),
              //                             ),
              //                             Text(
              //                               'actions'.tr,
              //                               textAlign: TextAlign.end,
              //                               style: Theme.of(context)
              //                                   .textTheme
              //                                   .headlineSmall
              //                                   ?.copyWith(fontSize: PAppSize.s16),
              //                             ),
              //                           ],
              //                         ),
              //                         ...ctrl.statements.map(
              //                           (item) => TableRow(
              //                             children: [
              //                               Text(
              //                                 item.filters?.year ?? '',
              //                                 textAlign: TextAlign.start,
              //                                 style:
              //                                     Theme.of(
              //                                       context,
              //                                     ).textTheme.bodySmall?.copyWith(),
              //                               ).symmetric(vertical: PAppSize.s8),
              //                               Text(
              //                                 PFormatter.formatDate(
              //                                   dateFormat: DateFormat(
              //                                     'dd-MM-yyyy',
              //                                   ),
              //                                   date: DateTime.parse(
              //                                     item.createdAt ??
              //                                         DateTime.now()
              //                                             .toIso8601String(),
              //                                   ),
              //                                 ),
              //                                 textAlign: TextAlign.start,
              //                                 style:
              //                                     Theme.of(
              //                                       context,
              //                                     ).textTheme.bodySmall?.copyWith(),
              //                               ).symmetric(vertical: PAppSize.s8),
              //                               Text(
              //                                     'view_pdf'.tr,
              //                                     textAlign: TextAlign.end,
              //                                     style: Theme.of(
              //                                       context,
              //                                     ).textTheme.bodySmall?.copyWith(
              //                                       color: PAppColor.primary,
              //                                       decoration:
              //                                           TextDecoration.underline,
              //                                       decorationColor:
              //                                           PAppColor.primary,
              //                                     ),
              //                                   )
              //                                   .onPressed(
              //                                     onTap:
              //                                         () => ctrl.openFile(
              //                                           url: item.downloadUrl ?? '',
              //                                           fileName:
              //                                               ctrl.all.value
              //                                                   ? 'All_Contributions_Report.pdf'
              //                                                   : 'Contributions_${item.filters?.year ?? ''}_Report.pdf',
              //                                         ),
              //                                   )
              //                                   .symmetric(vertical: PAppSize.s8),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ).scrollable(
              //                       physics: AlwaysScrollableScrollPhysics(),
              //                     ),
              //                   ),
              //         ),
              //       ],
              //     ).all(PAppSize.s20),
              //   ),
              // ),
            ],
          ).all(PAppSize.s20),
        ),
      ),
    );
  }
}
