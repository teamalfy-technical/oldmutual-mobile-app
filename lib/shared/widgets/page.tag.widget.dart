import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PPageTagWidget extends StatelessWidget {
  final String tag;
  final SvgPicture? icon;
  final TextAlign textAlign;
  const PPageTagWidget({
    super.key,
    required this.tag,
    this.textAlign = TextAlign.start,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PDeviceUtil.getDeviceWidth(context),
      color: PAppColor.blackColor,
      padding: EdgeInsets.symmetric(
        vertical: PAppSize.s16,
        horizontal: PAppSize.s16,
      ),
      child:
          icon == null
              ? Text(
                tag,
                textAlign: textAlign,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PAppColor.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? SizedBox.shrink(),
                  PAppSize.s2.horizontalSpace,
                  Expanded(
                    child: Text(
                      tag,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: PAppColor.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
