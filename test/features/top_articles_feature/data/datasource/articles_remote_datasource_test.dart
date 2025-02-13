import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/network_core/network_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockHttp extends Mock implements HttpNetwork {}

void main() {
  late ArticlesRemoteDatasourceImpl dataSource;
  late MockHttp mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttp();
    dataSource = ArticlesRemoteDatasourceImpl(mockHttpClient);
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

  final mockResponseJson = {
    'articles': [(mockModel.toMap())]
  };

  group('getTopHeadlines', () {
    dotenv.testLoad(fileInput: '''NEWS_API_KEY=api''');
    test('should return a bool value when the response code is success',
        () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => NetworkResponse(
          data: mockResponseJson,
          statusCode: 200,
        ),
      );
      final result = await dataSource.getTopHeadlines();
      expect(result, [mockModel]);
      verify(() => mockHttpClient.get(any())).called(1);
      verifyNever(() => mockHttpClient.post(any()));
      verifyNever(() => mockHttpClient.put(any()));
    });

    test(
        'should throw a Exception when the response code is different from a success result',
        () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => NetworkResponse(
          data: '',
          statusCode: 500,
        ),
      );
      final call = dataSource.getTopHeadlines;
      expect(
        () => call(),
        throwsA(const TypeMatcher<Exception>()),
      );
      verify(() => mockHttpClient.get(any())).called(1);
      verifyNever(() => mockHttpClient.post(any()));
      verifyNever(() => mockHttpClient.put(any()));
    });
  });
}
