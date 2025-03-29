import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/beneficiary/presentation/vm/beneficiary.vm.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/presentation/vm/contribution.history.vm.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/vm/home.vm.dart';
import 'package:oldmutual_pensions_app/features/notification/presentation/vm/notification.vm.dart';
import 'package:oldmutual_pensions_app/features/profile/presentation/vm/profile.vm.dart';
import 'package:oldmutual_pensions_app/features/settings/settings.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PSplashVm());
    Get.lazyPut(() => PSplashVm());
    Get.lazyPut(() => PAuthVm(), fenix: true);
    Get.lazyPut(() => PTimerVm());
    Get.lazyPut(() => PHomeVm());
    Get.lazyPut(() => PBeneficiaryVm());
    Get.lazyPut(() => PContributionHistoryVm());
    Get.lazyPut(() => PFutureValueCalcVm());
    Get.lazyPut(() => PSettingsPage());
    Get.lazyPut(() => PProfileVm());
    Get.lazyPut(() => PNotificationVM());
    // Get.lazyPut(() => TLoginVm());
    // Get.lazyPut(() => TSignupVm());
    // Get.lazyPut(() => TDashboardVm());
    // Get.lazyPut(() => THomeVm(), fenix: true);
    // Get.lazyPut(() => TGymVm());
    // Get.lazyPut(() => TPostVm(), fenix: true);
    // Get.lazyPut(() => TSearchVm());
    // Get.lazyPut(() => TChatVm());
    // Get.lazyPut(() => TProfileVm());
    // Get.lazyPut(() => TBlockedUserVm());
    // Get.lazyPut(() => TSettingsVm());
    // Get.lazyPut(() => TNotificationVm());

    // /// [DataSource] injection
    // DataSourceBinding().dependencies();

    // /// [Repository] injection
    // RepoBinding().dependencies();

    // /// [Service] injection
    // ServiceBinding().dependencies();

    // // [Data Wrapper Functions] injection
    // WrapperFxnBinding().dependencies();
  }
}
