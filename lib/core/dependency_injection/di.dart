import 'package:get_it/get_it.dart';
import 'package:notification_app/core/data/config/http_client.dart';
import 'package:notification_app/core/domain/notifier_repository.dart';
import 'package:notification_app/core/repositories/notifier_repository_impl.dart';

final GetIt locator = GetIt.instance;

class AppDependencies {
  static void registerDependencies() {
    locator.registerLazySingleton<HttpClient>(
      () => HttpClientImpl(),
    );
    locator.registerLazySingleton<NotifierRepository>(
      () => NotifierRepositoryImpl(locator()),
    );
  }
}
