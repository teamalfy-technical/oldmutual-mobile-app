import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';

final NotificationService notificationService = Get.put(
  NotificationServiceImpl(),
);

class NotificationServiceImpl implements NotificationService {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> disableNotifications({
    required String deviceToken,
  }) async {
    return notificationRepo.disableNotifications(deviceToken: deviceToken);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> enableNotifications({
    required deviceToken,
  }) async {
    return notificationRepo.enableNotifications(deviceToken: deviceToken);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<NotificationModel>>>>
  getNotifications() async {
    return notificationRepo.getNotifications();
  }

  @override
  Future<Either<PFailure, ApiResponse<int>>> getUnreadNotificationsCount() {
    return notificationRepo.getUnreadNotificationsCount();
  }

  @override
  Future<Either<PFailure, ApiResponse<NotificationModel>>>
  markNotificationAsRead({required String id}) {
    return notificationRepo.markNotificationAsRead(id: id);
  }

  @override
  Future<Either<PFailure, ApiResponse<List<NotificationModel>>>>
  markNotificationsAsRead({required List<String> ids}) {
    return notificationRepo.markNotificationsAsRead(ids: ids);
  }
}
