import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/env/env.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';

final NotificationDs notificationDs = Get.put(NotificationDsImpl());

class NotificationDsImpl implements NotificationDs {
  @override
  Future<ApiResponse<List<Message>>> disableNotifications({
    required deviceToken,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.disableNotifications,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<Message>>> enableNotifications({
    required deviceToken,
  }) async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.post,
        endPoint: Env.enableNotifications,
      );
      return ApiResponse<List<Message>>.fromJson(
        res,
        (data) => (data as List).map((e) => Message.fromJson(e)).toList(),
      );
    });
  }

  @override
  Future<ApiResponse<List<NotificationModel>>> getNotifications() async {
    return await asyncFunctionWrapper.handleAsyncNetworkCall(() async {
      final res = await apiService.callService(
        requestType: RequestType.get,
        endPoint: Env.getNotifications,
      );
      return ApiResponse<List<NotificationModel>>.fromJson(
        res,
        (data) =>
            (data as List).map((e) => NotificationModel.fromJson(e)).toList(),
      );
    });
  }
}
