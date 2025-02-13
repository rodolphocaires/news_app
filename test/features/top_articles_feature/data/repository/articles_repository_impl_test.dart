import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockRemoteDataSource extends Mock implements ArticlesRemoteDatasource {}

class MockLocalDataSource extends Mock implements ArticlesLocalDatasource {}

void main() {
  late ArticlesRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = ArticlesRepositoryImpl(
      localDatasource: mockLocalDataSource,
      remoteDatasource: mockRemoteDataSource,
    );
  });

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

  group('getTopHeadlines', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockRemoteDataSource.getTopHeadlines())
          .thenAnswer((_) async => [mockModel]);
      final result = await repository.getTopHeadlines();
      expect(result.isRight, true);
      expect(result.right, [mockModel]);
      verify(() => mockRemoteDataSource.getTopHeadlines()).called(1);
    });
    test(
        'should return Result left when data source responds with an empty list',
        () async {
      when(() => mockRemoteDataSource.getTopHeadlines())
          .thenAnswer((_) async => []);
      final result = await repository.getTopHeadlines();
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<GetTopHeadlinesEmptyListFailure>());
      verify(() => mockRemoteDataSource.getTopHeadlines()).called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockRemoteDataSource.getTopHeadlines()).thenThrow(Exception());
      final result = await repository.getTopHeadlines();
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<GetTopHeadlinesCatchFailure>());
      verify(() => mockRemoteDataSource.getTopHeadlines()).called(1);
    });
  });

  group('getFavoriteArticles', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockLocalDataSource.getFavoriteArticles())
          .thenAnswer((_) async => [mockModel]);
      final result = await repository.getFavoriteArticles();
      expect(result.isRight, true);
      expect(result.right, [mockModel]);
      verify(() => mockLocalDataSource.getFavoriteArticles()).called(1);
    });
    test(
        'should return Result left when data source responds with an empty list',
        () async {
      when(() => mockLocalDataSource.getFavoriteArticles())
          .thenAnswer((_) async => []);
      final result = await repository.getFavoriteArticles();
      expect(result.isLeft, true);
      expect(result.left,
          const TypeMatcher<GetFavoriteArticlesEmptyListFailure>());
      verify(() => mockLocalDataSource.getFavoriteArticles()).called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with some exception',
        () async {
      when(() => mockLocalDataSource.getFavoriteArticles())
          .thenThrow(Exception());
      final result = await repository.getFavoriteArticles();
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<GetFavoriteArticlesCatchFailure>());
      verify(() => mockLocalDataSource.getFavoriteArticles()).called(1);
    });
  });

  group('addFavoriteArticles', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .thenAnswer((_) async => [mockModel]);
      final result = await repository.addFavoriteArticles(mockModel);
      expect(result.isRight, true);
      expect(result.right, [mockModel]);
      verify(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with AddFavoriteArticlesException',
        () async {
      when(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .thenThrow(AddFavoriteArticlesException());
      final result = await repository.addFavoriteArticles(mockModel);
      expect(result.isLeft, true);
      expect(
          result.left, const TypeMatcher<AddFavoriteArticlesNotAddedFailure>());
      verify(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with other exception',
        () async {
      when(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .thenThrow(Exception());
      final result = await repository.addFavoriteArticles(mockModel);
      expect(result.isLeft, true);
      expect(result.left, const TypeMatcher<AddFavoriteArticlesCatchFailure>());
      verify(() => mockLocalDataSource.addFavoriteArticles(mockModel))
          .called(1);
    });
  });

  group('deleteFromFavoriteArticles', () {
    test('should return Result right when data source responds successfully',
        () async {
      when(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .thenAnswer((_) async => [mockModel]);
      final result = await repository.deleteFromFavoriteArticles(mockModel);
      expect(result.isRight, true);
      expect(result.right, [mockModel]);
      verify(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with AddFavoriteArticlesException',
        () async {
      when(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .thenThrow(DeleteFromFavoriteArticlesException());
      final result = await repository.deleteFromFavoriteArticles(mockModel);
      expect(result.isLeft, true);
      expect(result.left,
          const TypeMatcher<DeleteFromFavoriteArticlesNotRemovedFailure>());
      verify(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .called(1);
    });
    test(
        'should return Result left when data source responds unsuccessfully with other exception',
        () async {
      when(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .thenThrow(Exception());
      final result = await repository.deleteFromFavoriteArticles(mockModel);
      expect(result.isLeft, true);
      expect(result.left,
          const TypeMatcher<DeleteFromFavoriteArticlesCatchFailure>());
      verify(() => mockLocalDataSource.deleteFromFavoriteArticles(mockModel))
          .called(1);
    });
  });
}
