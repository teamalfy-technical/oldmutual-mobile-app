import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';
import 'package:oldmutual_pensions_app/features/contribution.history/presentation/vm/contribution.history.vm.dart';
import 'package:oldmutual_pensions_app/features/future.value.calculator/future.value.calculator.dart';
import 'package:oldmutual_pensions_app/features/home/presentation/vm/home.vm.dart';
import 'package:oldmutual_pensions_app/features/splash/presentation/vm/splash.vm.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PSplashVm());
    Get.lazyPut(() => PSplashVm());
    Get.lazyPut(() => PAuthVm());
    Get.lazyPut(() => PTimerVm());
    Get.lazyPut(() => PHomeVm());
    Get.lazyPut(() => PContributionHistoryVm());
    Get.lazyPut(() => PFutureValueCalcVm());
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
