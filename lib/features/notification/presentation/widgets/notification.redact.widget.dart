import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PNotificationRedactWidget extends StatelessWidget {
  const PNotificationRedactWidget({super.key, required this.loading});

  final LoadingState loading;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PAppColor.fillColor,
            borderRadius: BorderRadius.circular(PAppSize.s10),
          ),
          child: Row(
            children: [
              Container(
                width: PAppSize.s50,
                height: PAppSize.s50,
                decoration: BoxDecoration(
                  color: PAppColor.blackColor,
                  borderRadius: BorderRadius.circular(PAppSize.s16),
                ),
              ),
              PAppSize.s8.horizontalSpace,
              // title & subtitle
              Expanded(
                child: Text(
                  '******************************************',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color:
                        PHelperFunction.isDarkMode(context)
                            ? PAppColor.text50
                            : PAppColor.text500,
                    fontSize: PAppSize.s14,
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
                    '***************',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: PAppSize.s13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  PAppSize.s8.verticalSpace,
                  Text(
                    '***************',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: PAppSize.s13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .symmetric(horizontal: PAppSize.s12, vertical: PAppSize.s6)
        .redacted(
          context: context,
          redact: loading == LoadingState.loading ? true : false,
        );
  }
}
