import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PSaveContentPage extends StatefulWidget {
  const PSaveContentPage({super.key});

  @override
  State<PSaveContentPage> createState() => _PSaveContentPageState();
}

class _PSaveContentPageState extends State<PSaveContentPage> {
  final vm = PAffluentVm.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    vm.fetchBookmarkedContents();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      vm.fetchBookmarkedContents(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = PHelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('${'save_content'.tr}s')),
      body: Obx(() {
        if (vm.contentsLoading.value == LoadingState.loading &&
            vm.bookmarkedContents.isEmpty) {
          return PShimmerWrapper(
            loading: true,
            child: ListView.separated(
              padding: EdgeInsets.all(PAppSize.s20),
              itemCount: 10,
              separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
              itemBuilder: (context, index) {
                return _SavedContentCard(
                  type: 'Article',
                  duration: '5 mins read',
                  title: 'Placeholder title here',
                  description:
                      'Placeholder description text goes here for shimmer loading',
                );
              },
            ),
          );
        }

        if (vm.bookmarkedContents.isEmpty) {
          return Center(
            child: Text(
              'no_saved_content'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: PAppSize.s16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.all(PAppSize.s20),
          itemCount:
              vm.bookmarkedContents.length +
              (vm.isLoadingMoreBookmarks.value ? 1 : 0),
          separatorBuilder: (context, index) => PAppSize.s16.verticalSpace,
          itemBuilder: (context, index) {
            if (index == vm.bookmarkedContents.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(PAppSize.s16),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final bookmarked = vm.bookmarkedContents[index];
            final content = bookmarked.content;
            return _SavedContentCard(
              onTap: () {
                if (content != null) {
                  PHelperFunction.switchScreen(
                    destination: Routes.financialInsightDetailPage,
                    args: content,
                  );
                }
              },
              type: content?.contentType?.capitalizeFirst ?? '',
              duration: '${content?.duration ?? 'default_duration'.tr} read',
              title: content?.title ?? '',
              description: content?.description ?? '',
            );
          },
        );
      }),
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
