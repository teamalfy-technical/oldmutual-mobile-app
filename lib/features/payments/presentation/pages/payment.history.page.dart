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
      appBar: AppBar(
        title: Text('payment_history'.tr),
        actions: [
          IconButton(
            icon: Assets.icons.filter.svg(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.whiteColor
                  : PAppColor.blackColor,
            ),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
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
                    ? PShimmerListView<Payment>(
                        loading: true,
                        items: const [],
                        separatorBuilder: (context, index) =>
                            PAppSize.s16.verticalSpace,
                        scrollDirection: Axis.vertical,
                        placeholderItem: Payment(
                          product: 'Sample Product',
                          amount: '500.00',
                          createdAt: DateTime.now().toIso8601String(),
                          status: 'SUCCESS',
                        ),
                        itemBuilder: (context, index, payment) {
                          return PTransactionListTile(
                            title: payment.product ?? '',
                            subtitle: 'Loading...',
                            trailing: Text(
                              '₵0.00',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          );
                        },
                      )
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

  Widget _buildPaymentList(BuildContext context, List<Payment> payments) {
    return PAnimatedListView<Payment>(
      shrinkWrap: true,
      items: payments,
      itemBuilder: (index, payment) {
        final payment = payments[index];
        return _buildPaymentTile(context, payment);
      },
      separatorBuilder: (context, index) =>
          Divider().symmetric(horizontal: PAppSize.s20),
    );
  }

  Widget _buildPaymentTile(BuildContext context, Payment payment) {
    return PTransactionListTile(
      onTap: () => showPaymentDetailModal(context, payment),
      title: payment.product ?? payment.policyNumber ?? '',
      subtitle: _formatDate(payment.createdAt),
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

      builder: (context) {
        return Container(
          padding: EdgeInsets.all(PAppSize.s20),
          height: PDeviceUtil.getDeviceHeight(context) * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(PAppSize.s24),
              topRight: Radius.circular(PAppSize.s24),
            ),
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.darkAppBarColor
                : PAppColor.whiteColor,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PAppSize.s8.verticalSpace,
                PAppSize.s8.verticalSpace,
                PDialogTitleWidget(
                  title: 'payment_details'.tr,
                  onClose: () => PHelperFunction.pop(),
                ),

                PAppSize.s14.verticalSpace,
                Divider(),

                // PAppSize.s6.verticalSpace,
                Expanded(
                  child: PAnimatedColumnWidget(
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
                        title: payment.clientReference ?? 'not_applicable'.tr,
                        subtitle: 'client_reference'.tr,
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
                        title:
                            payment.status?.capitalizeFirst ??
                            'not_applicable'.tr,
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
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: PAppColor.primary,
                                  ),
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

  Future _showFilterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(PAppSize.s20),
            height: PDeviceUtil.getDeviceHeight(context) * 0.73,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(PAppSize.s24),
                topRight: Radius.circular(PAppSize.s24),
              ),
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkAppBarColor
                  : PAppColor.whiteColor,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PAppSize.s8.verticalSpace,
                  PDialogTitleWidget(
                    title: 'filter_payments'.tr,
                    onClose: () => PHelperFunction.pop(),
                  ),

                  PAppSize.s14.verticalSpace,
                  Divider(),
                  PAppSize.s16.verticalSpace,
                  Expanded(
                    child: PAnimatedColumnWidget(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount filter
                        PCustomTextField(
                          labelText: 'amount'.tr,
                          hintText: 'enter_amount'.tr,
                          controller: ctrl.filterAmountTEC,
                          textInputType: TextInputType.number,
                        ),
                        PAppSize.s16.verticalSpace,

                        // Policy number filter (only for policy payments)
                        if (widget.paymentType == PaymentType.policy) ...[
                          PCustomTextField(
                            labelText: 'policy_number'.tr,
                            hintText: 'enter_policy_number'.tr,
                            controller: ctrl.filterPolicyNumberTEC,
                          ),
                          PAppSize.s16.verticalSpace,
                        ],

                        // Status filter
                        PCustomDropdownField<String>(
                          labelText: 'select_status'.tr,
                          initialValue: ctrl.selectedStatus,
                          items: PaymentStatus.values
                              .map(
                                (status) => DropdownMenuItem<String>(
                                  value: status.value,
                                  child: Text(status.value),
                                ),
                              )
                              .toList(),
                          onChanged: ctrl.onSelectedStatus,
                        ),
                        PAppSize.s16.verticalSpace,

                        // Payment reference filter
                        PCustomTextField(
                          labelText: 'payment_reference'.tr,
                          hintText: 'enter_payment_reference'.tr,
                          controller: ctrl.filterPaymentRefTEC,
                        ),
                        PAppSize.s16.verticalSpace,

                        // Client reference filter
                        PCustomTextField(
                          labelText: 'client_reference'.tr,
                          hintText: 'enter_client_reference'.tr,
                          controller: ctrl.filterClientRefTEC,
                        ),
                        PAppSize.s24.verticalSpace,
                      ],
                    ).scrollable(),
                  ),
                  PAppSize.s16.verticalSpace,

                  // Filter and Reset buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ctrl.resetFilters();
                            PHelperFunction.pop();
                            // Reload without filters
                            if (widget.paymentType == PaymentType.pensions) {
                              ctrl.getPensionsPayments();
                            } else {
                              ctrl.getPolicyPayments();
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: PAppSize.s16,
                            ),
                            side: BorderSide(color: PAppColor.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PAppSize.s24),
                            ),
                          ),
                          child: Text(
                            'reset'.tr,
                            style: TextStyle(
                              color: PAppColor.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: PAppSize.s16,
                            ),
                          ),
                        ),
                      ),
                      PAppSize.s12.horizontalSpace,
                      Expanded(
                        child: Obx(
                          () => PGradientButton(
                            label: 'apply_filters'.tr,
                            showIcon: false,
                            loading: ctrl.loading.value,
                            onTap: () async {
                              if (widget.paymentType == PaymentType.pensions) {
                                await ctrl.applyPensionsFilters();
                              } else {
                                await ctrl.applyPolicyFilters();
                              }
                              PHelperFunction.pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
