import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/affluent/affluent.dart';

class PTrackClaimsPage extends StatelessWidget {
  const PTrackClaimsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = PAffluentVm.instance;
    final isDarkMode = PHelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? PAppColor.darkBgColor : PAppColor.fillColor,
      appBar: AppBar(title: Text('track_claims_text'.tr)),
      body: PClaimTrackingList(
        claims: vm.claims,
        padding: EdgeInsets.all(PAppSize.s20),
      ),
    );
  }
}
