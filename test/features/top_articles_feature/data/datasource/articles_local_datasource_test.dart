import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/local_storage_core/local_storage_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockLocalStorage extends Mock implements SharedPreferencesClient {}

void main() {
  late ArticlesLocalDatasourceImpl dataSource;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = ArticlesLocalDatasourceImpl(mockLocalStorage);
  });

  const favoriteArticlesKey = 'favoriteArticles';

  const mockModel = ArticleModel(
    title: 'title',
    description: 'description',
    url: 'url',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
    author: 'author',
    sourceId: 'sourceId',
    sourceName: 'sourceName',
  );

  final mockJson = json.encode([mockModel.toMap()]);

  group('getFavoriteArticles', () {
    test('should return a list of ArticleModel when local storage has data',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => mockJson,
      );
      final result = await dataSource.getFavoriteArticles();
      expect(result, [mockModel]);
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
    });

    test('should return an empty list when local storage has no data',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => null,
      );
      final result = await dataSource.getFavoriteArticles();
      expect(result, []);
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
    });
  });

  group('addFavoriteArticles', () {
    test('should return a list of ArticleModel when info is added successfully',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => null,
      );
      when(() => mockLocalStorage.setString(favoriteArticlesKey, mockJson))
          .thenAnswer(
        (_) async => true,
      );
      final result = await dataSource.addFavoriteArticles(mockModel);
      expect(result, [mockModel]);
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
      verify(() => mockLocalStorage.setString(favoriteArticlesKey, mockJson))
          .called(1);
    });

    test('should return an exception when info is not added successfully',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => null,
      );
      when(() => mockLocalStorage.setString(favoriteArticlesKey, mockJson))
          .thenAnswer(
        (_) async => false,
      );
      final call = dataSource.addFavoriteArticles;
      expect(
        () => call(mockModel),
        throwsA(const TypeMatcher<AddFavoriteArticlesException>()),
      );
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
    });
  });

  group('deleteFromFavoriteArticles', () {
    test(
        'should return a list of ArticleModel when info is removed successfully',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => mockJson,
      );
      when(() => mockLocalStorage.setString(favoriteArticlesKey, '[]'))
          .thenAnswer(
        (_) async => true,
      );
      final result = await dataSource.deleteFromFavoriteArticles(mockModel);
      expect(result, []);
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
    });

    test('should return an exception when info is not removed successfully',
        () async {
      when(() => mockLocalStorage.getString(favoriteArticlesKey)).thenAnswer(
        (_) async => mockJson,
      );
      when(() => mockLocalStorage.setString(favoriteArticlesKey, '[]'))
          .thenAnswer(
        (_) async => false,
      );
      final call = dataSource.deleteFromFavoriteArticles;
      expect(
        () => call(mockModel),
        throwsA(const TypeMatcher<DeleteFromFavoriteArticlesException>()),
      );
      verify(() => mockLocalStorage.getString(favoriteArticlesKey)).called(1);
    });
  });
}
