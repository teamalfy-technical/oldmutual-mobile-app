import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PNotificationPage extends StatelessWidget {
  final ctrl = Get.put(PNotificationVM());
  PNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
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
              child: RefreshIndicator(
                onRefresh: ctrl.getNotifications,
                color: PAppColor.primary,
                child: ctrl.loading.value == LoadingState.loading
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return PNotificationRedactWidget(
                            loading: ctrl.loading.value,
                          );
                        },
                      )
                    : ctrl.notifications.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: PAppColor.fillColor2),
                        itemCount: ctrl.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = ctrl.notifications[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(CupertinoIcons.person_fill),
                              PAppSize.s16.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${notification.data?.title} ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(),
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${notification.data?.message} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          PFormatter.formatAlertDateTime(
                                            DateTime.parse(
                                              notification.data?.paymentDate ??
                                                  notification.createdAt ??
                                                  DateTime.now()
                                                      .toIso8601String(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // ListTile(
                                    //   leading: Icon(CupertinoIcons.person_fill),

                                    //   //  Assets.icons.personBlack.svg(
                                    //   //   color: PAppColor.darkBgColor,
                                    //   // ),
                                    //   title:
                                    //   subtitle:
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          );

                          // PNotificationWidget(
                          //   onTap: () {
                          //     if (notification.readAt == null) {
                          //       ctrl.markNotificationAsRead(
                          //         notificationModel: notification,
                          //       );
                          //     }
                          //   },
                          //   notification: notification,
                          // );
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
