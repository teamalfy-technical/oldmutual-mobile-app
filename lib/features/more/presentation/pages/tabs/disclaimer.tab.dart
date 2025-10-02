import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PDisclaimerTab extends StatelessWidget {
  const PDisclaimerTab({super.key});

  final String text =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 

Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      body: Container(
        padding: EdgeInsets.all(PAppSize.s16),
        decoration: BoxDecoration(
          color: PHelperFunction.isDarkMode(context)
              ? PAppColor.darkAppBarColor
              : PAppColor.whiteColor,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: PAppSize.s14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
