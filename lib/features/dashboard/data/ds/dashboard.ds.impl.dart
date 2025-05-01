import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

final DashboardDs homeDs = Get.put(DashboardDsImpl());

class DashboardDsImpl implements DashboardDs {
  @override
  Future<ApiResponse<List<Scheme>>> getMemberSchemes() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getMemberSchemes,
      );
      return ApiResponse<List<Scheme>>.fromJson(
        res,
        (data) => (data as List).map((e) => Scheme.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<SelectedScheme>> getSelectedMemberScheme({
    required String employerNumber,
    required String ssnitNumber,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'employer_number': employerNumber,
        'ssnit_number': ssnitNumber,
        'member_number': memberNumber,
        'master_scheme': masterScheme,
        'scheme_type': schemeType,
      });
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.getSelectedMemberScheme,
        payload: payload,
      );
      return ApiResponse<SelectedScheme>.fromJson(
        res,
        (data) => SelectedScheme.fromJson(data),
      );
    });
  }
}
