import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class PMoreServicesPage extends StatelessWidget {
  const PMoreServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text('more_services'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PPageTagWidget(
            tag: 'more_services_tag'.tr,
            textAlign: TextAlign.center,
          ),

          Divider(color: PAppColor.fillColor, height: PAppSize.s6),
          ListTile(
            onTap:
                () => PHelperFunction.switchScreen(
                  destination: Routes.beneficiariesPage,
                ),
            minVerticalPadding: PAppSize.s0,
            title: Text(
              'beneficiaries'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Assets.icons.arrowForwardIos.svg(),
          ),

          Divider(color: PAppColor.fillColor),
          ListTile(
            onTap:
                () => PHelperFunction.switchScreen(
                  destination: Routes.contributionHistoryPage,
                ),
            title: Text(
              'contribution_history'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Assets.icons.arrowForwardIos.svg(),
          ),

          Divider(color: PAppColor.fillColor),
          ListTile(
            onTap:
                () => PHelperFunction.switchScreen(
                  destination: Routes.futureValueCalcPage,
                ),
            title: Text(
              'future_value_calculator'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Assets.icons.arrowForwardIos.svg(),
          ),

          Divider(color: PAppColor.fillColor),
          ListTile(
            onTap:
                () => PHelperFunction.switchScreen(
                  destination: Routes.settingsPage,
                ),
            title: Text(
              'settings'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Assets.icons.arrowForwardIos.svg(),
          ),

          Divider(color: PAppColor.fillColor),
        ],
      ),
    );
  }
}
