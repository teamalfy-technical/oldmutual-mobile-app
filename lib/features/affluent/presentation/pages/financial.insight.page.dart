import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PFinancialInsightPage extends StatefulWidget {
  const PFinancialInsightPage({super.key});

  @override
  State<PFinancialInsightPage> createState() => _PFinancialInsightPageState();
}

class _PFinancialInsightPageState extends State<PFinancialInsightPage> {
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    'All',
    'Insurance',
    'Restaurant',
    'Financial',
  ];

  final List<Map<String, dynamic>> recommendedArticles = [
    {
      'duration': '6 mins',
      'title': 'Income Protection Strategies',
      'description':
          'Discover five essential ways to safeguard your income against unexpected events....',
      'long_description': '''Safeguarding Your Income

Your income is your most valuable asset. Protecting it ensures financial stability for you and your family, regardless of life's uncertainties.

Five Essential Strategies
• Disability Insurance: Provides income if you're unable to work due to illness or injury.
• Critical Illness Cover: Lump sum payment upon diagnosis of serious conditions.
• Emergency Fund: Maintain 6-12 months of expenses in liquid savings.
• Multiple Income Streams: Develop passive income sources to reduce dependency on a single income.
• Professional Liability: Protect against claims related to your professional services.

Coverage Adequacy

Review your coverage annually to ensure it keeps pace with income increases and lifestyle changes. Affluent individuals often need higher coverage limits than standard policies offer.

Integration with Financial Plan

Income protection should be part of a comprehensive financial strategy that includes investments, retirement planning, and estate planning.''',
      'type': ContentType.article,
    },
    {
      'duration': '6 mins',
      'title': 'Tax Planning Strategies for 2026',
      'description':
          'Learn key tax optimization techniques from our financial experts to maximize your...',
      'long_description':
          '''In this video, our senior tax advisors discuss the latest tax planning strategies specifically tailored for high net worth individuals.

Topics Covered:
• New tax law changes for 2026
• Advanced deduction strategies
• Tax-efficient investment vehicles
• Charitable giving optimization
• Estate tax planning updates

Our experts break down complex tax concepts into actionable strategies you can implement immediately to reduce your tax liability while staying fully compliant.''',
      'video_url': 'https://www.youtube.com/watch?v=p7HKvqRI_Bo',
      'type': ContentType.video,
    },
    {
      'duration': '6 mins',
      'title': 'Retirement Planning Timeline',
      'description':
          'A comprehensive guide to planning your retirement at every stage of life...',

      'long_description': '''Safeguarding Your Income

Your income is your most valuable asset. Protecting it ensures financial stability for you and your family, regardless of life's uncertainties.

Five Essential Strategies
• Disability Insurance: Provides income if you're unable to work due to illness or injury.
• Critical Illness Cover: Lump sum payment upon diagnosis of serious conditions.
• Emergency Fund: Maintain 6-12 months of expenses in liquid savings.
• Multiple Income Streams: Develop passive income sources to reduce dependency on a single income.
• Professional Liability: Protect against claims related to your professional services.

Coverage Adequacy

Review your coverage annually to ensure it keeps pace with income increases and lifestyle changes. Affluent individuals often need higher coverage limits than standard policies offer.

Integration with Financial Plan

Income protection should be part of a comprehensive financial strategy that includes investments, retirement planning, and estate planning.''',
      'type': ContentType.article,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: AppBar(title: Text('financial_insights_title'.tr)),
      body: Column(
        children: [
          SizedBox(
            height: PDeviceUtil.getDeviceHeight(context) * 0.25,
            child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: PAppSize.s20),
                  width: PDeviceUtil.getDeviceWidth(context) * 0.70,
                  decoration: BoxDecoration(
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.cardDarkColor
                        : PAppColor.whiteColor,
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // height: PDeviceUtil.getDeviceHeight(context) * 0.15,
                          width: PDeviceUtil.getDeviceWidth(context),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://picsum.photos/200/300',
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(PAppSize.s20),
                              topRight: Radius.circular(PAppSize.s20),
                            ),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'wealth_preservation_strategies'.tr,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s15,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'wealth_preservation_desc'.tr,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: PAppSize.s13,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ).all(PAppSize.s20),
                    ],
                  ),
                );
              },
            ),
          ),

          // Browse by category
          PAppSize.s16.verticalSpace,
          // Quick Actions for Affluent Users
          PSeeAllWidget(leadingText: 'browse_by_category'.tr),

          PAppSize.s16.verticalSpace,

          // Category Pills
          SizedBox(
            height: PAppSize.s50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) =>
                  PAppSize.s12.horizontalSpace,
              itemBuilder: (context, index) {
                final isSelected = selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: PAppSize.s28,
                      vertical: PAppSize.s8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? PAppColor.cardDarkColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(PAppSize.s24),
                      border: Border.all(
                        color: isSelected
                            ? PAppColor.cardDarkColor
                            : PAppColor.fillColor4.withOpacityExt(
                                PAppSize.s0_4,
                              ),
                        width: PAppSize.s1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? PAppColor.whiteColor
                              : PHelperFunction.isDarkMode(context)
                              ? PAppColor.whiteColor
                              : PAppColor.darkBgColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Recommended for you
          PAppSize.s16.verticalSpace,
          // Quick Actions for Affluent Users
          PSeeAllWidget(leadingText: 'recommended_for_you'.tr),

          PAppSize.s16.verticalSpace,

          // Recommended Articles List
          Expanded(
            child: ListView.separated(
              itemCount: recommendedArticles.length,
              separatorBuilder: (context, index) => PAppSize.s20.verticalSpace,
              itemBuilder: (context, index) {
                final article = recommendedArticles[index];
                return _RecommendedCard(
                  onTap: () => PHelperFunction.switchScreen(
                    destination: Routes.financialInsightDetailPage,
                    args: article,
                  ),

                  type:
                      (article['type'] as ContentType).name.capitalizeFirst ??
                      '',
                  duration: '${article['duration']} read' ?? '',
                  title: article['title'] ?? '',
                  description: article['description'] ?? '',
                );
              },
            ),
          ),
        ],
      ).all(PAppSize.s20),
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
