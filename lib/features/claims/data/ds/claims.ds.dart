import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';

abstract class ClaimsDs {
  Future<ApiResponse<List<PaymentMethod>>> getPaymentMethods();
  Future<ApiResponse<List<WithdrawalReason>>> getWithdrawalReasons();
  Future<ApiResponse<Message>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  });
}
