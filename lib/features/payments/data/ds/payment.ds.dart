import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

abstract class PaymentDs {
  /// Initiate a pensions payment
  /// Request body: amount, currency
  /// Returns: checkoutUrl
  Future<ApiResponse<InitiatePaymentResponse>> initiatePensionsPayment({
    required double amount,
    required String currency,
  });

  /// Initiate a policy (life insurance) payment
  /// Request body: amount, policy_number, product, currency
  /// Returns: checkoutUrl
  Future<ApiResponse<InitiatePaymentResponse>> initiatePolicyPayment({
    required double amount,
    required String policyNumber,
    required String product,
    required String currency,
  });

  /// Get pensions payment history
  Future<ApiResponse<List<Payment>>> getPensionsPayments();

  /// Get policy (life insurance) payment history
  Future<ApiResponse<List<Payment>>> getPolicyPayments();
}
