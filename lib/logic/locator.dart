import 'package:get_it/get_it.dart';
import 'map_provider.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Регистрируем наш провайдер как Singleton (один экземпляр на все приложение)
  locator.registerLazySingleton(() => MapProvider());
}