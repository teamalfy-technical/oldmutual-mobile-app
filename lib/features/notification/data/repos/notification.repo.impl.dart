import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/errors/failure.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';
import 'package:oldmutual_pensions_app/features/notification/data/repos/notification.repo.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';

final NotificationRepo notificationRepo = Get.put(NotificationRepoImpl());

class NotificationRepoImpl implements NotificationRepo {
  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> disableNotifications({
    required String deviceToken,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await notificationDs.disableNotifications(
            deviceToken: deviceToken,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<Message>>>> enableNotifications({
    required deviceToken,
  }) async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function:
          () async => await notificationDs.enableNotifications(
            deviceToken: deviceToken,
          ),
    );
  }

  @override
  Future<Either<PFailure, ApiResponse<List<NotificationModel>>>>
  getNotifications() async {
    return await customRepositoryWrapper.wrapRepositoryFunction(
      function: () async => await notificationDs.getNotifications(),
    );
  }
}
