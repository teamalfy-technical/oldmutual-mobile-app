import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';

class DataSourceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthDs>(() => AuthDsImpl(), tag: (AuthDs).toString());

    Get.lazyPut<BeneficiaryDs>(
      () => BeneficiaryDsImpl(),
      tag: (BeneficiaryDs).toString(),
    );

    Get.lazyPut<ContributionHistoryDs>(
      () => ContributionHistoryDsImpl(),
      tag: (ContributionHistoryDs).toString(),
    );

    Get.lazyPut<ProfileDs>(() => ProfileDsImpl(), tag: (ProfileDs).toString());

    Get.lazyPut<NotificationDs>(
      () => NotificationDsImpl(),
      tag: (NotificationDs).toString(),
    );

    Get.lazyPut<DashboardDs>(
      () => DashboardDsImpl(),
      tag: (DashboardDs).toString(),
    );

    Get.lazyPut<FactsheetDs>(
      () => FactsheetDsImpl(),
      tag: (FactsheetDs).toString(),
    );

    Get.lazyPut<StatementDs>(
      () => StatementDsImpl(),
      tag: (StatementDs).toString(),
    );

    // Get.lazyPut<SearchDs>(
    //   () => SearchDsImpl(),
    //   tag: (SearchDs).toString(),
    // );

    // Get.lazyPut<NotificationDs>(
    //   () => NotificationDsImpl(),
    //   tag: (NotificationDs).toString(),
    // );

    // Get.lazyPut<ChatDs>(
    //   () => ChatDsImpl(),
    //   tag: (ChatDs).toString(),
    // );

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
