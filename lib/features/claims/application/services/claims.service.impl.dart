import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';

final ClaimsService claimsService = Get.put(ClaimsServiceImpl());

class ClaimsServiceImpl implements ClaimsService {
  @override
  Future<Either<PFailure, ApiResponse<List<PaymentMethod>>>>
  getPaymentMethods() {
    return claimsRepo.getPaymentMethods();
  }

  @override
  Future<Either<PFailure, ApiResponse<List<WithdrawalReason>>>>
  getWithdrawalReasons() {
    return claimsRepo.getWithdrawalReasons();
  }

  @override
  Future<Either<PFailure, ApiResponse<Message>>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  }) {
    return claimsRepo.submitInstantClaimRequest(
      policyNumber: policyNumber,
      currentCashValue: currentCashValue,
      claimAmount: claimAmount,
      claimDefaultTelcomethod: claimDefaultTelcomethod,
      claimDefaultMomoWallet: claimDefaultMomoWallet,
      withdrawalPurpose: withdrawalPurpose,
    );
  }
}
