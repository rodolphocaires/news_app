import 'package:news_app/core/network_core/network_core.dart';
import 'package:news_app/features/top_articles_feature/top_articles_feature.dart';
import 'package:news_app/utils/apis.dart';
import 'package:news_app/utils/config.dart';

final topHeadlinesEndpoint =
    '$newsApi/top-headlines?apiKey=${Config.newsApiKey}&country=us';

abstract class ArticlesRemoteDatasource {
  Future<List<ArticleModel>> getTopHeadlines();
}

class ArticlesRemoteDatasourceImpl implements ArticlesRemoteDatasource {
  ArticlesRemoteDatasourceImpl(this.network);

  final HttpNetwork network;

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final response = await network.get(topHeadlinesEndpoint);
    if (response.statusCode == 200) {
      return (response.data['articles'] as List)
          .map((e) => ArticleModel.fromMap(e))
          .toList();
    }
    throw Exception('Failed to load data');
  }
}
