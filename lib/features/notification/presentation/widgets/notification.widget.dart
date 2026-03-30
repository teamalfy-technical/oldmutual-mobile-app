import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';

class PNotificationWidget extends StatelessWidget {
  const PNotificationWidget({
    super.key,
    required this.notification,
    this.onTap,
    this.loading = false,
  });

  final NotificationModel notification;
  final Function()? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loading
            ? Container(
                width: PAppSize.s50,
                height: PAppSize.s50,
                decoration: BoxDecoration(
                  color: PAppColor.coolGrey.withOpacityExt(PAppSize.s0_2),
                  borderRadius: BorderRadius.circular(PAppSize.s16),
                ),
              )
            : Transform.translate(
                offset: Offset(0, 5),
                child: PBadgeWidget(
                  showBadge: notification.readAt == null,
                  child: PHelperFunction.getBadgeIcon(
                    notification.data?.title ??
                        notification.data?.message ??
                        '',
                  ),
                ),
              ),

        PAppSize.s16.horizontalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${notification.data?.title} ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),

              Text(
                '${notification.data?.message} ',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                PFormatter.formatAlertDateTime(
                  DateTime.parse(
                    notification.data?.paymentDate ??
                        notification.createdAt ??
                        DateTime.now().toIso8601String(),
                  ),
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: PAppColor.greyColor),
              ),
            ],
          ),
        ),
      ],
    ).onPressed(onTap: onTap);
  }
}
