import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/presentation/vm/cross.sell.vm.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/widgets/animated.listview.dart';

class PRecommendationPage extends StatelessWidget {
  PRecommendationPage({super.key});

  final vm = Get.put(PCrossSellVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('recommended_for_you'.tr)),
      body: SafeArea(
        child: PAnimatedListView(
          separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
          shrinkWrap: true,
          items: vm.recommendations,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (index, recommendation) {
            return RecommendationWidget(
              recommendation: recommendation,
              showArrowButton: false,
              onTap: () => PHelperFunction.switchScreen(
                destination: Routes.recommendationHighlightPage,
                args: recommendation,
              ),
            );
          },
        ).all(PAppSize.s16),
      ),
    );
  }
}
