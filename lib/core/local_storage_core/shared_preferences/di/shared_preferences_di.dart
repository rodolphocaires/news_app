import 'package:news_app/base/injection/injection.dart';
import 'package:news_app/core/local_storage_core/local_storage_core.dart';

class SharedPreferencesDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    injector.registerFactory<SharedPreferencesClient>(
      () => SharedPreferencesClientImpl(),
    );
  }
}
