import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PNotificationPage extends StatelessWidget {
  const PNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'message': 'Your Monthly Contribution of \$500 Has Been Received',
        'date': DateTime.now().subtract(Duration(days: 7)).toIso8601String(),
      },
      {
        'message':
            'Security Alert: Unusual Login Activity Detected on Your Account!',
        'date':
            DateTime.now()
                .subtract(Duration(days: 22, minutes: 1))
                .toIso8601String(),
      },
      {
        'message': 'Your Monthly Contribution of \$500 Has Been Received',
        'date':
            DateTime.now()
                .subtract(Duration(days: 31, minutes: 5))
                .toIso8601String(),
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('notification'.tr),
      ),
      body: ListView.separated(
        separatorBuilder:
            (context, index) => Divider(color: PAppColor.fillColor2),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: PAppColor.blackColor,

              child:
                  index == 1
                      ? Assets.icons.warningRedIcon
                          .svg(width: PAppSize.s20, height: PAppSize.s20)
                          .centered()
                      : Assets.icons.notificationGreenIcon
                          .svg(width: PAppSize.s20, height: PAppSize.s20)
                          .centered(),
            ),
            title: Text(
              notification['message'] ?? '',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: PAppSize.s15),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  PFormatter.formatTime(
                    date: DateTime.parse(
                      notification['date'] ?? DateTime.now().toIso8601String(),
                    ),
                    dateFormat: DateFormat.jm(),
                  ).toLowerCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // PAppSize.s8.verticalSpace,
                Text(
                  PFormatter.formatDate(
                    date: DateTime.parse(
                      notification['date'] ?? DateTime.now().toIso8601String(),
                    ),
                    dateFormat: DateFormat('dd-MM-yy'),
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: PAppSize.s13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
