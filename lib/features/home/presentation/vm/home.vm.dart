import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/auth/domain/models/member.model.dart';
import 'package:oldmutual_pensions_app/features/home/domain/highlight.model.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PHomeVm extends GetxController {
  static PHomeVm get instance => Get.find();

  var currentIndex = 0.obs;
  var user = Rxn<Member>();

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    user.value = await PSecureStorage().getAuthResponse();
  }

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
      planDescription: 'Up to €30,000 emergency medical coverage abroad',
      benefits: [
        'Up to €30,000 emergency medical expenses cover',
        'Up to €30,000 emergency medical evacuation cover',
        '€3,000 permanent total disability cover',
        // '€3,000 permanent total disability cover'
      ],
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
      planDescription:
          'Long-term savings with life coverage and flexible withdrawals',
      benefits: [
        'Financial security',
        'Partial withdrawals of up to 50% of the total monthly contributions once in a year',
        'If the policyholder passes away, the beneficiary will receive either the death benefit or the total contributions, whichever is greater.',
      ],
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
      planDescription:
          'Secure your child\'s education with life coverage and savings',
      benefits: [
        'Child Life Assurance Protection',
        'Accumulated Fund Payback after 24 months',
        'Parent Disability Protection',
        'Partial withdrawals after 2 years',
      ],
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
      planDescription: 'SAffordable life cover with cashback every 3 years',
      benefits: [
        'Prompt payout within 48 hours',
        '10% cashback every 3 years',
        'No waiting period for accidental death',
        'Affordable premiums',
      ],
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
      planDescription: 'Secure your personal pension for the future',
      benefits: [
        'Competitive returns',
        'Lump-Sum payment',
        'Easy application and exit process',
        'Access to life insurance',
        'Access to personal loans',
        'Easy application and exit process',
        'Different and convenient modes of contribution',
        'Benefit payment is made within 72 hours',
        '24/7 online portal',
      ],
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['mvest'.tr, PAppConstant.mvestPensionsUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['mvest'.tr, PAppConstant.mvestPensionsUrl],
      ),
    ),

    Highlight(
      title: 'personal_accident'.tr,
      title2: 'personal_accident'.tr,
      thumbnail: Assets.images.personalAccidentImg.path,
      image: Assets.images.personalAccidentBg.path,
      heading: 'personal_accident'.tr,
      description:
          'This insurance product protects the insured against accidents that may occur both at work and during the course of work.',
      planDescription:
          'Financial protection against accidental injuries and disabilities',
      benefits: [
        'Accidental death',
        'Permanent disability of the insured arising from the accident.',
        'A temporary total disability that makes you lose your source of income.',
        '€3,000 permanent total disability cover',
      ],
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['personal_accident'.tr, PAppConstant.personalAccidentUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['personal_accident'.tr, PAppConstant.personalAccidentQuoteUrl],
      ),
    ),

    Highlight(
      title: 'ekyire_asem'.tr,
      title2: 'digital_funeral'.tr,
      thumbnail: Assets.images.ekyireAsemImg.path,
      image: Assets.images.ekyireAsemBg.path,
      heading: 'ekyire_asem'.tr,
      description:
          'An affordable funeral policy that provides all the necessary logistical services for a one-week funeral celebration.',
      planDescription:
          'Dignified funeral support with fast claims and logistics help',
      benefits: [
        'Claims payment under 24hr',
        'Affordable premiums',
        'One Week Funeral Logistics',
        'Ability to leave a legacy behind',
        'Security for the family and the future',
        'Easy application and exit process',
        'Cash back of 5% of premiums paid',
        'Optional hospital cover for main life',
      ],
      onLearnMoreTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['ekyire_asem'.tr, PAppConstant.ekyireAsemUrl],
      ),
      onQuoteTap: () => PHelperFunction.switchScreen(
        destination: Routes.webviewPage,
        args: ['ekyire_asem'.tr, PAppConstant.ekyireAsemQuoteUrl],
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

  // List<Map<String, dynamic>> recommendations = [
  //   {
  //     'title': 'educator_plan'.tr,
  //     'subTitle': 'An insurance policy structured to enable parents...',
  //     'image': Assets.images.educatorPlanImg.path,
  //   },
  //   {
  //     'title': 'Cover funeral costs.',
  //     'subTitle': 'Give your loved ones a proper send-off without ...',
  //     'image': Assets.images.transitionPlusImg.path,
  //   },
  //   {
  //     'title': 'special_investments_plan'.tr,
  //     'subTitle':
  //         'Become self-sufficient and have more control over your life...',
  //     'image': Assets.images.specialInvestmentImg.path,
  //   },
  //   {
  //     'title': 'personal_accident'.tr,
  //     'subTitle':
  //         'Once an accident has happened, it cannot be reversed, but its impact can be lessened.',
  //     'image': Assets.images.personalAccidentImg.path,
  //   },
  //   {
  //     'title': 'ekyire_asem'.tr,
  //     'subTitle':
  //         'An affordable funeral policy that provides all the necessary logistical services for a one-week funeral celebration, along with a cash benefit to cover additional expenses...',
  //     'image': Assets.images.ekyireAsemImg.path,
  //   },
  // ];
}
