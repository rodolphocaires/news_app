import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockRepository extends Mock implements ArticlesRepository {}

void main() {
  late GetTopHeadlinesImpl usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetTopHeadlinesImpl(mockRepository);
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
    when(() => mockRepository.getTopHeadlines())
        .thenAnswer((_) async => const Right([mockEntity]));
    final result = await usecase();
    expect(result.isRight, true);
    expect(result.right, [mockEntity]);
    verify(
      () => mockRepository.getTopHeadlines(),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return left when request runs unsuccessfully', () async {
    when(() => mockRepository.getTopHeadlines())
        .thenAnswer((_) async => Left(GetTopHeadlinesCatchFailure()));
    final result = await usecase();
    expect(result.isRight, false);
    expect(result.left, const TypeMatcher<GetTopHeadlinesCatchFailure>());
    verify(
      () => mockRepository.getTopHeadlines(),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
