import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/notification/presentation/vm/notification.vm.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PNotificationPage extends StatelessWidget {
  final ctrl = Get.put(PNotificationVM());
  PNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('notification'.tr),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: ctrl.getNotifications,
          color: PAppColor.primary,
          child:
              ctrl.loading.value == LoadingState.loading
                  ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return PNotificationRedactWidget(
                        loading: ctrl.loading.value,
                      );
                    },
                  )
                  : ctrl.notifications.isEmpty
                  ? PEmptyStateWidget(message: 'no_results_found'.tr)
                  : ListView.separated(
                    separatorBuilder:
                        (context, index) =>
                            Divider(color: PAppColor.fillColor2),
                    itemCount: ctrl.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = ctrl.notifications[index];
                      return PNotificationWidget(
                        onTap: () {
                          if (notification.readAt == null) {
                            ctrl.markNotificationAsRead(
                              notificationModel: notification,
                            );
                          }
                        },
                        notification: notification,
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
