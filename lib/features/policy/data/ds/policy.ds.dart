import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

abstract class PolicyDs {
  Future<ApiResponse<PolicyResponse>> getPolicies({required String status});
  Future<ApiResponse<PolicySummary>> getPolicySummary();
  Future<ApiResponse<Policy>> getPolicy({required String policyNumber});
  Future<ApiResponse<List<Beneficiary>>> getPolicyBeneficiaries({
    required String policyNumber,
  });
  Future<ApiResponse<PolicyTransaction>> getPolicyTransaction({
    required String policyNumber,
    String year = '',
    String month = '',
    String amount = '',
    String reference = '',
  });
  Future<ApiResponse<PolicyReport>> generatePolicyReports({
    required String policyNumber,
    required int year,
  });
  Future<ApiResponse<PolicyReport>> checkPolicyReportDownloadStatus({
    required String reportId,
  });
  Future<ApiResponse<List<PolicyReport>>> getPolicyReports();
  Future<ApiResponse<Map<String, dynamic>>> downloadInvestmentStatement({
    required String policyNumber,
  });
  Future<ApiResponse<Map<String, dynamic>>> downloadPremiumStatement({
    required String policyNumber,
  });
  Future<ApiResponse<Map<String, dynamic>>> downloadPolicyStatement({
    required String policyNumber,
  });
  Future<ApiResponse<List<PaymentMethod>>> getPaymentMethods();
  Future<ApiResponse<List<Message>>> submitClaimRequest({
    required String policyNumber,
    required double currentCashValue,
    required double claimAmount,
    required String claimDefaultTelcomethod,
    required String claimDefaultMomoWallet,
  });
}
