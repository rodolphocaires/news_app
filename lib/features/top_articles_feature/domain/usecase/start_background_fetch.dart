import 'package:news_app/core/background_worker_core/background_worker_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/config.dart';

abstract class StartBackgroundFetch {
  Future<void> call(
    void Function(List<SourceArticlesEntity> updates) updateArticlesStream,
  );
}

class StartBackgroundFetchImpl implements StartBackgroundFetch {
  StartBackgroundFetchImpl({
    required this.getHeadlinesGroupedBySource,
    required this.backgroundWorkerClient,
  });

  final GetHeadlinesGroupedBySource getHeadlinesGroupedBySource;
  final BackgroundWorkerClient backgroundWorkerClient;

  @override
  Future<void> call(
    void Function(List<SourceArticlesEntity> updates) updateArticlesStream,
  ) async {
    backgroundWorkerClient.startWorker(
      secondsInterval: Config.backgroundFetchInterval,
      onBackgroundTask: () async {
        final articles = await getHeadlinesGroupedBySource();
        if (articles.isRight) {
          updateArticlesStream(articles.right);
        }
      },
    );
  }
}
