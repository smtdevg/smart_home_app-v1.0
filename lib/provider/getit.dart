import 'package:app_smart_home/service/navigation_service.dart';
import 'package:app_smart_home/view_models/ac_viewmodel.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => HomePageViewModel());
  getIt.registerFactory(() => ACViewModel());
}
