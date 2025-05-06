import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';

final RedemptionRepo redemptionRepo = Get.put(RedemptionRepoImpl());

class RedemptionRepoImpl implements RedemptionRepo {
  @override
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
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await redemptionDs.createPortingRequest(
            nameOfCurrentEmployer: nameOfCurrentEmployer,
            currentSchemeType: currentSchemeType,
            currentSchemeName: currentSchemeName,
            nameOfPrevEmployer: nameOfPrevEmployer,
            prevSchemeType: prevSchemeType,
            prevSchemeName: prevSchemeName,
            nameOfPrevTrustee: nameOfPrevTrustee,
            prevTrusteeContactName: prevTrusteeContactName,
            prevTrusteeContactNumber: prevTrusteeContactNumber,
            idFront: idFront,
            idBack: idBack,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<Redemption>>> createRedemptionRequest({
    required String nationId,
    required String redemptionType,
    required String percentage,
    required String amount,
    required String redemptionReason,
    required String bankAccount,
    required String bankName,
    required String accountHolderName,
    required String bankBranch,
    required File idFront,
    required File idBack,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await redemptionDs.createRedemptionRequest(
            nationId: nationId,
            redemptionType: redemptionType,
            percentage: percentage,
            amount: amount,
            redemptionReason: redemptionReason,
            bankAccount: bankAccount,
            bankName: bankName,
            accountHolderName: accountHolderName,
            bankBranch: bankBranch,
            idBack: idBack,
            idFront: idFront,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Redemption>>>> getRedemptions({
    required String userName,
    required String amount,
    required String status,
    required String createdAt,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await redemptionDs.getRedemptions(
            userName: userName,
            amount: amount,
            status: status,
            createdAt: createdAt,
          ),
    );
  }
}
