import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryListPage extends StatelessWidget {
  PBeneficiaryListPage({super.key});

  final vm = Get.put(PBeneficiaryVm());

  Future showDetailModal(BuildContext context, Beneficiary beneficiary) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(PAppSize.s24),
          topRight: Radius.circular(PAppSize.s24),
        ),
      ),
      builder: (context) {
        return PBeneficiaryDetailWidget(beneficiary: beneficiary);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('beneficiaries'.tr)),
      body: SafeArea(
        child: Obx(
          () => PCustomCardWidget(
            padding: EdgeInsets.symmetric(vertical: PAppSize.s6),
            child: RefreshIndicator.adaptive(
              onRefresh: () => vm.getBeneficiaries(),
              child: vm.loading.value == LoadingState.loading
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PBeneficiaryWidgetRedact(
                          loading: vm.loading.value,
                        );
                      },
                    )
                  : vm.beneficiaries.isEmpty
                  ? PEmptyStateWidget(message: 'no_results_found'.tr)
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: vm.beneficiaries.length,
                      itemBuilder: (context, index) {
                        final beneficiary = vm.beneficiaries[index];
                        return ListTile(
                          onTap: () => showDetailModal(context, beneficiary),
                          leading: CircleAvatar(
                            radius: PAppSize.s24,
                            backgroundColor: PAppColor.darkAppBarColor2,
                            child: Text(
                              beneficiary.fullName
                                      ?.split(' ')
                                      .first
                                      .substring(0, 1) ??
                                  'not_applicable'.tr,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s15,
                                    color: PAppColor.whiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          title: Text(
                            beneficiary.fullName ?? '',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s15,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                beneficiary.percAlloc == 100
                                    ? '${beneficiary.percAlloc}%'
                                    : '${beneficiary.percAlloc}% Split',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: PAppSize.s14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              Text(
                                // '${beneficiary.relationship}',
                                '${beneficiary.relationship} - ${beneficiary.birthDate == null ? 'not_applicable'.tr : PFormatter.formatDate(dateFormat: DateFormat('d MMMM y'), date: DateTime.parse(beneficiary.birthDate ?? DateTime.now().toIso8601String()))}',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: PAppSize.s13,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                          trailing: Assets.icons.arrowRightBlack.svg(
                            color: PHelperFunction.isDarkMode(context)
                                ? PAppColor.whiteColor
                                : PAppColor.blackColor,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider().symmetric(horizontal: PAppSize.s20),
                    ),
            ),
          ).all(PAppSize.s20),
        ),
      ),
    );
  }
}
