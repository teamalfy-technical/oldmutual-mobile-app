import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PContributionHistoryVm extends GetxController {
  static PContributionHistoryVm get instance => Get.find();

  final List<Map<String, dynamic>> histories = [
    {
      'title': 'Contribution received',
      'amount': 200,
      'date': DateTime.now().subtract(Duration(days: 3)).toIso8601String(),
      'status': true,
    },
    {
      'title': 'Contribution received',
      'amount': 400,
      'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
      'status': true,
    },
    {
      'title': 'Contribution received',
      'amount': 300,
      'date': DateTime.now().subtract(Duration(days: 8)).toIso8601String(),
      'status': false,
    },
    {
      'title': 'Contribution received',
      'amount': 500,
      'date': DateTime.now().subtract(Duration(days: 10)).toIso8601String(),
      'status': true,
    },
  ];

  final yearTEC = TextEditingController();

  var all = false.obs;

  onAllChanged(bool? value) => all.value = value ?? false;
}
