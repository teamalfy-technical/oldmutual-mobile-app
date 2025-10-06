import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

abstract class PolicyService {
  Future<Either<PFailure, ApiResponse<PolicyResponse>>> getPolicies({
    required String status,
  });

  Future<Either<PFailure, ApiResponse<PolicySummary>>> getPolicySummary();

  Future<Either<PFailure, ApiResponse<Policy>>> getPolicy({
    required String policyNumber,
  });

  Future<Either<PFailure, ApiResponse<List<Beneficiaries>>>>
  getPolicyBeneficiaries({required String policyNumber});
  Future<Either<PFailure, ApiResponse<PolicyTransaction>>>
  getPolicyTransaction({
    required String policyNumber,
    String year = '',
    String month = '',
    String amount = '',
    String reference = '',
  });
  Future<Either<PFailure, ApiResponse<PolicyReport>>> getPolicyReport({
    required String policyNumber,
    required String year,
    String month = '',
    String amount = '',
    String reference = '',
  });
}
