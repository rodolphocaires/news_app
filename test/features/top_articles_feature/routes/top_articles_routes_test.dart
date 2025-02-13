import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/base/injection/injection.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:provider/provider.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockStartBackgroundFetch extends Mock implements StartBackgroundFetch {}

class MockTopArticlesStream extends Mock implements TopArticlesStream {}

class MockGetHeadlinesGroupedBySource extends Mock
    implements GetHeadlinesGroupedBySource {}

class MockGetFavoriteArticles extends Mock implements GetFavoriteArticles {}

class MockFavoriteArticlesStream extends Mock
    implements FavoriteArticlesStream {}

class MockAddFavoriteArticles extends Mock implements AddFavoriteArticles {}

class MockDeleteFromFavoriteArticles extends Mock
    implements DeleteFromFavoriteArticles {}

void main() {
  late TopArticleRouter router;
  late MockBuildContext mockBuildContext;
  late MockStartBackgroundFetch mockStartBackgroundFetch;
  late MockTopArticlesStream mockTopArticlesStream;
  late MockGetHeadlinesGroupedBySource mockGetHeadlinesGroupedBySource;
  late MockGetFavoriteArticles mockGetFavoriteArticles;
  late MockFavoriteArticlesStream mockFavoriteArticlesStream;
  late MockAddFavoriteArticles mockAddFavoriteArticles;
  late MockDeleteFromFavoriteArticles mockDeleteFromFavoriteArticles;

  Injector.I
      .registerFactory<StartBackgroundFetch>(() => mockStartBackgroundFetch);
  Injector.I.registerFactory<TopArticlesStream>(() => mockTopArticlesStream);
  Injector.I.registerFactory<GetHeadlinesGroupedBySource>(
      () => mockGetHeadlinesGroupedBySource);
  Injector.I
      .registerFactory<GetFavoriteArticles>(() => mockGetFavoriteArticles);
  Injector.I.registerFactory<FavoriteArticlesStream>(
      () => mockFavoriteArticlesStream);
  Injector.I
      .registerFactory<AddFavoriteArticles>(() => mockAddFavoriteArticles);
  Injector.I.registerFactory<DeleteFromFavoriteArticles>(
      () => mockDeleteFromFavoriteArticles);

  setUpAll(() {
    mockBuildContext = MockBuildContext();
    mockStartBackgroundFetch = MockStartBackgroundFetch();
    mockTopArticlesStream = MockTopArticlesStream();
    mockGetHeadlinesGroupedBySource = MockGetHeadlinesGroupedBySource();
    mockGetFavoriteArticles = MockGetFavoriteArticles();
    mockFavoriteArticlesStream = MockFavoriteArticlesStream();
    mockAddFavoriteArticles = MockAddFavoriteArticles();
    mockDeleteFromFavoriteArticles = MockDeleteFromFavoriteArticles();
    router = TopArticleRouter();
  });

  group('getRoutes', () {
    test('should return a page typed TopArticlesState', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(),
      )[TopArticleRoutes.topArticles];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<ChangeNotifierProvider<TopArticlesState>>(),
      );
    });
    test('should return a page typed ArticleDetailsPage', () {
      const entity = ArticleEntity();
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(arguments: entity),
      )[TopArticleRoutes.articlesDetails];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<ArticleDetailsPage>(),
      );
    });
    test('should return a page typed FavoriteArticlesPage', () {
      final MaterialPageRoute<dynamic> feature = router.getRoutes(
        const RouteSettings(),
      )[TopArticleRoutes.favoriteArticles];
      final call = feature.builder;
      expect(
        call(mockBuildContext),
        isA<FavoriteArticlesPage>(),
      );
    });
  });
}
