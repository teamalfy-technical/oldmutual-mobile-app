import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/dashboard/dashboard.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';

class ServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(
      () => AuthServiceImpl(),
      tag: (AuthService).toString(),
    );

    Get.lazyPut<BeneficiaryService>(
      () => BeneficiaryServiceImpl(),
      tag: (BeneficiaryService).toString(),
    );

    Get.lazyPut<ContributionHistoryService>(
      () => ContributionHistoryServiceImpl(),
      tag: (ContributionHistoryService).toString(),
    );

    Get.lazyPut<ProfileService>(
      () => ProfileServiceImpl(),
      tag: (ProfileService).toString(),
    );

    Get.lazyPut<NotificationService>(
      () => NotificationServiceImpl(),
      tag: (NotificationService).toString(),
    );

    Get.lazyPut<DashboardService>(
      () => DashboardServiceImpl(),
      tag: (DashboardService).toString(),
    );

    Get.lazyPut<FactsheetService>(
      () => FactsheetServiceImpl(),
      tag: (FactsheetService).toString(),
    );

    /// [Data Source] injection
    //TDataSourceBindings().dependencies();

    /// [Data Repository] injection
    //TDataRepositoryBindings().dependencies();

    /// [Data Service] injection
    //TDataServiceBindings().dependencies();

    /// [Data Wrapper Functions] injection
    //TWrapperBindings().dependencies();
  }
}
