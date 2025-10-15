import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';

class PTermsAndConditionsPage extends StatelessWidget {
  PTermsAndConditionsPage({super.key});

  final vm = Get.put(PPolicyVm());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: PHelperFunction.isDarkMode(context)
            ? PAppColor.darkBgColor
            : PAppColor.fillColor,
        appBar: AppBar(
          title: Text('terms_and_conditions'.tr),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              PAppSize.kTabHeight,
            ), // custom height
            child: Container(
              color: PHelperFunction.isDarkMode(context)
                  ? PAppColor.darkBgColor
                  : PAppColor.fillColor,
              child: TabBar(
                indicatorColor: PAppColor.transparentColor,
                padding: EdgeInsets.only(top: PAppSize.s4),
                indicatorPadding: EdgeInsetsGeometry.all(PAppSize.s9),
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
                  border: Border.all(
                    width: PAppSize.s0_5,
                    color: PAppColor.fillColor2,
                  ),
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

                tabs: [
                  Tab(text: 'terms_and_conditions'.tr),
                  Tab(text: 'disclaimers'.tr),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [PTermsTab(), PDisclaimerTab()],
        ).symmetric(horizontal: PAppSize.s0, vertical: PAppSize.s6),
      ),
    );
  }
}
