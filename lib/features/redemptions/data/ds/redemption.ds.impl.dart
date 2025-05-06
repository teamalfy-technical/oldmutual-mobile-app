import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';

final RedemptionDs redemptionDs = Get.put(RedemptionDsImpl());

class RedemptionDsImpl implements RedemptionDs {
  @override
  Future<ApiResponse<Porting>> createPortingRequest({
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
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: dio.FormData.fromMap({
          'name_of_current_employer': nameOfCurrentEmployer,
          'current_scheme_type': currentSchemeType,
          'current_scheme_name': currentSchemeName,
          'name_of_prev_employer': nameOfPrevEmployer,
          'prev_scheme_type': prevSchemeType,
          'prev_scheme_name': prevSchemeName,
          'name_of_prev_trustee': nameOfPrevTrustee,
          'prev_trustee_contact_name': prevTrusteeContactName,
          'prev_trustee_contact_number': prevTrusteeContactNumber,
          'id_front': await dio.MultipartFile.fromFile(
            idFront.path,
            filename: idFront.path.split('/').last.split('.').first,
          ),
          'id_back': await dio.MultipartFile.fromFile(
            idBack.path,
            filename: idBack.path.split('/').last.split('.').first,
          ),
        }),
        endPoint: Env.createPortingRequest,
      );
      return ApiResponse<Porting>.fromJson(
        res,
        (data) => Porting.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Redemption>> createRedemptionRequest({
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
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: dio.FormData.fromMap({
          'national_id': nationId,
          'redemption_type': redemptionType,
          'percentage': percentage,
          'amount': amount,
          'redemption_reason': redemptionReason,
          'bank_account': bankAccount,
          'bank_name': bankAccount,
          'account_holder_name': accountHolderName,
          'bank_branch': bankAccount,
          'id_front': await dio.MultipartFile.fromFile(
            idFront.path,
            filename: idFront.path.split('/').last.split('.').first,
          ),
          'id_back': await dio.MultipartFile.fromFile(
            idBack.path,
            filename: idBack.path.split('/').last.split('.').first,
          ),
        }),
        endPoint: Env.createRedemptionRequest,
      );
      return ApiResponse<Redemption>.fromJson(
        res,
        (data) => Redemption.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<List<Redemption>>> getRedemptions({
    required String userName,
    required String amount,
    required String status,
    required String createdAt,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        queryParams: {
          'filter[user.name]': userName,
          'filter[amount]': amount,
          'filter[status]': status,
          'filter[created_at]': createdAt,
        },
        endPoint: Env.getRedemptions,
      );
      return ApiResponse<List<Redemption>>.fromJson(
        res,
        (data) => (data as List).map((e) => Redemption.fromJson(e)).toList(),
      );
    });
  }
}
