import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';

abstract class ClaimsRepo {
  Future<Either<PFailure, ApiResponse<List<PaymentMethod>>>>
  getPaymentMethods();
  Future<Either<PFailure, ApiResponse<List<WithdrawalReason>>>>
  getWithdrawalReasons();
  Future<Either<PFailure, ApiResponse<Message>>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  });
}
