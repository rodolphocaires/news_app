import 'package:dio/dio.dart';
import 'package:news_app/base/injection/injection.dart';
import 'package:news_app/core/network_core/network_core.dart';

class HttpDI implements RegisterInjectionClient {
  @override
  void registerDependencies({required InjectionClient injector}) {
    injector.registerFactory<HttpNetwork>(
      () => HttpNetworkImpl(client: Dio(), httpInterceptor: injector.get()),
    );
    injector.registerFactory<HttpInterceptor>(
      () => HttpInterceptor(),
    );
  }
}
