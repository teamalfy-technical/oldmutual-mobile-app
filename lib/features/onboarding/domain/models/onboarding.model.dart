import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';

class POnboardingModel {
  final String image;
  final String title;
  final String description;

  POnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final slides = [
  POnboardingModel(
    image: Assets.images.slideOne.path,
    title: 'slide_one_title'.tr,
    description: 'slide_one_desc'.tr,
  ),
  POnboardingModel(
    image: Assets.images.slideTwo.path,
    title: 'slide_two_title'.tr,
    description: 'slide_two_desc'.tr,
  ),
  POnboardingModel(
    image: Assets.images.slideThree.path,
    title: 'slide_three_title'.tr,
    description: 'slide_three_desc'.tr,
  ),
  POnboardingModel(
    image: Assets.images.slideFour.path,
    title: 'slide_four_title'.tr,
    description: 'slide_four_desc'.tr,
  ),
];
