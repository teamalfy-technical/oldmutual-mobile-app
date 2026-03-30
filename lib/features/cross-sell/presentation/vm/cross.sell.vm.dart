import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/application/services/cross.sell.service.impl.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

/// ViewModel for managing cross-sell product recommendations
class PCrossSellVm extends GetxController {
  static PCrossSellVm get instance => Get.find();

  /// Observable list of recommendation items with title, subtitle, and image
  var recommendations = <Highlight>[].obs;

  /// Loading state to track fetch and apply operations
  var loading = LoadingState.completed.obs;

  final context = Get.context!;

  /// Update the current loading state
  updateLoadingState(LoadingState loadingState) => loading.value = loadingState;

  @override
  void onInit() {
    fetchRecommendations();
    super.onInit();
  }

  /// Fetch recommendations from the API and map them to detailed objects
  /// This retrieves a list of recommendation strings from the backend and
  /// transforms them into full objects with titles, subtitles, and images
  Future<void> fetchRecommendations() async {
    updateLoadingState(LoadingState.loading);
    final result = await crossSellService.getRecommendations();
    result.fold(
      (err) {
        // Handle error case - show error dialog
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        // Handle success case - map API response strings to detailed recommendation objects
        updateLoadingState(LoadingState.completed);
        // recommendations.value =
        //     [
        //           'Educator Plan',
        //           'Transition Plus Plan',
        //           'Special Investment Plan',
        //           'Travel Insurance',
        //           'Digital Funeral',
        //         ]
        //         .map((recommendation) => getRecommendationTitle(recommendation))
        //         .toList();
        recommendations.value =
            res.data
                ?.map(
                  (recommendation) => getRecommendationTitle(recommendation),
                )
                .toList() ??
            [];
      },
    );
  }

  /// Apply for a specific recommendation product
  /// [recommendation] - The name/title of the product to apply for
  Future<void> applyRecommendations(String recommendation) async {
    updateLoadingState(LoadingState.loading);
    final result = await crossSellService.applyForRecommendation(
      recommendation: recommendation,
    );
    result.fold(
      (err) {
        // Handle error case - show error dialog
        updateLoadingState(LoadingState.error);
        PPopupDialog(
          context,
        ).errorMessage(title: err.title ?? 'error'.tr, message: err.message);
      },
      (res) async {
        // Handle success case - TODO: navigate to success view
        updateLoadingState(LoadingState.completed);
        // navigate to success view
      },
    );
  }

  /// Map recommendation title to full details (title, subtitle, image)
  /// Returns a map containing localized title, description, and asset path
  /// [recommendation] - The product name from the API
  Highlight getRecommendationTitle(String recommendation) {
    switch (recommendation) {
      case 'Travel Insurance':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
            args: [
              'international_travel'.tr,
              PAppConstant.travelInsuranceQuoteUrl,
            ],
          ),
        );
      // Education savings plan for children
      case 'Educator Plan':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
        );
      // Funeral cost coverage plan
      case 'Mvest':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
        );
      case 'Transition Plus Plan':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
        );
      // Investment and savings plan
      case 'Special Investment Plan':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
        );

      // Accident coverage insurance
      case 'Personal Accident':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
          onQuoteTap: () {},
        );

      // Digital funeral services plan (Ekyire Asem)
      case 'Digital Funeral':
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
          onQuoteTap: () {},
        );

      // Fallback for unknown recommendation types
      default:
        return Highlight(
          title: recommendation,
          title2: recommendation,
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
            args: [
              'international_travel'.tr,
              PAppConstant.travelInsuranceQuoteUrl,
            ],
          ),
        );
    }
  }

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
