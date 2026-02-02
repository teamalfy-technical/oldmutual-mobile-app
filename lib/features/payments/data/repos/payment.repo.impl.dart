import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

final PaymentRepo paymentRepo = Get.put(PaymentRepoImpl());

class PaymentRepoImpl implements PaymentRepo {
  @override
  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
      initiatePensionsPayment({
    required double amount,
    required String currency,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await paymentDs.initiatePensionsPayment(
        amount: amount,
        currency: currency,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
      initiatePolicyPayment({
    required double amount,
    required String policyNumber,
    required String product,
    required String currency,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await paymentDs.initiatePolicyPayment(
        amount: amount,
        policyNumber: policyNumber,
        product: product,
        currency: currency,
      ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Payment>>>>
      getPensionsPayments() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await paymentDs.getPensionsPayments(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Payment>>>>
      getPolicyPayments() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await paymentDs.getPolicyPayments(),
    );
  }
}
