import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PSaveContentPage extends StatelessWidget {
  PSaveContentPage({super.key});

  final vm = PAffluentVm.instance;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('${'save_content'.tr}s')),
      body: Obx(
        () => vm.bookmarkedArticles.isEmpty
            ? Center(
                child: Text(
                  'no_saved_content'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: PAppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(PAppSize.s20),
                itemCount: vm.bookmarkedArticles.length,
                separatorBuilder: (context, index) =>
                    PAppSize.s16.verticalSpace,
                itemBuilder: (context, index) {
                  final article = vm.bookmarkedArticles[index];
                  return _SavedContentCard(
                    onTap: () => PHelperFunction.switchScreen(
                      destination: Routes.financialInsightDetailPage,
                      args: article,
                    ),
                    type:
                        article.contentType?.capitalizeFirst ?? '',
                    duration: '${article.duration ?? '5 mins'} read',
                    title: article.title ?? '',
                    description: article.description ?? '',
                  );
                },
              ),
      ),
    );
  }
}

class _SavedContentCard extends StatelessWidget {
  const _SavedContentCard({
    required this.type,
    required this.duration,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String type;
  final String duration;
  final String title;
  final String description;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PHelperFunction.isDarkMode(context)
            ? PAppColor.cardDarkColor
            : PAppColor.whiteColor,
        borderRadius: BorderRadius.circular(PAppSize.s16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$type • $duration',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: PAppSize.s14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PAppSize.s8.verticalSpace,
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: PAppSize.s16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PAppSize.s4.verticalSpace,
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: PAppSize.s14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Assets.icons.bookmarkIconSolid.svg(
            color: PHelperFunction.isDarkMode(context)
                ? PAppColor.whiteColor
                : PAppColor.blackColor,
          ),
        ],
      ).paddingAll(PAppSize.s20).onPressed(onTap: onTap),
    );
  }
}
