import 'package:get/get.dart';

class PProductVm extends GetxController {
  static PProductVm get instance => Get.find();

  var currentIndex = 0.obs;

  onPageChanged(int val) {
    currentIndex.value = val;
  }

  List<Map<String, dynamic>> products = [
    {
      'name': 'Retail',
      'type': 'retail',
      'num_of_account': 2,
      'contribution': 10000.00,
    },
    {
      'name': 'Pension',
      'type': 'pension',
      'num_of_account': 1,
      'contribution': 25000.00,
    },
    {
      'name': 'Corporate',
      'type': 'Corporate',
      'num_of_account': 2,
      'contribution': 25000.00,
    },
    {
      'name': 'Solutions for you',
      'type': 'Corporate',
      'num_of_account': 0,
      'contribution': 25000.00,
    },
  ];
}
