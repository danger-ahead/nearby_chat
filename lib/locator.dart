import 'package:get_it/get_it.dart';
import 'package:nearby_chat/services/dialog_service.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/services/snackbar_service.dart';
import 'package:nearby_chat/services/log_service.dart';
import 'package:nearby_chat/viewmodels/chat_bubble_viewmodel.dart';
import 'package:nearby_chat/viewmodels/client_viewmodel.dart';
import 'package:nearby_chat/viewmodels/home_viewmodel.dart';
import 'package:nearby_chat/viewmodels/main_viewmodel.dart';
import 'package:nearby_chat/viewmodels/server_viewmodel.dart';
import 'package:nearby_chat/viewmodels/settings_viewmodel.dart';
import 'package:network_info_plus/network_info_plus.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton<Log>(() => Log());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  locator.registerFactory(() => MainViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => ClientViewModel());
  locator.registerFactory(() => ServerViewModel());
  locator.registerFactory(() => SettingsViewModel());
  locator.registerFactory(() => ChatBubbleViewModel());
}
