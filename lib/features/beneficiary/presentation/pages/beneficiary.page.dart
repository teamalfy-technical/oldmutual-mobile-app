import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryPage extends StatelessWidget {
  PBeneficiaryPage({super.key});

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
              child: vm.loading.value != LoadingState.loading
                  ? PShimmerListView<Beneficiary>(
                      loading: true,
                      items: const [],
                      separatorBuilder: (context, index) =>
                          PAppSize.s12.verticalSpace,
                      scrollDirection: Axis.vertical,
                      placeholderCount: 20,
                      placeholderItem: Beneficiary(
                        fullName: 'John Doe',
                        percAlloc: 50,
                        relationship: 'Spouse',
                      ),
                      itemBuilder: (context, index, beneficiary) {
                        return PBeneficiaryWidget(
                          beneficiary: beneficiary,
                          loading: true,
                        );
                      },
                    )
                  : vm.beneficiaries.isEmpty
                  ? PEmptyStateWidget(message: 'no_results_found'.tr)
                  : PAnimatedListView<Beneficiary>(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      items: vm.beneficiaries,
                      itemBuilder: (index, beneficiary) {
                        return PBeneficiaryWidget(
                          beneficiary: beneficiary,
                          onTap: () => showDetailModal(context, beneficiary),
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
