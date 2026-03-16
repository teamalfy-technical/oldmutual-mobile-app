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

class _PUserDetailPageState extends State<PUserDetailPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late Future<UserDetailsData> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _loadUserData();
  }

  void _initTabController(int length) {
    if (_tabController?.length == length) return;
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<UserDetailsData> _loadUserData() async {
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
        );
      }

      // Biodata is populated after a scheme is selected via getBioData()
      bioData = await PSecureStorage().getBioData();
    }

    pensionAppLogger.e(bioData?.toJson());

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

    return UserDetailsData(
      biodata: biodata,
      profile: profile,
      hasPensionScheme: bioData != null,
    );
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
      body: FutureBuilder<UserDetailsData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          final isLoading = snapshot.connectionState == ConnectionState.waiting;
          final userDetailsData = snapshot.data;
          final hasPension = userDetailsData?.hasPensionScheme ?? false;
          final tabCount = hasPension ? 2 : 1;

          // Initialize or update tab controller based on pension scheme availability
          if (!isLoading) {
            _initTabController(tabCount);
          }

          // Show loading state while data is being fetched
          if (_tabController == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Column(
              children: [
                if (hasPension) ...[
                  PCustomTabBarWidget(
                    controller: _tabController!,
                    horizontalPadding: PAppSize.s0,
                    tabs: [
                      Tab(text: 'biodata'.tr),
                      Tab(text: 'profile'.tr),
                    ],
                  ),
                ],

                PAppSize.s16.verticalSpace,
                Expanded(
                  child: TabBarView(
                    controller: _tabController!,
                    children: [
                      if (hasPension)
                        PBiodataTab(
                          userData: userDetailsData?.biodata ?? {},
                          isLoading: isLoading,
                        ),
                      PProfileTab(
                        userData: userDetailsData?.profile ?? {},
                        isLoading: isLoading,
                      ),
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
