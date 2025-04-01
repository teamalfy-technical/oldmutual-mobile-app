import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PNotificationWidget extends StatelessWidget {
  const PNotificationWidget({
    super.key,
    required this.notification,
    this.onTap,
  });

  final NotificationModel notification;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PAppSize.s8),
      ),
      child: Row(
            children: [
              Container(
                width: PAppSize.s50,
                height: PAppSize.s50,
                decoration: BoxDecoration(
                  color:
                      notification.readAt == null
                          ? PAppColor.blackColor
                          : PAppColor.primary.withOpacityExt(PAppSize.s0_2),
                  shape: BoxShape.circle,
                ),
                child:
                    Assets.icons.notificationGreenIcon
                        .svg(width: PAppSize.s20, height: PAppSize.s20)
                        .centered(),
              ),
              PAppSize.s8.horizontalSpace,
              // title & subtitle
              Expanded(
                child: Text(
                  '${notification.data?.message} ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        PHelperFunction.isDarkMode(context)
                            ? PAppColor.text50
                            : PAppColor.text500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              PAppSize.s8.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    PFormatter.formatTime(
                      date: DateTime.parse(
                        notification.data?.paymentDate ??
                            notification.createdAt ??
                            DateTime.now().toIso8601String(),
                      ),
                      dateFormat: DateFormat.jm(),
                    ).toLowerCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: PAppSize.s13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  PAppSize.s8.verticalSpace,
                  Text(
                    PFormatter.formatDate(
                      date: DateTime.parse(
                        notification.data?.paymentDate ??
                            notification.createdAt ??
                            DateTime.now().toIso8601String(),
                      ),
                      dateFormat: DateFormat('dd-MM-yy'),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: PAppSize.s13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          )
          .symmetric(horizontal: PAppSize.s12, vertical: PAppSize.s6)
          .onPressed(onTap: onTap),
    );
    // return ListTile(
    //   leading: CircleAvatar(
    //     radius: 24,
    //     backgroundColor: PAppColor.blackColor,

    //     child:
    //         // index == 1
    //         //     ? Assets.icons.warningRedIcon
    //         //         .svg(width: PAppSize.s20, height: PAppSize.s20)
    //         //         .centered()
    //         //     :
    //         Assets.icons.notificationGreenIcon
    //             .svg(width: PAppSize.s20, height: PAppSize.s20)
    //             .centered(),
    //   ),
    //   title: Text(
    //     notification.data?.message ?? '',
    //     style: Theme.of(
    //       context,
    //     ).textTheme.bodyLarge?.copyWith(fontSize: PAppSize.s15),
    //   ),
    //   trailing: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: [
    //       Text(
    //         PFormatter.formatTime(
    //           date: DateTime.parse(
    //             notification.data?.paymentDate ??
    //                 DateTime.now().toIso8601String(),
    //           ),
    //           dateFormat: DateFormat.jm(),
    //         ).toLowerCase(),
    //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //           fontSize: PAppSize.s13,
    //           fontWeight: FontWeight.w400,
    //         ),
    //       ),
    //       // PAppSize.s8.verticalSpace,
    //       Text(
    //         PFormatter.formatDate(
    //           date: DateTime.parse(
    //             notification.data?.paymentDate ??
    //                 DateTime.now().toIso8601String(),
    //           ),
    //           dateFormat: DateFormat('dd-MM-yy'),
    //         ),
    //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //           fontSize: PAppSize.s13,
    //           fontWeight: FontWeight.w400,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
