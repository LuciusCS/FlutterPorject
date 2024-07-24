
import 'package:get/get.dart';

// import '../networks/api_util.dart';
// import '../repositories/auth_repository.dart';
// import '../repositories/movie_repository.dart';
// import '../repositories/notification_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    // final apiClient = ApiUtil.getApiClient();
    // Get.lazyPut<AuthRepository>(
    //   () => AuthRepositoryImpl(apiClient: apiClient),
    //   tag: (AuthRepository).toString(),
    //   fenix: true,
    // );
    // Get.lazyPut<MovieRepository>(
    //   () => MovieRepositoryImpl(apiClient: apiClient),
    //   fenix: true,
    // );
    // Get.lazyPut<NotificationRepository>(
    //   () => NotificationRepositoryImpl(apiClient: apiClient),
    //   fenix: true,
    // );
  }
}
