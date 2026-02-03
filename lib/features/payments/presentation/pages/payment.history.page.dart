import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPaymentHistoryPage extends StatefulWidget {
  final PaymentType paymentType;

  const PPaymentHistoryPage({super.key, this.paymentType = PaymentType.policy});

  @override
  State<PPaymentHistoryPage> createState() => _PPaymentHistoryPageState();
}

class _PPaymentHistoryPageState extends State<PPaymentHistoryPage> {
  late final PPaymentVm ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(PPaymentVm());

    // Fetch payments based on type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.paymentType == PaymentType.pensions) {
        ctrl.getPensionsPayments();
      } else {
        ctrl.getPolicyPayments();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('payment_history'.tr)),
      body: Obx(() {
        final payments = widget.paymentType == PaymentType.pensions
            ? ctrl.pensionsPayments
            : ctrl.policyPayments;

        return Column(
          children: [
            Expanded(
              child: PCustomCardWidget(
                padding: EdgeInsets.symmetric(
                  vertical: PAppSize.s16,
                  horizontal: PAppSize.s4,
                ),
                child: ctrl.loading.value == LoadingState.loading
                    ? _buildLoadingList()
                    : payments.isEmpty
                    ? PEmptyStateWidget(message: 'no_results_found'.tr)
                    : _buildPaymentList(context, payments),
              ),
            ),
            (PDeviceUtil.getDeviceHeight(context) * 0.08).verticalSpace,
          ],
        ).all(PAppSize.s20);
      }),
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            height: PAppSize.s14,
            width: PAppSize.s100,
            decoration: BoxDecoration(
              color: PAppColor.greyColor.withOpacityExt(0.2),
              borderRadius: BorderRadius.circular(PAppSize.s4),
            ),
          ),
          subtitle: Container(
            height: PAppSize.s12,
            width: PAppSize.s60,
            margin: EdgeInsets.only(top: PAppSize.s4),
            decoration: BoxDecoration(
              color: PAppColor.greyColor.withOpacityExt(0.1),
              borderRadius: BorderRadius.circular(PAppSize.s4),
            ),
          ),
          trailing: Container(
            height: PAppSize.s14,
            width: PAppSize.s60,
            decoration: BoxDecoration(
              color: PAppColor.greyColor.withOpacityExt(0.2),
              borderRadius: BorderRadius.circular(PAppSize.s4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentList(BuildContext context, List<Payment> payments) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final payment = payments[index];
        return _buildPaymentTile(context, payment);
      },
      separatorBuilder: (context, index) =>
          Divider().symmetric(horizontal: PAppSize.s20),
    );
  }

  Widget _buildPaymentTile(BuildContext context, Payment payment) {
    return ListTile(
      onTap: () => showPaymentDetailModal(context, payment),
      title: Text(
        payment.product ?? payment.policyNumber ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PAppSize.s4.verticalSpace,
          Text(
            _formatDate(payment.createdAt),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            PFormatter.formatCurrency(
              amount: payment.amountAsDouble,
              symbol: payment.currency ?? 'GHS',
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s14,
              color: payment.isSuccessful
                  ? PAppColor.successMedium
                  : payment.isFailed
                  ? PAppColor.redColor
                  : PAppColor.warning500,
              fontWeight: FontWeight.w600,
            ),
          ),
          PAppSize.s4.verticalSpace,
          _buildStatusChip(context, payment.status ?? ''),
        ],
      ),
      isThreeLine: false,
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color bgColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case 'SUCCESS':
        bgColor = PAppColor.successMedium.withOpacityExt(PAppSize.s0_1);
        textColor = PAppColor.successMedium;
        break;
      case 'FAILED':
        bgColor = PAppColor.redColor.withOpacityExt(PAppSize.s0_1);
        textColor = PAppColor.redColor;
        break;
      default:
        bgColor = PAppColor.warning500.withOpacityExt(PAppSize.s0_1);
        textColor = PAppColor.warning500;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: PAppSize.s8,
        vertical: PAppSize.s4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PAppSize.s4),
      ),
      child: Text(
        status.capitalizeFirst ?? '',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: PAppSize.s10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      final date = DateTime.parse(dateString);
      return PFormatter.formatDate(
        dateFormat: DateFormat('yMMMMd'),
        date: date,
      );
    } catch (e) {
      return dateString;
    }
  }

  Future showPaymentDetailModal(BuildContext context, Payment payment) {
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
        return Container(
          padding: EdgeInsets.all(PAppSize.s20),
          height: PDeviceUtil.getDeviceHeight(context) * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PAppSize.s20),
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkBgColor
                : PAppColor.fillColor,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s8.verticalSpace,
                PSeeAllWidget(
                  leadingText: 'payment_details'.tr,
                  leadingFontSize: PAppSize.s20,
                  trailing: Assets.icons.closeIcon.svg(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.whiteColor
                        : PAppColor.blackColor,
                  ),
                  onTap: () => PHelperFunction.pop(),
                ),
                PAppSize.s14.verticalSpace,
                Divider(),

                // PAppSize.s6.verticalSpace,
                Expanded(
                  child: Column(
                    children: [
                      CustomListTile(
                        title: PFormatter.formatCurrency(
                          amount: payment.amountAsDouble,
                        ),
                        subtitle: 'payment_amount'.tr,
                      ),
                      Divider(),

                      CustomListTile(
                        title: payment.paymentChannel ?? 'not_applicable'.tr,
                        subtitle: 'payment_method'.tr,
                      ),
                      Divider(),

                      CustomListTile(
                        title: payment.paymentReference ?? 'not_applicable'.tr,
                        subtitle: 'payment_reference'.tr,
                      ),

                      Divider(),

                      CustomListTile(
                        title: PFormatter.formatDate(
                          dateFormat: DateFormat('yMMMMd').add_jmv(),
                          date: DateTime.parse(payment.createdAt ?? ''),
                        ),
                        subtitle: 'date'.tr,
                      ),

                      Divider(),

                      CustomListTile(
                        title: payment.status ?? 'not_applicable'.tr,
                        subtitle: 'status'.tr,
                      ),

                      Divider(),

                      PAppSize.s20.verticalSpace,

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${'reach_support_text'.tr}\n',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: PAppConstant.supportEmail,

                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).scrollable(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
