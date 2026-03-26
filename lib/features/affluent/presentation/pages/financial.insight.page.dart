import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFinancialInsightPage extends StatelessWidget {
  PFinancialInsightPage({super.key}) {
    vm.getContentCategories();
    vm.getContents();
  }

  final vm = PAffluentVm.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('financial_insights_title'.tr)),
      body: Obx(
        () => Column(
          children: [
            // Highlighted contents
            vm.contentsLoading.value == LoadingState.loading
                ? SizedBox(
                    height: PDeviceUtil.getDeviceHeight(context) * 0.25,
                    child: PShimmerWrapper(
                      loading: true,
                      child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PHighlightedContentCard(
                            title: 'Loading title here',
                            description: 'Loading description text...',
                          );
                        },
                      ),
                    ),
                  )
                : vm.contents.isEmpty
                ? SizedBox.shrink()
                : SizedBox(
                    height: PDeviceUtil.getDeviceHeight(context) * 0.25,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        itemCount: vm.contents.length > 2
                            ? 2
                            : vm.contents.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final content = vm.contents[index];
                          return PHighlightedContentCard(
                            title:
                                '${content.title} • ${content.duration ?? '6 mins'} read',
                            description: content.description ?? '',
                            thumbnail: content.thumbnail,
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.financialInsightDetailPage,
                              args: content,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

            // Browse by category
            (vm.contents.isEmpty &&
                    vm.contentsLoading.value != LoadingState.loading)
                ? PAppSize.s0.verticalSpace
                : PAppSize.s16.verticalSpace,
            // Quick Actions for Affluent Users
            PSeeAllWidget(
              leadingText: 'browse_by_category'.tr,
              showTrailing: false,
            ),

            PAppSize.s16.verticalSpace,

            // Category Pills
            if (vm.contentCategoriesLoading.value == LoadingState.loading)
              PShimmerWrapper(
                loading: true,
                child: PCategoryPills(
                  categories: ['All', 'Category', 'Category', 'Category'],
                  selectedIndex: 0,
                  onSelected: (_) {},
                ),
              )
            else
              PCategoryPills(
                categories: vm.fCategories,
                selectedIndex: vm.selectedFCategoryIndex.value,
                onSelected: vm.onSelectedFCategory,
              ),

            // Recommended for you
            PAppSize.s16.verticalSpace,
            PSeeAllWidget(
              leadingText: 'recommended_for_you'.tr,
              showTrailing: false,
            ),

            PAppSize.s16.verticalSpace,

            // Contents List
            Expanded(
              child: vm.contentsLoading.value == LoadingState.loading
                  ? PShimmerWrapper(
                      loading: true,
                      child: ListView.separated(
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            PAppSize.s20.verticalSpace,
                        itemBuilder: (context, index) {
                          return _RecommendedCard(
                            type: 'Article',
                            duration: '6 mins read',
                            title: 'Loading content title here',
                            description: 'Loading content description text...',
                          );
                        },
                      ),
                    )
                  : vm.contents.isEmpty
                  ? PEmptyStateWidget(message: 'no_results_found'.tr)
                  : ListView.separated(
                      itemCount: vm.contents.length,
                      separatorBuilder: (context, index) =>
                          PAppSize.s20.verticalSpace,
                      itemBuilder: (context, index) {
                        final content = vm.contents[index];
                        return _RecommendedCard(
                          onTap: () => PHelperFunction.switchScreen(
                            destination: Routes.financialInsightDetailPage,
                            args: content,
                          ),
                          type: content.contentType?.capitalizeFirst ?? '',
                          duration: '${content.duration ?? '6 mins'} read',
                          title: content.title ?? '',
                          description: content.description ?? '',
                        );
                      },
                    ),
            ),
          ],
        ).all(PAppSize.s20),
      ),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type and Duration
          Text(
            '$type • $duration',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w400,
            ),
          ),

          PAppSize.s8.verticalSpace,

          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: PAppSize.s16,
              fontWeight: FontWeight.w600,
            ),
          ),

          PAppSize.s4.verticalSpace,

          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: PAppSize.s14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ).paddingAll(PAppSize.s20).onPressed(onTap: onTap),
    );
  }
}
