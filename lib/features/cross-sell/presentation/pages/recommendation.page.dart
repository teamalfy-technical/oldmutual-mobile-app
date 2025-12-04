import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/presentation/vm/cross.sell.vm.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: vm.recommendations.length,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final recommendation = vm.recommendations[index];
            return RecommendationWidget(
              margin: EdgeInsets.only(bottom: PAppSize.s16),
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
