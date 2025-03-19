import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.filled.textfield.dart';

class PContributionHistoryPage extends StatelessWidget {
  PContributionHistoryPage({super.key});

  final ctrl = Get.put(PContributionHistoryVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contribution_history'.tr)),
      body: Obx(
        () => Column(
          children: [
            PPageTagWidget(
              tag: 'contribution_history_tag'.tr,
              textAlign: TextAlign.center,
            ),

            // Filter
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PCustomFilledTextfield(
                              label: 'filter_by_year'.tr,
                              hint: 'enter_year'.tr,
                              controller: ctrl.yearTEC,
                            ),
                          ],
                        ),
                      ),

                      PAppSize.s50.horizontalSpace,

                      PCustomCheckbox(
                        value: ctrl.all.value,
                        scale: PAppSize.s1_3,
                        onChanged: ctrl.onAllChanged,
                        checkboxDirection: Direction.right,
                        child: Text(
                          'all'.tr,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),

                  PAppSize.s25.verticalSpace,

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ctrl.histories.length,
                    itemBuilder: (context, index) {
                      final history = ctrl.histories[index];
                      return ContributionHistoryWidget(history: history);
                    },
                  ),
                ],
              ).all(PAppSize.s20),
            ),
          ],
        ),
      ),
    );
  }
}
