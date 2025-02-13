import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/base/injection/injection.dart';
import 'package:news_app/core/background_worker_core/background_worker_core.dart';
import 'package:news_app/core/local_storage_core/shared_preferences/shared_preferences.dart';
import 'package:news_app/core/network_core/network_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockHttpNetworkClient extends Mock implements HttpNetwork {}

class MockSharedPreferencesClient extends Mock
    implements SharedPreferencesClient {}

class MockBackgroundWorker extends Mock implements BackgroundWorkerClient {}

void main() {
  late MockHttpNetworkClient mockHttpNetworkClient;
  late MockSharedPreferencesClient mockSharedPreferencesClient;
  late MockBackgroundWorker mockBackgroundWorker;

  setUpAll(() async {
    mockHttpNetworkClient = MockHttpNetworkClient();
    mockSharedPreferencesClient = MockSharedPreferencesClient();
    mockBackgroundWorker = MockBackgroundWorker();

    Injector.I.registerFactory<HttpNetwork>(() => mockHttpNetworkClient);
    Injector.I.registerFactory<SharedPreferencesClient>(
      () => mockSharedPreferencesClient,
    );
    Injector.I.registerFactory<BackgroundWorkerClient>(
      () => mockBackgroundWorker,
    );
  });

  test('Should test inject ArticlesFeatureDI was successful', () async {
    ArticlesFeatureDI().registerDependencies(injector: Injector.I);

    // Datasources
    expect(
      Injector.I.get<ArticlesRemoteDatasource>().runtimeType,
      ArticlesRemoteDatasourceImpl,
    );
    expect(
      Injector.I.get<ArticlesLocalDatasource>().runtimeType,
      ArticlesLocalDatasourceImpl,
    );

    // Repositories
    expect(
      Injector.I.get<ArticlesRepository>().runtimeType,
      ArticlesRepositoryImpl,
    );

    // Use cases
    expect(
      Injector.I.get<GetTopHeadlines>().runtimeType,
      GetTopHeadlinesImpl,
    );
    expect(
      Injector.I.get<GetHeadlinesGroupedBySource>().runtimeType,
      GetHeadlinesGroupedBySourceImpl,
    );
    expect(
      Injector.I.get<StartBackgroundFetch>().runtimeType,
      StartBackgroundFetchImpl,
    );
    expect(
      Injector.I.get<GetFavoriteArticles>().runtimeType,
      GetFavoriteArticlesImpl,
    );
    expect(
      Injector.I.get<AddFavoriteArticles>().runtimeType,
      AddFavoriteArticlesImpl,
    );
    expect(
      Injector.I.get<DeleteFromFavoriteArticles>().runtimeType,
      DeleteFromFavoriteArticlesImpl,
    );

    // State management
    expect(
      Injector.I.get<TopArticlesStream>().runtimeType,
      TopArticlesStream,
    );
    expect(
      Injector.I.get<FavoriteArticlesStream>().runtimeType,
      FavoriteArticlesStream,
    );
  });
}
