import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/errors.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/mvest/mvest.dart';
import 'package:oldmutual_pensions_app/features/payments/payments.dart';

abstract class MVestService {
  Future<Either<PFailure, ApiResponse<MVestAccount>>> createMVestAccount({
    required String mvestPlan,
    required double monthlyContribution,
  });

  Future<Either<PFailure, ApiResponse<MVestAccount>>> addMVestBeneficiary({
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  });

  Future<Either<PFailure, ApiResponse<MVestAccount>>> deleteMVestBeneficiary({
    required String beneficiaryContact,
  });

  Future<Either<PFailure, ApiResponse<List<Beneficiary>>>>
  getMVestBeneficiaries();

  Future<Either<PFailure, ApiResponse<MVestAccount>>> updateMVestBeneficiary({
    required int id,
    required String firstname,
    required String othername,
    required String beneficiaryContact,
    required double percentageAllocation,
    required String birthDate,
    required String relation,
  });

  Future<Either<PFailure, ApiResponse<InitiatePaymentResponse>>>
  initiateMVestPayment({
    required double amount,
    String? currency,
    String platform = 'mobile',
  });
}
