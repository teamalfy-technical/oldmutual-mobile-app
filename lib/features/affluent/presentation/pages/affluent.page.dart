import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PAffluentPage extends StatelessWidget {
  PAffluentPage({super.key});

  final vm = Get.put(PAffluentVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('affluent'.tr)),
      body: Obx(
        () => vm.loading.value == LoadingState.loading
            ? const Center(child: CircularProgressIndicator())
            : const Center(
                child: Text('Affluent Page - Coming Soon'),
              ),
      ),
    );
  }
}
