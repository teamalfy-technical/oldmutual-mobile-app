import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

abstract class PolicyDs {
  Future<ApiResponse<PolicyResponse>> getPolicies({required String status});
  Future<ApiResponse<PolicySummary>> getPolicySummary();
  Future<ApiResponse<Policy>> getPolicy({required String policyNumber});
  Future<ApiResponse<List<Beneficiaries>>> getPolicyBeneficiaries({
    required String policyNumber,
  });
  Future<ApiResponse<PolicyTransaction>> getPolicyTransaction({
    required String policyNumber,
  });
  Future<ApiResponse<PolicyReport>> getPolicyReport({
    required String policyNumber,
    required String year,
    String month = '',

    String amount = '',
    String reference = '',
  });
}
