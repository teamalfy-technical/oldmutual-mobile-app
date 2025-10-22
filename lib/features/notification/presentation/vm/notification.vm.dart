import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PNotificationVM extends GetxController {
  static PNotificationVM instance = Get.find();

  final context = Get.context!;

  var notifications = <NotificationModel>[].obs;

  var groupedNotifications = <String, List<NotificationModel>>{}.obs;
  var unreadCount = 0.obs;

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
        ).successMessage(title: 'success'.tr, message: res.message ?? '');
      },
    );
  }

  /// Function to enable notifications
  Future<void> enableNotifications() async {
    pensionAppLogger.e(token);
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
        ).successMessage(title: 'success'.tr, message: res.message ?? '');
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
        groupNotificationsByDate();
        getUnreadNotificationCount();
        // markNotificationsAsRead(
        //   ids: notifications.map((e) => e.id ?? '').toList(),
        // );
      },
    );
  }

  /// Function to get unread notifications count
  Future<void> getUnreadNotificationCount() async {
    final result = await notificationService.getUnreadNotificationsCount();
    result.fold(
      (err) {
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: 'error'.tr, message: err.message);
      },
      (res) {
        // updateLoadingState(LoadingState.completed);
        unreadCount.value = res.data ?? 0;
      },
    );
  }

  Map<String, List<NotificationModel>> groupNotificationsByDate() {
    final now = DateTime.now().toUtc();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final lastWeekStart = today.subtract(const Duration(days: 7));

    Map<String, List<NotificationModel>> grouped = {
      'Today': [],
      'Yesterday': [],
      'Last Week': [],
      'Older': [],
    };

    for (var n in notifications) {
      final createdAt = DateTime.parse(
        n.createdAt ?? DateTime.now().toIso8601String(),
      ).toUtc();
      final dateOnly = DateTime(createdAt.year, createdAt.month, createdAt.day);

      if (dateOnly.isAtSameMomentAs(today)) {
        grouped['Today']!.add(n);
      } else if (dateOnly.isAtSameMomentAs(yesterday)) {
        grouped['Yesterday']!.add(n);
      } else if (dateOnly.isAfter(lastWeekStart) && dateOnly.isBefore(today)) {
        grouped['Last Week']!.add(n);
      } else {
        grouped['Older']!.add(n);
      }
    }

    grouped.removeWhere((_, list) => list.isEmpty);
    groupedNotifications.value = grouped;
    pensionAppLogger.i(groupedNotifications);
    return grouped;
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
