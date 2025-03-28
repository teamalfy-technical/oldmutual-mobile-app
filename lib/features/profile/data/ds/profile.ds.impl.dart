import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/auth/domain/models/member.model.dart';
import 'package:oldmutual_pensions_app/features/profile/data/ds/profile.ds.dart';

final ProfileDs profileDs = Get.put(ProfileDsImpl());

class ProfileDsImpl implements ProfileDs {
  @override
  Future<ApiResponse<Message>> changePassword() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.changePassword,
      );
      return ApiResponse<Message>.fromJson(
        res,
        (data) => Message.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Message>> deleteAccount() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.delete,
        endPoint: Env.deleteAccount,
      );
      return ApiResponse<Message>.fromJson(
        res,
        (data) => Message.fromJson(data),
      );
    });
  }

  @override
  Future<ApiResponse<Member>> getProfile() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getUserProfile,
      );
      return ApiResponse<Member>.fromJson(res, (data) => Member.fromJson(data));
    });
  }

  @override
  Future<ApiResponse<List<Message>>> logout() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.logout,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }
}
