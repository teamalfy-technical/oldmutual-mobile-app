import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/home/domain/highlight.model.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class PHomeVm extends GetxController {
  static PHomeVm get instance => Get.find();

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  List<Highlight> highlights = [
    Highlight(
      title: 'new_feature_in_store'.tr,
      image: Assets.images.featuresImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'travel_insurance_text'.tr,
      image: Assets.images.travelInsuranceImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'retirement_savings'.tr,
      image: Assets.images.retirementImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'education_plan'.tr,
      image: Assets.images.educationPlanImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'investment_plan'.tr,
      image: Assets.images.specialInvestmentImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'transition_plus_plan'.tr,
      image: Assets.images.transitionPlusImg.path,
      onTap: () {},
    ),
    Highlight(
      title: 'forgot_login_details'.tr,
      image: Assets.images.forgotDetailsImg.path,
      onTap: () {},
    ),
  ];
}
