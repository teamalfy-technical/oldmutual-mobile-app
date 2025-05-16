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
    required String employerName,
    required String employerNumber,
    required String ssnitNumber,
    required String memberName,
    required String memberNumber,
    required String masterScheme,
    required String schemeType,
    required String email,
    required String dob,
    required String dateJoined,
    required String sex,
    required String nationality,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final payload = dio.FormData.fromMap({
        'employer_name': employerName,
        'employer_number': employerNumber,
        'ssnit_number': ssnitNumber,
        'member_name': memberName,
        'member_number': memberNumber,
        'master_scheme': masterScheme,
        'scheme_type': schemeType,
        'email': email,
        'dob': dob,
        'date_joined': dateJoined,
        'sex': sex,
        'nationality': nationality,
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
