import 'package:get/get.dart';

class PHomeVm extends GetxController {
  static PHomeVm get instance => Get.find();

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }
}
