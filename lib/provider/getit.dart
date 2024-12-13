import 'package:app_smart_home/service/navigation_service.dart';
import 'package:app_smart_home/view_models/ac_viewmodel.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:app_smart_home/service/api_service.dart';
import 'package:app_smart_home/service/websocket_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  // Đăng ký NavigationService
  getIt.registerLazySingleton(() => NavigationService());

  // Đăng ký ApiService
  getIt.registerLazySingleton(() => ApiService(
    webSocketService: getIt<WebSocketService>(),
  ));

  // Đăng ký WebSocketService
  getIt
      .registerLazySingleton(() => WebSocketService());

  // Đăng ký HomePageViewModel với các dependency
  getIt.registerFactory(() => HomePageViewModel(
        apiService: getIt<ApiService>(),
        webSocketService: getIt<WebSocketService>(),
      ));

  // Đăng ký ACViewModel với ApiService
  getIt.registerFactory(() => ACViewModel(getIt<ApiService>()));
}
