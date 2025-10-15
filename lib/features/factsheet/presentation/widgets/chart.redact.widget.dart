import 'package:flutter/widgets.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:redacted/redacted.dart';

class PChartRedactWidget extends StatelessWidget {
  final LoadingState loadingState;
  const PChartRedactWidget({super.key, required this.loadingState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PDeviceUtil.getDeviceWidth(context),
      height: PDeviceUtil.getDeviceHeight(context) * 0.3,
      padding: EdgeInsets.all(PAppSize.s20),
      color: PAppColor.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: PDeviceUtil.getDeviceWidth(context),
            height: PAppSize.s20,
            color: PAppColor.whiteColor,
          ),
          Container(
            width: PDeviceUtil.getDeviceWidth(context),
            height: PAppSize.s20,
            color: PAppColor.whiteColor,
          ),
          Container(
            width: PDeviceUtil.getDeviceWidth(context),
            height: PAppSize.s20,
            color: PAppColor.whiteColor,
          ),
          Container(
            width: PDeviceUtil.getDeviceWidth(context),
            height: PAppSize.s20,
            color: PAppColor.whiteColor,
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: loadingState == LoadingState.loading ? true : false,
    );
  }
}
