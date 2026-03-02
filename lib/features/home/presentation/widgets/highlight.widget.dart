import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';

class HighlightWidget extends StatelessWidget {
  const HighlightWidget({
    super.key,
    required this.highlight,
    required this.index,
    this.onTap,
    required this.vm,
    this.affluent = false,
  });

  final Highlight highlight;
  final PHomeVm vm;
  final bool affluent;
  final Function()? onTap;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Hero(
              tag: highlight.title,
              child:
                  Container(
                    padding: EdgeInsets.all(PAppSize.s4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            // index == vm.highlights.length - 1
                            //     ? [Color(0xFFA7A9AC), Color(0xFFA7A9AC)]
                            //     :
                            affluent
                            ? [PAppColor.darkGold, PAppColor.lightGold]
                            : [PAppColor.primaryDark, PAppColor.primary],
                      ), //
                    ),
                    child: Container(
                      height: PAppSize.s60,
                      width: PAppSize.s60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PHelperFunction.isDarkMode(context)
                              ? PAppColor.cardDarkColor
                              : PAppColor.whiteColor,
                          width: PAppSize.s3,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: index == 1
                              ? Alignment.topRight
                              : (index == 3 || index == 4 || index == 6)
                              ? Alignment.centerLeft
                              : Alignment.center,
                          image: AssetImage(highlight.thumbnail),
                        ),
                      ),
                    ),
                  ).onPressed(
                    onTap: onTap,
                    radius: BorderRadius.circular(PAppSize.s32),
                  ),
            ),
            if (index == 0) ...[
              Positioned(
                bottom: 0,
                left: 12,
                right: 12,
                child: Container(
                  alignment: Alignment.center,
                  // height: 24,
                  // width: 100,
                  // padding: EdgeInsets.all(PAppSize.s2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s22),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF37021),
                        Color(0xFFFF3B52),
                        Color(0XFFED0080),
                      ],
                    ), //
                  ),
                  child: Text(
                    'new'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: PAppColor.textColorDark,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        PAppSize.s6.verticalSpace,
        Text(
          highlight.title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
