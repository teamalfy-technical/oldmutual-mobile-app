import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/shared/widgets/custom.listtile.dart';

class PProfilePage extends StatelessWidget {
  const PProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox.shrink(), title: Text('profile'.tr)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PAppSize.s16.verticalSpace,
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(PAppSize.s30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PAppColor.blackColor,
                ),
                child: Assets.icons.userProfileIcon.svg(),
              ),
              Positioned(
                right: PAppSize.s10,
                bottom: 0,
                child: Assets.icons.addIcon.svg().onPressed(onTap: () {}),
              ),
            ],
          ).centered(),
          PAppSize.s28.verticalSpace,
          Divider(color: PAppColor.fillColor),
          PCustomListTile(
            title: 'membership_id'.tr,
            subtitle: '**********************',
          ),

          Divider(color: PAppColor.fillColor),
          PCustomListTile(
            title: 'ghana_card_id'.tr,
            subtitle: '*********************',
          ),

          Divider(color: PAppColor.fillColor),
          PCustomListTile(
            title: 'ssnit_number'.tr,
            subtitle: '*********************',
          ),

          Divider(color: PAppColor.fillColor),
          PCustomListTile(
            title: 'date_of_number'.tr,
            subtitle: '*********************',
          ),

          Divider(color: PAppColor.fillColor),
        ],
      ),
    );
  }
}
