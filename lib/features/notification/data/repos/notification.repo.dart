import 'package:fpdart/fpdart.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/notification/domain/models/notification.dart';

abstract class NotificationRepo {
  Future<Either<PFailure, ApiResponse<List<Message>>>> disableNotifications({
    required String deviceToken,
  });
  Future<Either<PFailure, ApiResponse<List<Message>>>> enableNotifications({
    required String deviceToken,
  });
  Future<Either<PFailure, ApiResponse<List<NotificationModel>>>>
  getNotifications();
}
