import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PNotificationPage extends StatelessWidget {
  final ctrl = Get.put(PNotificationVM());
  PNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor3,
      appBar: AppBar(title: Text('notifications'.tr)),
      body: Obx(
        () => Stack(
          children: [
            Positioned(
              bottom: PAppSize.s0,
              right: PAppSize.s0,
              left: PAppSize.s0,

              child: Image.asset(
                Assets.images.notificationBtmBg.path,
                fit: BoxFit.fitWidth,
                width: PDeviceUtil.getDeviceWidth(context),
              ),
            ),
            Positioned.fill(
              child: RefreshIndicator.adaptive(
                onRefresh: ctrl.getNotifications,
                color: PAppColor.primary,
                child: ctrl.loading.value == LoadingState.loading
                    ? PShimmerListView<NotificationModel>(
                        loading: true,
                        items: const [],
                        separatorBuilder: (context, index) =>
                            PAppSize.s12.verticalSpace,
                        scrollDirection: Axis.vertical,
                        placeholderCount: 20,
                        placeholderItem: NotificationModel(
                          data: Data(
                            title: 'Notification Title',
                            message: 'Notification message placeholder',
                          ),
                          createdAt: DateTime.now().toIso8601String(),
                        ),
                        itemBuilder: (context, index, notification) {
                          return PNotificationWidget(
                            loading: ctrl.loading.value == LoadingState.loading,
                            notification: notification,
                          );
                        },
                      )
                    : ctrl.notifications.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        itemCount: ctrl.groupedNotifications.keys
                            .toList()
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (context, sectionIndex) {
                          final sectionTitle = ctrl.groupedNotifications.keys
                              .toList()[sectionIndex];
                          final sectionItems =
                              ctrl.groupedNotifications[sectionTitle]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PAppSize.s25.verticalSpace,
                              // 🏷 Section Header
                              Text(
                                sectionTitle,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              PAppSize.s6.verticalSpace,

                              Divider(),
                              PAppSize.s6.verticalSpace,
                              // 📜 Section Items
                              PAnimatedListView<NotificationModel>(
                                items: sectionItems,
                                separatorBuilder: (context, index) => Divider(),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (index, notification) =>
                                    PNotificationWidget(
                                      onTap: () {
                                        if (notification.readAt == null) {
                                          ctrl.markNotificationAsRead(
                                            notificationModel: notification,
                                          );
                                        }
                                      },
                                      notification: notification,
                                    ),
                              ),
                              // ListView.separated(
                              //   separatorBuilder: (context, index) => Divider(),
                              //   physics: NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemCount: sectionItems.length,
                              //   itemBuilder: (context, index) {
                              //     final notification = sectionItems[index];
                              //     return PNotificationWidget(
                              //       onTap: () {
                              //         if (notification.readAt == null) {
                              //           ctrl.markNotificationAsRead(
                              //             notificationModel: notification,
                              //           );
                              //         }
                              //       },
                              //       notification: notification,
                              //     );
                              //   },
                              // ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PAppSize.s20.verticalSpace,
          Transform.translate(
            offset: Offset(22, 0),
            child: Assets.icons.notificationEmpty.svg(
              width: PDeviceUtil.getDeviceWidth(context) - 50,
            ),
          ),
          PAppSize.s50.verticalSpace,
          Text(
            'noti_empty_title'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          PAppSize.s3.verticalSpace,
          Text(
            'noti_empty_subtitle'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
