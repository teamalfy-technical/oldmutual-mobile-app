import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';

class PUserDetailPage extends StatelessWidget {
  final bool isShowAppBar;
  const PUserDetailPage({super.key, this.isShowAppBar = true});

  Widget _buildListTile(BuildContext context, String title, String subTitle) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: PAppSize.s0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: PAppSize.s14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    final authResponse = await PSecureStorage().getAuthResponse();
    final bioData = await PSecureStorage().getBioData();

    final fullName =
        (authResponse?.name == null ||
            (authResponse?.name != null && authResponse!.name!.isEmpty))
        ? bioData?.fullName
        : authResponse?.name;

    return {
      'fullName': fullName,
      'email': authResponse?.email,
      'phone': authResponse?.phone,
      'ghanaCardNumber': bioData?.ghanaCardNumber,
      'ssnitNumber': bioData?.ssnitNumber,
      'dob': authResponse?.dob,
      'tin': bioData?.tin,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: isShowAppBar
          ? AppBar(title: Text('manage_personal_details'.tr))
          : null,
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data ?? {};

          return SafeArea(
            child: Column(
              children: [
                // Personal Details
                Container(
                  padding: EdgeInsets.all(PAppSize.s16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                    border: Border.all(
                      width: PAppSize.s1,
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.transparentColor
                          : PAppColor.fillColor2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['fullName'] ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      PAppSize.s8.verticalSpace,
                      PMoreListTitle(
                        title: 'email'.tr,
                        subTitle: userData['email'] ?? 'not_applicable'.tr,
                      ),
                      Divider(height: PAppSize.s1),
                      PMoreListTitle(
                        title: 'phone_number'.tr,
                        subTitle: userData['phone'] ?? 'not_applicable'.tr,
                      ),
                      Divider(height: PAppSize.s1),
                      PMoreListTitle(
                        title: 'ghana_card_id'.tr,
                        subTitle:
                            userData['ghanaCardNumber'] ?? 'not_applicable'.tr,
                      ),
                      Divider(height: PAppSize.s1),
                      PMoreListTitle(
                        title: 'ssnit_number'.tr,
                        subTitle:
                            userData['ssnitNumber'] ?? 'not_applicable'.tr,
                      ),
                      Divider(height: PAppSize.s1),
                      PMoreListTitle(
                        title: 'date_of_birth'.tr,
                        subTitle: PFormatter.formatDate(
                          dateFormat: DateFormat('MMMM d, y'),
                          date: DateTime.parse(
                            userData['dob'] ?? DateTime.now().toIso8601String(),
                          ),
                        ),
                      ),
                      Divider(height: PAppSize.s1),
                      PMoreListTitle(
                        title: 'tin'.tr.toUpperCase(),
                        subTitle: userData['tin'] ?? 'not_applicable'.tr,
                      ),
                      Divider(height: PAppSize.s1),
                    ],
                  ),
                ),

                PAppSize.s16.verticalSpace,

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'danger_zone'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: PAppSize.s14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                PAppSize.s12.verticalSpace,

                // Danger zone / Logout section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PAppSize.s20),
                    color: PHelperFunction.isDarkMode(context)
                        ? PAppColor.darkAppBarColor
                        : PAppColor.whiteColor,
                    border: Border.all(
                      width: PAppSize.s1,
                      color: PHelperFunction.isDarkMode(context)
                          ? PAppColor.transparentColor
                          : PAppColor.fillColor2,
                    ),
                  ),
                  child:
                      ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: PAppSize.s0,
                              vertical: 0,
                            ),
                            leading: CircleAvatar(
                              radius: PAppSize.s22,
                              backgroundColor: PAppColor.redColor
                                  .withOpacityExt(PAppSize.s0_1),
                              child: Assets.icons.trashRedIcon.svg(),
                            ),
                            title: Text(
                              'delete_account'.tr,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontSize: PAppSize.s14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            // onTap: () => PHelperFunction.switchScreen(
                            //   destination: Routes.deleteAccountPageOne,
                            // ),
                            trailing: Assets.icons.arrowForwardIos.svg(
                              color: PHelperFunction.isDarkMode(context)
                                  ? PAppColor.whiteColor
                                  : PAppColor.darkAppBarColor,
                            ),
                          )
                          .symmetric(
                            horizontal: PAppSize.s16,
                            vertical: PAppSize.s8,
                          )
                          .onPressed(
                            onTap: () => PHelperFunction.switchScreen(
                              destination: Routes.deleteAccountPageOne,
                            ),
                            radius: BorderRadius.circular(PAppSize.s20),
                          ),
                ),
              ],
            ).all(PAppSize.s20),
          );
        },
      ),
    );
  }
}
