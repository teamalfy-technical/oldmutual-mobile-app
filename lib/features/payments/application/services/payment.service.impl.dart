import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

final PaymentService paymentService = Get.put(PaymentServiceImpl());

class PaymentServiceImpl implements PaymentService {
  @override
  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
      initiatePensionsPayment({
    required double amount,
    required String currency,
  }) {
    return paymentRepo.initiatePensionsPayment(
      amount: amount,
      currency: currency,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
      initiatePolicyPayment({
    required double amount,
    required String policyNumber,
    required String product,
    required String currency,
  }) {
    return paymentRepo.initiatePolicyPayment(
      amount: amount,
      policyNumber: policyNumber,
      product: product,
      currency: currency,
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Payment>>>> getPensionsPayments() {
    return paymentRepo.getPensionsPayments();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Payment>>>> getPolicyPayments() {
    return paymentRepo.getPolicyPayments();
  }
}
