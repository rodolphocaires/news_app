import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockGetTopHeadlines extends Mock implements GetTopHeadlines {}

void main() {
  late GetHeadlinesGroupedBySourceImpl usecase;
  late MockGetTopHeadlines mockGetTopHeadlines;

  setUp(() {
    mockGetTopHeadlines = MockGetTopHeadlines();
    usecase = GetHeadlinesGroupedBySourceImpl(mockGetTopHeadlines);
  });

  const mockEntity = ArticleEntity(
    author: 'author',
    title: 'title',
    description: 'description',
    url: 'url',
    urlToImage: 'urlToImage',
    publishedAt: 'publishedAt',
    content: 'content',
    sourceId: 'sourceId',
    sourceName: 'sourceName',
  );

  const mockSource = SourceArticlesEntity(
    id: 'sourceId',
    name: 'sourceName',
    articles: [mockEntity],
  );

  test('should return Right when request runs successfully', () async {
    when(() => mockGetTopHeadlines())
        .thenAnswer((_) async => const Right([mockEntity]));
    final result = await usecase();
    expect(result.isRight, true);
    expect(result.right, [mockSource]);
    verify(() => mockGetTopHeadlines()).called(1);
  });

  test('should return Left when request runs unsuccessfully', () async {
    when(() => mockGetTopHeadlines())
        .thenAnswer((_) async => Left(GetTopHeadlinesEmptyListFailure()));
    final result = await usecase();
    expect(result.isRight, false);
    expect(result.left, const TypeMatcher<GetTopHeadlinesEmptyListFailure>());
    verify(() => mockGetTopHeadlines()).called(1);
  });
}
