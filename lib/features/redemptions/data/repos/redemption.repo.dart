import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';

abstract class RedemptionRepo {
  Future<Either<PFailure, ApiResponse<Redemption>>> createRedemptionRequest({
    required String nationId,
    required String redemptionType,
    required double percentage,
    required double amount,
    required String redemptionReason,
    required String bankAccount,
    required String bankName,
    required String accountHolderName,
    required String bankBranch,
    required File idFront,
    required File idBack,
  });

  Future<Either<PFailure, ApiResponse<List<Redemption>>>> getRedemptions({
    required String userName,
    required String amount,
    required String status,
    required String createdAt,
  });

  Future<Either<PFailure, ApiResponse<Porting>>> createPortingRequest({
    required String nameOfCurrentEmployer,
    required String currentSchemeType,
    required String currentSchemeName,
    required String nameOfPrevEmployer,
    required String prevSchemeType,
    required String prevSchemeName,
    required String nameOfPrevTrustee,
    required String prevTrusteeContactName,
    required String prevTrusteeContactNumber,
    required File idFront,
    required File idBack,
  });
}
