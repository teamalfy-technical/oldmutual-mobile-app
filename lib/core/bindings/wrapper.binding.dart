import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/core/network/network.dart';

class WrapperFxnBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NetworkInfo>(
    //   () => NetworkInfoImpl(InternetConnectionChecker()),
    //   tag: (NetworkInfo).toString(),
    //   fenix: true,
    // );
    Get.lazyPut<CatchApiErrorWrapper>(
      () => CatchApiErrorWrapperImpl(),
      tag: (CatchApiErrorWrapper).toString(),
    );
    Get.lazyPut<AsyncFunctionWrapper>(
      () => AsyncFunctionWrapperImpl(),
      tag: (AsyncFunctionWrapper).toString(),
    );

    Get.lazyPut<CustomRepositoryWrapper>(
      () => CustomRepositoryWrapperImpl(),
      tag: (CustomRepositoryWrapper).toString(),
    );
  }
}
