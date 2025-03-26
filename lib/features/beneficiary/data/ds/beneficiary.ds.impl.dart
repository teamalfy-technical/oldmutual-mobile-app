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
        (data) => (data as List).map((e) => Beneficiary.fromJson(e)).toList(),
      );
    });
  }
}
