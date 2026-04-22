import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

class PCustomTabBarWidget extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double horizontalPadding;
  final double? verticalPadding;
  final double? verticalIndicatorPadding;

  final BorderRadius? borderRadius;
  const PCustomTabBarWidget({
    super.key,
    required this.tabs,
    this.controller,
    this.horizontalPadding = PAppSize.s12,
    this.verticalPadding,
    this.borderRadius,
    this.verticalIndicatorPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkBgColor
            : PAppColor.fillColor,
        borderRadius: borderRadius ?? BorderRadius.circular(PAppSize.s0),
      ),
      child: TabBar(
        controller: controller,
        indicatorColor: PAppColor.transparentColor,
        padding: EdgeInsets.only(
          top: verticalPadding ?? PAppSize.s8,
          bottom: verticalPadding ?? PAppSize.s8,
          left: horizontalPadding,
          right: horizontalPadding,
        ),
        indicatorPadding: EdgeInsetsGeometry.symmetric(
          horizontal: PAppSize.s0,
          vertical: verticalIndicatorPadding ?? PAppSize.s9,
        ),
        indicatorWeight: 1,
        dividerColor: PAppColor.transparentColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: PAppColor.blackColor,
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelColor: PHelperFunction.isDarkMode(context)
            ? PAppColor.whiteColor
            : PAppColor.textColorLight,
        unselectedLabelStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
        // labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(PAppSize.s7),
          color: PAppColor.whiteColor,
          border: Border.all(width: PAppSize.s0_5, color: PAppColor.fillColor2),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
              color: Color(0x26000000),
            ),
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
              color: Color(0x4D000000),
            ),
          ],
        ),
        tabs: tabs,
      ),
    );
  }
}
