import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PBeneficiaryPage extends StatefulWidget {
  const PBeneficiaryPage({super.key});

  @override
  State<PBeneficiaryPage> createState() => _PBeneficiaryPageState();
}

class _PBeneficiaryPageState extends State<PBeneficiaryPage> {
  final ctrl = Get.put(PBeneficiaryVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('beneficiaries'.tr)),
      body: Obx(
        () =>
            Column(
              children: [
                PPageTagWidget(
                  tag: 'beneficiaries_tag'.trParams({
                    'phone': PAppConstant.beneficiaryPhoneSupport,
                  }),
                  icon: Assets.icons.warningGreenIcon.svg(),
                  textAlign: TextAlign.center,
                ),
                // PAppSize.s32.verticalSpace,
                (PDeviceUtil.getDeviceHeight(context) * 0.045).verticalSpace,
                ctrl.loading.value == LoadingState.loading
                    ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return PBeneficiaryWidgetRedact(
                          loading: ctrl.loading.value,
                        );
                      },
                    )
                    : ctrl.beneficiaries.isEmpty
                    ? PEmptyStateWidget(message: 'no_results_found'.tr)
                    : RefreshIndicator.adaptive(
                      onRefresh: () => ctrl.getBeneficiaries(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ctrl.beneficiaries.length,
                        itemBuilder: (context, index) {
                          final beneficiary = ctrl.beneficiaries[index];
                          return PBeneficiaryWidget(
                            beneficiary: beneficiary,
                            index: index,
                            loading: ctrl.loading.value,
                            onExpansionChanged: (value) {
                              setState(() {
                                beneficiary.show = value;
                              });
                            },
                          );
                        },
                      ),
                    ),

                (PDeviceUtil.getDeviceHeight(context) * 0.05).verticalSpace,

                PGradientButton(
                  label: 'add_new_beneficiary'.tr.toUpperCase(),
                  width: PDeviceUtil.getDeviceWidth(context) * 0.65,
                  onTap:
                      () => PHelperFunction.switchScreen(
                        destination: Routes.manageBeneficiaryPage,
                        args: [null, false],
                      ),
                ),
              ],
            ).scrollable(),
      ),
    );
  }
}
