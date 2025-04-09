import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PNotificationVM extends GetxController {
  static PNotificationVM instance = Get.find();

  final context = Get.context!;

  var notifications = <NotificationModel>[].obs;

  final token = PSecureStorage().readData(PSecureStorage().deviceTokenKey);

  var loading = LoadingState.completed.obs;

  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  onInit() {
    getNotifications();
    super.onInit();
  }

  /// Function to disable notifications
  Future<void> disableNotifications() async {
    final result = await notificationService.disableNotifications(
      deviceToken: token ?? '',
    );
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: res.message ?? '');
      },
    );
  }

  /// Function to enable notifications
  Future<void> enableNotifications() async {
    final result = await notificationService.enableNotifications(
      deviceToken: token ?? '',
    );
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: res.message ?? '');
      },
    );
  }

  /// Function to get notifications
  Future<void> getNotifications() async {
    updateLoadingState(LoadingState.loading);
    final result = await notificationService.getNotifications();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        updateLoadingState(LoadingState.completed);
        notifications.value = res.data ?? [];
        // markNotificationsAsRead(
        //   ids: notifications.map((e) => e.id ?? '').toList(),
        // );
      },
    );
  }

  /// Function to mark notifications as read
  Future<void> markNotificationsAsRead({required List<String> ids}) async {
    final result = await notificationService.markNotificationsAsRead(ids: ids);
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        notifications.value = res.data ?? [];
      },
    );
  }

  /// Function to mark notification as read
  Future<void> markNotificationAsRead({
    required NotificationModel notificationModel,
  }) async {
    final result = await notificationService.markNotificationAsRead(
      id: notificationModel.id ?? '0',
    );
    result.fold(
      (err) {
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        final index = notifications.indexWhere(
          (element) => element.id == res.data?.id,
        );
        notifications.setAll(index, [res.data ?? NotificationModel()]);
        update();
      },
    );
  }
}
