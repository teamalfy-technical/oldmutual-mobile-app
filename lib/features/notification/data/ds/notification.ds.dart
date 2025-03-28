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
}
