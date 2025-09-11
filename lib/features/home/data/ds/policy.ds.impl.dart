import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

final PolicyDs policyDs = Get.put(PolicyDsImpl());

class PolicyDsImpl implements PolicyDs {
  @override
  Future<ApiResponse<PolicyResponse>> getPolicies({
    required String status,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {'status': status},
        endPoint: Env.getPolicies,
      );
      return ApiResponse<PolicyResponse>.fromJson(
        res,
        (data) => PolicyResponse.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Policy>> getPolicy({required String policyNumber}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getPolicies}/$policyNumber',
      );
      return ApiResponse<Policy>.fromJson(res, (data) => Policy.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<List<Beneficiaries>>> getPolicyBeneficiaries({
    required String policyNumber,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getPolicyBeneficiaries}/$policyNumber',
      );
      return ApiResponse<List<Beneficiaries>>.fromJson(
        res,
        (data) => (data as List).map((e) => Beneficiaries.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<PolicyReport>> getPolicyReport({
    required String policyNumber,
    required String year,
    String month = '',
    String amount = '',
    String reference = '',
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {
          'month': month,
          'year': year,
          'amount': amount,
          'reference': reference,
        },
        endPoint: '${Env.getPolicyReport}/$policyNumber',
      );
      return ApiResponse<PolicyReport>.fromJson(
        res,
        (data) => PolicyReport.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PolicySummary>> getPolicySummary() {
    // TODO: implement getPolicySummary
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<PolicyTransaction>> getPolicyTransaction({
    required String policyNumber,
  }) {
    // TODO: implement getPolicyTransaction
    throw UnimplementedError();
  }
}
