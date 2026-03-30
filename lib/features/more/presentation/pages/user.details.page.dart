import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';
import 'package:oldmutual_pensions_app/features/more/more.services.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/gen/assets.gen.dart';
import 'package:oldmutual_pensions_app/routes/app.pages.dart';
import 'package:oldmutual_pensions_app/shared/shared.dart';

class UserDetailsData {
  final Map<String, String?> biodata;
  final Map<String, String?> profile;
  final bool hasPensionScheme;

  UserDetailsData({
    required this.biodata,
    required this.profile,
    required this.hasPensionScheme,
  });
}

class PUserDetailPage extends StatefulWidget {
  final bool isShowAppBar;
  const PUserDetailPage({super.key, this.isShowAppBar = true});

  @override
  State<PUserDetailPage> createState() => _PUserDetailPageState();
}

class _PUserDetailPageState extends State<PUserDetailPage> {
  bool _isLoading = true;
  UserDetailsData? _userDetailsData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => await _loadUserData(),
    );
  }

  Future<void> _loadUserData() async {
    final authResponse = await PSecureStorage().getAuthResponse();
    var bioData = await PSecureStorage().getBioData();

    // Fetch schemes to determine if user has pension schemes
    if (bioData == null) {
      final pensionVm = Get.put(PPensionVm());
      await pensionVm.fetchSchemesOnFirstLoad();

      final hasPensionSchemes = pensionVm.activeSchemes.isNotEmpty;

      // Auto-select the first active scheme if none is selected yet
      if (hasPensionSchemes &&
          pensionVm.selectedScheme.value.memberNumber == null) {
        await pensionVm.getMemberSelectedScheme(
          scheme: pensionVm.activeSchemes.first,
          fetchBioOnly: true,
        );
      }

      // Re-read bioData after scheme selection completes
      // getMemberSelectedScheme calls getBioData() internally
      bioData = await PSecureStorage().getBioData();
    }

    final biodata = {
      'fullName': bioData?.fullName ?? 'not_applicable'.tr,
      'email': bioData?.email ?? 'not_applicable'.tr,
      'phone': bioData?.mobileNo ?? 'not_applicable'.tr,
      'ghanaCardNumber': bioData?.ghanaCardNumber ?? 'not_applicable'.tr,
      'ssnitNumber': bioData?.ssnitNumber ?? 'not_applicable'.tr,
      'dob': bioData?.dob,
      'tin': bioData?.tin,
      'memberNo': bioData?.memberNo ?? 'not_applicable'.tr,
      'monthlyContribution': bioData?.monthlyContribution != null
          ? PFormatter.formatCurrency(amount: bioData!.monthlyContribution!)
          : 'not_applicable'.tr,
      'employerName': bioData?.employerName ?? 'not_applicable'.tr,
      'employerNumber': bioData?.employerNumber ?? 'not_applicable'.tr,
      'pensionTypeName': bioData?.pensionTypeName ?? 'not_applicable'.tr,
      'schemeName': bioData?.schemeName ?? 'not_applicable'.tr,
    };

    final profile = {
      'fullName': authResponse?.name ?? 'not_applicable'.tr,
      'email': authResponse?.email ?? 'not_applicable'.tr,
      'phone': authResponse?.phone ?? 'not_applicable'.tr,
      'ghanaCardNumber': authResponse?.ghanaCardNumber ?? 'not_applicable'.tr,
      'ssnitNumber': authResponse?.ssnitNumber ?? 'not_applicable'.tr,
      'dob': authResponse?.dob,
    };

    pensionAppLogger.d('Biodata: ${bioData?.toJson()}');

    if (!mounted) return;

    setState(() {
      _userDetailsData = UserDetailsData(
        biodata: biodata,
        profile: profile,
        hasPensionScheme: bioData != null,
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHelperFunction.isDarkMode(context)
          ? PAppColor.darkBgColor
          : PAppColor.fillColor,
      appBar: widget.isShowAppBar
          ? AppBar(title: Text('manage_personal_details'.tr))
          : null,
      body: SafeArea(
        child: Column(
          children: [
            PAppSize.s16.verticalSpace,
            Expanded(
              child: PProfileTab(
                userData: _isLoading
                    ? const {}
                    : _userDetailsData?.profile ?? {},
                isLoading: _isLoading,
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

            // Danger zone
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
                          backgroundColor: PAppColor.redColor.withOpacityExt(
                            PAppSize.s0_1,
                          ),
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
      ),
    );
  }
}
