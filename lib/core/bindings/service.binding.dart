import 'package:get/get.dart';

class ServiceBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthService>(
    //   () => AuthServiceImpl(),
    //   tag: (AuthService).toString(),
    // );

    // Get.lazyPut<ProfileService>(
    //   () => ProfileServiceImpl(),
    //   tag: (ProfileService).toString(),
    // );

    // Get.lazyPut<PostService>(
    //   () => PostServiceImpl(),
    //   tag: (PostService).toString(),
    // );

    // Get.lazyPut<SearchService>(
    //   () => SearchServiceImpl(),
    //   tag: (SearchService).toString(),
    // );

    // Get.lazyPut<NotificationService>(
    //   () => NotificationServiceImpl(),
    //   tag: (NotificationService).toString(),
    // );

    // Get.lazyPut<ChatService>(
    //   () => ChatServiceImpl(),
    //   tag: (ChatService).toString(),
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
