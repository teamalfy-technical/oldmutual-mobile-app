import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

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

      pensionAppLogger.i(res);
      return ApiResponse<PolicyResponse>.fromJson(
        res,
        (data) => PolicyResponse.fromJson(data),
      );
      // final combinedList = combinePolicies(res);
      // pensionAppLogger.i(combinedList);
      // return ApiResponse<PolicyResponse>.fromJson(
      //   combinedList,
      //   (data) => PolicyResponse.fromJson(data),
      // );
    });
  }

  Map<String, dynamic> combinePolicies(Map<String, dynamic> response) {
    // Safely access nested 'data' map
    final Map<String, dynamic> data = Map<String, dynamic>.from(
      response['data'] ?? {},
    );
    final List<Map<String, dynamic>> policyDetails =
        List<Map<String, dynamic>>.from(data['policy_details'] ?? []);

    final Map<String, Map<String, dynamic>> grouped = {};

    for (final policy in policyDetails) {
      final name = policy['plan_description'];
      final sum = policy['sum_assured'] ?? 0;

      if (grouped.containsKey(name)) {
        final currentSum = grouped[name]!['sum_assured'] ?? 0.0;
        grouped[name]!['sum_assured'] = (currentSum + sum);
      } else {
        grouped[name] = Map<String, dynamic>.from(policy);
        grouped[name]!['sum_assured'] = sum;
      }
    }

    // Replace policy_details in the nested 'data'
    data['policy_details'] = grouped.values.toList();

    // Return updated top-level map
    return {...response, 'data': data};
  }

  @override
  Future<ApiResponse<Policy>> getPolicy({required String policyNumber}) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {'policy_number': policyNumber},
        endPoint: Env.getPolicy,
      );
      return ApiResponse<Policy>.fromJson(res, (data) => Policy.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<List<Beneficiary>>> getPolicyBeneficiaries({
    required String policyNumber,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.getPolicyBeneficiaries}/$policyNumber',
      );
      return ApiResponse<List<Beneficiary>>.fromJson(
        res,
        (data) => (data as List).map((e) => Beneficiary.fromJson(e)).toList(),
      );
    });
  }

  // @override
  // Future<ApiResponse<PolicyReport>> getPolicyReport({
  //   required String policyNumber,
  //   required String year,
  //   String month = '',
  //   String amount = '',
  //   String reference = '',
  // }) async {
  //   return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
  //     final res = await apiService.callService(
  //       requestType: RequestType.get,
  //       queryParams: {
  //         'month': month,
  //         'year': year,
  //         'amount': amount,
  //         'reference': reference,
  //       },
  //       endPoint: '${Env.getPolicyReport}/$policyNumber',
  //     );
  //     return ApiResponse<PolicyReport>.fromJson(
  //       res,
  //       (data) => PolicyReport.fromJson(data),
  //     );
  //   });
  // }

  @override
  Future<ApiResponse<PolicySummary>> getPolicySummary() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,

        endPoint: Env.getPolicySummary,
      );
      return ApiResponse<PolicySummary>.fromJson(
        res,
        (data) => PolicySummary.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PolicyTransaction>> getPolicyTransaction({
    required String policyNumber,
    String year = '',
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

        endPoint: '${Env.getPolicyTransaction}/$policyNumber',
      );
      return ApiResponse<PolicyTransaction>.fromJson(
        res,
        (data) => PolicyTransaction.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PolicyReport>> checkPolicyReportDownloadStatus({
    required String reportId,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: '${Env.checkReportStatus}/$reportId',
      );
      return ApiResponse<PolicyReport>.fromJson(
        res,
        (data) => PolicyReport.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<PolicyReport>> generatePolicyReports({
    required String policyNumber,
    required int year,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        queryParams: {'policy_number': policyNumber, 'year': year},
        endPoint: Env.generatePolicyReport,
      );
      return ApiResponse<PolicyReport>.fromJson(
        res,
        (data) => PolicyReport.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<PolicyReport>>> getPolicyReports() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getPolicyReports,
      );
      return ApiResponse<List<PolicyReport>>.fromJson(
        res,
        (data) => (data as List).map((e) => PolicyReport.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> downloadInvestmentStatement({
    required String policyNumber,
  }) async {
    final res = await apiService.callService(
      requestType: RequestType.get,
      queryParams: {'policy_number': policyNumber},
      endPoint: Env.downloadInvestmentStatement,
    );
    return ApiResponse<Map<String, dynamic>>.fromJson(res, (data) => data);
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> downloadPremiumStatement({
    required String policyNumber,
  }) async {
    final res = await apiService.callService(
      requestType: RequestType.get,
      queryParams: {'policy_number': policyNumber},
      endPoint: Env.downloadPremiumStatement,
    );
    return ApiResponse<Map<String, dynamic>>.fromJson(res, (data) => data);
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> downloadPolicyStatement({
    required String policyNumber,
  }) async {
    final res = await apiService.callService(
      requestType: RequestType.get,
      queryParams: {'policy_number': policyNumber},
      endPoint: Env.downloadPolicyDocument,
    );
    return ApiResponse<Map<String, dynamic>>.fromJson(res, (data) => data);
  }
}
