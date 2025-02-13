import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/background_worker_core/background_worker_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';

class MockGetHeadlinesGroupedBySource extends Mock
    implements GetHeadlinesGroupedBySource {}

class MockBackgroundWorkerClient extends Mock
    implements BackgroundWorkerClient {}

void main() {
  late StartBackgroundFetchImpl usecase;
  late MockGetHeadlinesGroupedBySource mockGetHeadlinesGroupedBySource;
  late MockBackgroundWorkerClient mockBackgroundWorkerClient;

  setUp(() {
    mockGetHeadlinesGroupedBySource = MockGetHeadlinesGroupedBySource();
    mockBackgroundWorkerClient = MockBackgroundWorkerClient();
    usecase = StartBackgroundFetchImpl(
      backgroundWorkerClient: mockBackgroundWorkerClient,
      getHeadlinesGroupedBySource: mockGetHeadlinesGroupedBySource,
    );
  });

  dotenv.testLoad(fileInput: '''BACKGROUND_FETCH_INTERVAL_SECONDS=60''');

  test('should return a list when request runs successfully', () async {
    when(() => mockBackgroundWorkerClient.startWorker(
          secondsInterval: any(named: 'secondsInterval'),
          onBackgroundTask: any(named: 'onBackgroundTask'),
        )).thenAnswer((_) async => Future.value());
    await usecase((_) {});
    verify(() => mockBackgroundWorkerClient.startWorker(
          secondsInterval: any(named: 'secondsInterval'),
          onBackgroundTask: any(named: 'onBackgroundTask'),
        )).called(1);
  });
}
