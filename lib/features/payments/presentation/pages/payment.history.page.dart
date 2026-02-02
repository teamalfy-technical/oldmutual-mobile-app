import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PPaymentHistoryPage extends StatefulWidget {
  final PaymentType paymentType;

  const PPaymentHistoryPage({
    super.key,
    this.paymentType = PaymentType.policy,
  });

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
      appBar: AppBar(
        title: Text('payment_history'.tr),
      ),
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
      onTap: () => _showPaymentDetails(context, payment),
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
          PAppSize.s4.verticalSpace,
          _buildStatusChip(context, payment.status ?? ''),
        ],
      ),
      trailing: Text(
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
      isThreeLine: true,
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color bgColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case 'SUCCESS':
        bgColor = PAppColor.successMedium.withOpacityExt(0.1);
        textColor = PAppColor.successMedium;
        break;
      case 'FAILED':
        bgColor = PAppColor.redColor.withOpacityExt(0.1);
        textColor = PAppColor.redColor;
        break;
      default:
        bgColor = PAppColor.warning500.withOpacityExt(0.1);
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
        status.toUpperCase(),
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

  void _showPaymentDetails(BuildContext context, Payment payment) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(PAppSize.s24),
          topRight: Radius.circular(PAppSize.s24),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(PAppSize.s20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'payment_details'.tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                PAppSize.s20.verticalSpace,
                _buildDetailRow(
                  context,
                  label: 'product'.tr,
                  value: payment.product ?? '-',
                ),
                _buildDetailRow(
                  context,
                  label: 'policy_number'.tr,
                  value: payment.policyNumber ?? '-',
                ),
                _buildDetailRow(
                  context,
                  label: 'amount'.tr,
                  value: PFormatter.formatCurrency(
                    amount: payment.amountAsDouble,
                    symbol: payment.currency ?? 'GHS',
                  ),
                ),
                _buildDetailRow(
                  context,
                  label: 'status'.tr,
                  value: payment.status ?? '-',
                  valueColor: payment.isSuccessful
                      ? PAppColor.successMedium
                      : payment.isFailed
                          ? PAppColor.redColor
                          : null,
                ),
                _buildDetailRow(
                  context,
                  label: 'payment_channel'.tr,
                  value: payment.paymentChannel ?? '-',
                ),
                _buildDetailRow(
                  context,
                  label: 'reference'.tr,
                  value: payment.clientReference ?? '-',
                ),
                _buildDetailRow(
                  context,
                  label: 'date'.tr,
                  value: _formatDate(payment.createdAt),
                ),
                if (payment.completedAt != null) ...[
                  _buildDetailRow(
                    context,
                    label: 'completed_at'.tr,
                    value: _formatDate(payment.completedAt),
                  ),
                ],
                if (payment.failureReason != null &&
                    payment.failureReason!.isNotEmpty) ...[
                  _buildDetailRow(
                    context,
                    label: 'failure_reason'.tr,
                    value: payment.failureReason!,
                    valueColor: PAppColor.redColor,
                  ),
                ],
                PAppSize.s20.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PAppSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: PAppColor.greyColor,
                ),
          ),
          SizedBox(width: PAppSize.s16),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
