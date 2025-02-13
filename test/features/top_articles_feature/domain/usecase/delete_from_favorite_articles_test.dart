import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockRepository extends Mock implements ArticlesRepository {}

class MockFavoriteArticlesStream extends Mock
    implements FavoriteArticlesStream {}

void main() {
  late DeleteFromFavoriteArticlesImpl usecase;
  late MockRepository mockRepository;
  late MockFavoriteArticlesStream mockFavoriteArticlesStream;

  setUp(() {
    mockRepository = MockRepository();
    mockFavoriteArticlesStream = MockFavoriteArticlesStream();
    usecase = DeleteFromFavoriteArticlesImpl(
      repository: mockRepository,
      favoriteArticlesStream: mockFavoriteArticlesStream,
    );
  });

  const mockEntity = ArticleEntity(
    author: 'author',
    title: 'title',
    description: 'description',
    url: 'url',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
  );

  test('should return a list when request runs successfully', () async {
    when(() => mockRepository.deleteFromFavoriteArticles(mockEntity))
        .thenAnswer((_) async => const Right([mockEntity]));
    final result = await usecase(mockEntity);
    expect(result.isRight, true);
    expect(result.right, [mockEntity]);
    verify(
      () => mockRepository.deleteFromFavoriteArticles(mockEntity),
    ).called(1);
    verify(
      () => mockFavoriteArticlesStream.updateArticles([mockEntity]),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should not call stream mock when result is left', () async {
    when(() => mockRepository.deleteFromFavoriteArticles(mockEntity))
        .thenAnswer(
            (_) async => Left(DeleteFromFavoriteArticlesNotRemovedFailure()));
    final result = await usecase(mockEntity);
    expect(result.isRight, false);
    expect(result.left,
        const TypeMatcher<DeleteFromFavoriteArticlesNotRemovedFailure>());
    verify(
      () => mockRepository.deleteFromFavoriteArticles(mockEntity),
    ).called(1);
    verifyNever(
      () => mockFavoriteArticlesStream.updateArticles([mockEntity]),
    );
    verifyNoMoreInteractions(mockRepository);
  });
}
