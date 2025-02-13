import 'package:news_app/base/injection/injection.dart';
import 'package:news_app/core/background_worker_core/background_worker_core.dart';

class BackgroundWorkerDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    injector.registerSingleton<BackgroundWorkerClient>(
        BackgroundWorkerClientImpl());
  }
}
