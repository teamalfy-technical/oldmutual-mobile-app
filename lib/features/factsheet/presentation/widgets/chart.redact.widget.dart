import 'package:flutter/widgets.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PChartRedactWidget extends StatelessWidget {
  final LoadingState loadingState;
  final double? height;
  const PChartRedactWidget({
    super.key,
    required this.loadingState,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PShimmerWrapper(
      loading: loadingState == LoadingState.loading,
      child: Container(
        width: PDeviceUtil.getDeviceWidth(context),
        height: height ?? PDeviceUtil.getDeviceHeight(context) * 0.40,
        padding: EdgeInsets.all(PAppSize.s20),
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
          borderRadius: BorderRadius.circular(PAppSize.s10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (_) => PShimmerBox(
              width: PDeviceUtil.getDeviceWidth(context) - PAppSize.s40,
              height: PAppSize.s20,
            ),
          ),
        ),
      ),
    );
  }
}
