import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PStatementWidgetRedact extends StatelessWidget {
  final LoadingState loading;

  const PStatementWidgetRedact({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    // debugPrint(beneficiary['show'].toString());
    return Container(
      width: PDeviceUtil.getDeviceWidth(context),
      // height: PDeviceUtil.getDeviceHeight(context) * 0.3,
      padding: EdgeInsets.all(PAppSize.s20),
      margin: EdgeInsets.only(bottom: PAppSize.s20),
      color: PAppColor.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
                PAppSize.s16.verticalSpace,
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
              ],
            ),
          ),
          PAppSize.s8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
                PAppSize.s16.verticalSpace,
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
              ],
            ),
          ),
          PAppSize.s8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
                PAppSize.s16.verticalSpace,
                Container(
                  width: PDeviceUtil.getDeviceWidth(context),
                  height: PAppSize.s16,
                  color: PAppColor.whiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loading == LoadingState.loading ? true : false,
    );
  }
}
