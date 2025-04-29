import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';

final BeneficiaryDs beneficiaryDs = Get.put(BeneficiaryDsImpl());

class BeneficiaryDsImpl implements BeneficiaryDs {
  @override
  Future<ApiResponse<List<Beneficiary>>> getBeneficiaries() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getBeneficiaries,
      );
      return ApiResponse<List<Beneficiary>>.fromJson(
        res,
        (data) =>
            (data[0]['beneficiary'] as List)
                .map((e) => Beneficiary.fromJson(e))
                .toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Beneficiary>>> deleteBeneficiary({
    required int beneficiaryId,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload: dio.FormData.fromMap({'beneficiary_id': beneficiaryId}),
        endPoint: Env.deleteBeneficiary,
      );
      return ApiResponse<List<Beneficiary>>.fromJson(
        res,
        (data) =>
            (data['beneficiary'] as List)
                .map((e) => Beneficiary.fromJson(e))
                .toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Beneficiary>>> updateBeneficiary({
    int? beneficiaryId,
    required String fullName,
    required String relationship,
    required String birthDate,
    required double percAlloc,
    required String address,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        payload:
            beneficiaryId == null
                ? dio.FormData.fromMap({
                  'FullName': fullName,
                  'Relationship': relationship,
                  'birth_date': birthDate,
                  'perc_alloc': percAlloc,
                  'address': address,
                })
                : dio.FormData.fromMap({
                  'beneficiary_id': beneficiaryId,
                  'FullName': fullName,
                  'Relationship': relationship,
                  'birth_date': birthDate,
                  'perc_alloc': percAlloc,
                  'address': address,
                }),
        endPoint: Env.updateBeneficiary,
      );
      return ApiResponse<List<Beneficiary>>.fromJson(
        res,
        (data) =>
            (data['beneficiary'] as List)
                .map((e) => Beneficiary.fromJson(e))
                .toList(),
      );
    });
  }
}
