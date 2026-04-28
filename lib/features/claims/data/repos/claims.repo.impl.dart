import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';

final ClaimsRepo claimsRepo = Get.put(ClaimsRepoImpl());

class ClaimsRepoImpl implements ClaimsRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<PaymentMethod>>>>
  getPaymentMethods() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await claimsDs.getPaymentMethods(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<WithdrawalReason>>>>
  getWithdrawalReasons() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await claimsDs.getWithdrawalReasons(),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await claimsDs.submitInstantClaimRequest(
        policyNumber: policyNumber,
        currentCashValue: currentCashValue,
        claimAmount: claimAmount,
        claimDefaultTelcomethod: claimDefaultTelcomethod,
        claimDefaultMomoWallet: claimDefaultMomoWallet,
        withdrawalPurpose: withdrawalPurpose,
      ),
    );
  }
}
