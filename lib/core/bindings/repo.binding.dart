import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/beneficiary.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/contribution.history.dart';
import 'package:oldmutual_pensions_app/features/cross-sell/cross.sell.dart';
import 'package:oldmutual_pensions_app/features/factsheet/factsheet.dart';
import 'package:oldmutual_pensions_app/features/home/home.dart';
import 'package:oldmutual_pensions_app/features/notification/notification.dart';
import 'package:oldmutual_pensions_app/features/pension/pension.dart';
import 'package:oldmutual_pensions_app/features/policy/policy.dart';
import 'package:oldmutual_pensions_app/features/profile/profile.dart';
import 'package:oldmutual_pensions_app/features/redemptions/redemption.dart';
import 'package:oldmutual_pensions_app/features/statements/statements.dart';
import 'package:oldmutual_pensions_app/features/up-sell/up.sell.dart';

class RepoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(), tag: (AuthRepo).toString());

    Get.lazyPut<BeneficiaryRepo>(
      () => BeneficiaryRepoImpl(),
      tag: (BeneficiaryRepo).toString(),
    );

    Get.lazyPut<ContributionHistoryRepo>(
      () => ContributionHistoryRepoImpl(),
      tag: (ContributionHistoryRepo).toString(),
    );

    Get.lazyPut<ProfileRepo>(
      () => ProfileRepoImpl(),
      tag: (ProfileRepo).toString(),
    );

    Get.lazyPut<NotificationRepo>(
      () => NotificationRepoImpl(),
      tag: (NotificationRepo).toString(),
    );

    Get.lazyPut<DashboardRepo>(
      () => DashboardRepoImpl(),
      tag: (DashboardRepo).toString(),
    );

    Get.lazyPut<PensionRepo>(
      () => PensionRepoImpl(),
      tag: (PensionRepo).toString(),
    );

    Get.lazyPut<PolicyRepo>(
      () => PolicyRepoImpl(),
      tag: (PolicyRepo).toString(),
    );

    Get.lazyPut<UpsellRepo>(
      () => UpsellRepoImpl(),
      tag: (UpsellRepo).toString(),
    );
    Get.lazyPut<CrossSellRepo>(
      () => CrossSellRepoImpl(),
      tag: (CrossSellRepo).toString(),
    );

    Get.lazyPut<FactsheetRepo>(
      () => FactsheetRepoImpl(),
      tag: (FactsheetRepo).toString(),
    );

    Get.lazyPut<StatementRepo>(
      () => StatementRepoImpl(),
      tag: (StatementRepo).toString(),
    );

    Get.lazyPut<RedemptionRepo>(
      () => RedemptionRepoImpl(),
      tag: (RedemptionRepo).toString(),
    );

    // Get.lazyPut<SearchRepo>(
    //   () => SearchRepoImpl(),
    //   tag: (SearchRepo).toString(),
    // );

    // Get.lazyPut<NotificationRepo>(
    //   () => NotificationRepoImpl(),
    //   tag: (NotificationRepo).toString(),
    // );

    // Get.lazyPut<ChatRepo>(
    //   () => ChatRepoImpl(),
    //   tag: (ChatRepo).toString(),
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
