import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/products/products.dart';

class PAllProductTab extends StatelessWidget {
  PAllProductTab({super.key});

  final vm = Get.put(PProductVm());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: vm.products.length,
      itemBuilder: (context, index) {
        final product = vm.products[index];
        return ProductWidget(
          product: product,
          width: PDeviceUtil.getDeviceWidth(context),
          margin: EdgeInsets.only(bottom: PAppSize.s20),
        );
      },
    );
  }
}
