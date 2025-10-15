import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';

abstract class NotificationDs {
  Future<ApiResponse<List<Message>>> disableNotifications({
    required deviceToken,
  });
  Future<ApiResponse<List<Message>>> enableNotifications({
    required deviceToken,
  });
  Future<ApiResponse<List<NotificationModel>>> getNotifications();

  Future<ApiResponse<NotificationModel>> getReadNotification({
    required String id,
  });
  Future<ApiResponse<List<NotificationModel>>> markNotificationsAsRead({
    required List<String> ids,
  });
  Future<ApiResponse<NotificationModel>> markNotificationAsRead({
    required String id,
  });
  Future<ApiResponse<int>> getUnreadNotificationsCount();
}
