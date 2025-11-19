import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/home/domain/highlight.model.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PHomeVm extends GetxController {
  static PHomeVm get instance => Get.find();

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  List<Highlight> highlights = [
    Highlight(
      title: 'new_feature_in_store'.tr,
      title2: 'new_feature'.tr,
      thumbnail: Assets.images.newFeatureImg.path,
      image: Assets.images.newFeatureBg.path,
      heading: 'Thrilled to \nannounce our \nhighlight feature!',
      description:
          'What’s new? With this feature, you’ll have quick access to offers, products, documents, and more.',
      onLearnMoreTap: null,
      onQuoteTap: null,
    ),
    Highlight(
      title: 'travel_insurance_text'.tr,
      title2: 'international_travel'.tr,
      heading: 'Travel Insurance from \nas low as GH¢120',
      description:
          'This is an insurance product that covers unforeseen losses that might occur to the insured when travelling internationally.',
      thumbnail: Assets.images.internationalTravelImg.path,
      image: Assets.images.internationalTravelBg.path,
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['international_travel'.tr, PAppConstant.travelInsuranceUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['international_travel'.tr, PAppConstant.travelInsuranceQuoteUrl],
      ),
    ),

    Highlight(
      title: 'investment_plan'.tr,
      title2: 'special_investments_plan'.tr,
      heading: 'Save for retirement',
      description:
          'Become self-sufficient and have more control over your life even in retirement.',
      thumbnail: Assets.images.specialInvestmentImg.path,
      image: Assets.images.specialInvestmentBg.path,
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: [
          'special_investments_plan'.tr,
          PAppConstant.specialInvestmentPlanUrl,
        ],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: [
          'special_investments_plan'.tr,
          PAppConstant.specialInvestmentPlanUrl,
        ],
      ),
    ),
    Highlight(
      title: 'educator_plan'.tr,
      title2: 'educator_plan'.tr,
      heading: 'educator_plan'.tr,
      description:
          'An insurance policy structured to enable parents to save for their children\'s education.',
      thumbnail: Assets.images.educatorPlanImg.path,
      image: Assets.images.educatorPlanBg.path,

      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['educator_plan'.tr, PAppConstant.educatorPlanUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['educator_plan'.tr, PAppConstant.educatorPlanUrl],
      ),
    ),
    Highlight(
      title: 'retirement_savings'.tr,
      title2: 'retirement_salary'.tr,
      thumbnail: Assets.images.retirementSalaryImg.path,
      image: Assets.images.retirementSalaryBg.path,
      heading: 'Life at retirement',
      description:
          'Start investing in your future so you can earn a regular income when you retire.',
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['retirement_salary'.tr, PAppConstant.retirementSalaryUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['retirement_salary'.tr, PAppConstant.retirementSalaryUrl],
      ),
    ),

    Highlight(
      title: 'transition_plus_plan'.tr,
      thumbnail: Assets.images.transitionPlusImg.path,
      image: Assets.images.transitionPlusBg.path,
      heading: 'Cover the cost of funeral expenses',
      description:
          'Give your loved ones a proper send-off without having to worry about funeral expenses',
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: [
          'transition_plus_plan'.tr.replaceAll('\n', ''),
          PAppConstant.transitionPlusPlanUrl,
        ],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: [
          'transition_plus_plan'.tr.replaceAll('\n', ''),
          PAppConstant.transitionPlusPlanUrl,
        ],
      ),
    ),
    Highlight(
      title: 'mvest_personal_pension'.tr,
      title2: 'mvest'.tr,
      thumbnail: Assets.images.mvestBg.path,
      image: Assets.images.mvestBg.path,
      heading: 'Accumulate funds for future projects',
      description:
          'Benefit from the expertise of the best minds in fund management with our Mvest Personal Pension plan',
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['mvest'.tr, PAppConstant.mvestPensionsUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['mvest'.tr, PAppConstant.mvestPensionsUrl],
      ),
    ),
    // Highlight(
    //   title: 'forgot_login_details'.tr,
    //   thumbnail: Assets.images.forgotDetailsImg.path,
    //   image: Assets.images.forgotDetailsImg.path,
    //   onLearnMoreTap: null,
    //   onQuoteTap: null,
    // ),
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      'title': 'educator_plan'.tr,
      'subTitle': 'An insurance policy structured to enable parents...',
      'image': Assets.images.educatorPlanBg.path,
    },
    {
      'title': 'Cover funeral costs.',
      'subTitle': 'Give your loved ones a proper send-off without ...',
      'image': Assets.images.transitionPlusBg.path,
    },
    {
      'title': 'special_investments_plan'.tr,
      'subTitle':
          'Become self-sufficient and have more control over your life...',
      'image': Assets.images.specialInvestmentBg.path,
    },
  ];
}
