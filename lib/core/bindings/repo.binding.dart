import 'package:get/get.dart';
import 'package:oldmutual_pensions_app/features/auth/auth.dart';

class RepoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(), tag: (AuthRepo).toString());

    // Get.lazyPut<ProfileRepo>(
    //   () => ProfileRepoImpl(),
    //   tag: (ProfileRepo).toString(),
    // );

    // Get.lazyPut<PostRepo>(
    //   () => PostRepoImpl(),
    //   tag: (PostRepo).toString(),
    // );

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
