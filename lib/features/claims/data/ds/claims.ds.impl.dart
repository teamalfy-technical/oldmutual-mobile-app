import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/claims/claims.dart';

final ClaimsDs claimsDs = Get.put(ClaimsDsImpl());

class ClaimsDsImpl implements ClaimsDs {
  @override
  Future<ApiResponse<List<PaymentMethod>>> getPaymentMethods() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getPaymentMethods,
      );
      return ApiResponse<List<PaymentMethod>>.fromJson(
        res,
        (data) => (data as List).map((e) => PaymentMethod.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<WithdrawalReason>>> getWithdrawalReasons() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getWithdrawalReasons,
      );
      return ApiResponse<List<WithdrawalReason>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => WithdrawalReason.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Message>> submitInstantClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
    required int withdrawalPurpose,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'policy_number': policyNumber,
        'Current_cash_value': currentCashValue,
        'claim_amount': claimAmount,
        'claim_default_telcomethod': claimDefaultTelcomethod,
        'claim_default_momo_wallet': claimDefaultMomoWallet,
        'withdrawal_purpose': withdrawalPurpose,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: payload,
        endPoint: Env.submitInstantClaimRequest,
      );
      return ApiResponse<Message>.fromJson(res, (data) {
        if (data is Map<String, dynamic>) {
          return Message.fromJson(data);
        }
        return Message(success: true, message: res['message'] ?? res['data']);
      });
    });
  }
}
